%% main_run.m  — minimal loopback Tx→Rx (bez kanálu & bez WOLA, s LLR↔cw diagnostikou)
clear; clc; rng(1);

% ==== PRESET (lab: 10 MHz, Extended CP) ====
enb = struct('NDLRB',50, 'CyclicPrefix','Extended', 'DuplexMode','FDD', ...
             'CellRefP',1, 'NCellID',1, 'NSubframe',0);

mod   = 'QPSK';   % 'QPSK' | '16QAM' | '64QAM' | '256QAM'
rv    = 0;
TBlen = 2088;     % 2088 + 24 = 2112 (single CB bez fillerů)

% ==== Maska & počet bitů po rate-match ====
dataMask  = makePMCHMask(enb, 2, 6, 4);    % ctrl=2, demo pilot comb 6x4
switch upper(char(mod))
    case 'QPSK',   Mbits = 2;
    case '16QAM',  Mbits = 4;
    case '64QAM',  Mbits = 6;
    case '256QAM', Mbits = 8;
    otherwise, error('Neznámá modulace.');
end
E = nnz(dataMask) * Mbits;
assert(E>0,'Maska neobsahuje žádné datové RE!');

% ==== TX: FEC + map ====
tbBits = randi([0 1], TBlen, 1);
cw     = tx_fec_encode(tbBits, E, rv);          % CRC→seg→Turbo→rate-match
txSym  = lteSymbolModulate(cw, char(mod));
assert(numel(txSym)==nnz(dataMask), ...
    'numel(txSym)=%d, dataRE=%d', numel(txSym), nnz(dataMask));

% Map do gridu a OFDM (WOLA vypnutá: rollFrac=0)
[grid, dataMask, dataIdx] = tx_buildGrid(enb, txSym); %#ok<ASGLU>
[txWave, ofdmInfo] = tx_ofdm_mod(enb, grid, 'lte', 0);  % WOLA OFF

% ==== KANÁL: čistý loopback ====
rxWave = txWave;

% ==== RX: OFDM + extrakce dat ====
[rxGrid, hest, nest, rxDataSym] = rx_ofdm_demod(enb, rxWave, dataMask); %#ok<ASGLU>

% ==== DIAGNOSTIKA: Tx vs Rx symboly (v loopbacku ~0) ====
txDataSym      = txSym(:);
rxDataSym_chk  = rxDataSym(:);
fprintf('Δsym (RMS) = %.3e\n', rms(rxDataSym_chk - txDataSym));

% ==== LLR demodulace – LTE funkce (name-value syntax) ====
modChar  = char(mod);      % char pro LTE MEX
noiseVar = 1e-6;           % loopback → velmi malá variance

llr0 = lteSymbolDemodulate(rxDataSym, modChar, ...
                           'DecisionType','LLR', ...
                           'NoiseVariance', noiseVar);
llr0 = llr0(:);
assert(numel(llr0)==E, 'LLR length (%d) != E (%d)', numel(llr0), E);

% ==== Diagnostika LLR ↔ cw: vyber variantu LLR, která nejlépe sedí na TX bitstream ====
switch upper(modChar)
    case 'QPSK',   bitsPerSym = 2;
    case '16QAM',  bitsPerSym = 4;
    case '64QAM',  bitsPerSym = 6;
    case '256QAM', bitsPerSym = 8;
    otherwise, error('Neznámá modulace: %s', modChar);
end

% Obrácení pořadí bitů v rámci symbolu (MSB<->LSB) a pomocné funkce
reorderPerSym = @(v) reshape( flip( reshape(v, bitsPerSym, []), 1 ), [], 1 );
hd = @(v) uint8(v(:) > 0);  % hard decision z LLR (konvence: LLR>0 -> bit=1)

% Kandidáti LLR (znamenko/pořadí)
candLLR = { llr0, -llr0, reorderPerSym(llr0), reorderPerSym(-llr0) };

% Vytiskni shodu s cw (diagnostika)
agree = cellfun(@(v) mean(hd(v)==uint8(cw)), candLLR);
[bestAgree, idxAgree] = max(agree);
fprintf('LLR→bits shoda s cw: [%.3f %.3f %.3f %.3f] → best #%d (%.3f)\n', agree, idxAgree, bestAgree);

% ==== BRUTE-FORCE: zkusíme všechny 4 varianty u dekodéru a vezmeme tu s CRC=1 ====
crcFlags = false(1, numel(candLLR));
tbHats   = cell(1, numel(candLLR));
for i = 1:numel(candLLR)
    [tbHats{i}, crcFlags(i)] = rx_fec_decode(candLLR{i}, TBlen, rv);
    if crcFlags(i), break; end
end

idx = find(crcFlags, 1, 'first');
if isempty(idx)
    idx = idxAgree; % když žádná nedá CRC=1, vezmeme „nejpodobnější" kvůli BER výpisu
    fprintf('POZN.: žádná varianta LLR nedala CRC OK – zobrazuji BER pro best-LLR #%d.\n', idx);
else
    switch idx
        case 2, fprintf('INFO: Dekodér potřeboval LLR s invertovaným znaménkem.\n');
        case 3, fprintf('INFO: Dekodér potřeboval obrácené pořadí bitů v rámci symbolu.\n');
        case 4, fprintf('INFO: Dekodér potřeboval invertované znaménko + obrácené pořadí bitů.\n');
        otherwise, fprintf('INFO: Dekodér zvládl původní LLR (varianta #1).\n');
    end
end

tbHat = tbHats{idx};
crcOK = crcFlags(idx);

% ==== BER – bezpečné tvary a shodná délka ====
tbBits = uint8(tbBits(:));
tbHat  = uint8(tbHat(:));
L = min(numel(tbBits), numel(tbHat));
ber = mean(tbBits(1:L) ~= tbHat(1:L));

fprintf('CRC OK = %d\n', crcOK);   % 1 = prošlo, 0 = neprošlo
fprintf('BER (po FEC) ~ %.3g\n', ber);

% ==== Dál: jakmile CRC OK = 1, postupně zapínej realitu ====
% 1) AWGN:   rxWave = awgn(txWave, 30, 'measured');  -> znovu od LLR dál
% 2) Rayleigh EPA (bez SFN) přes ch_sfn_channel
% 3) SFN delay < CP
% 4) Nakonec zapni WOLA: v tx_ofdm_mod dej rollFrac = 1/8
