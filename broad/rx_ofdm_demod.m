function [rxGrid, hest, nest, rxDataSym, rxDataHest] = rx_ofdm_demod(enbDL, rxWave, dataMask, cec)
%RX_OFDM_DEMOD  OFDM demodulace + (volitelně) odhad kanálu a extrakce datových RE
%   dataMask: logická [Nsc x Nsym] – kde jsou data (PMCH bez RS).
%             Pokud je prázdná/nezadaná, funkce jen demoduluje (bez extrakce).
%   cec: cfg pro lteDLChannelEstimate (volitelné; default: konzervativní)

    if nargin < 3, dataMask = []; end
    if nargin < 4
        cec = struct('PilotAverage','UserDefined','FreqWindow',13,'TimeWindow',9, ...
                     'InterpType','cubic','InterpWindow','Centered','InterpWinSize',1);
    end

    fprintf('\nPerforming OFDM demodulation...\n\n');
    rxGrid = lteOFDMDemodulate(enbDL, rxWave);

    % Odhad kanálu (použij stejnou mřížku – v CAS je to OK; pro PMCH později nahradíš RS patternem)
    try
        [hest, nest] = lteDLChannelEstimate(enbDL, cec, rxGrid);
    catch
        % Pokud máš vlastní piloty (MBSFN-RS analog), dej sem své indexy a referenční symboly.
        warning('lteDLChannelEstimate failed or no pilots available. Returning perfect/noisy estimates.');
        hest = ones([size(rxGrid), 1]); nest = 0;
    end

    rxDataSym = []; rxDataHest = [];
    if ~isempty(dataMask)
        % dataMask je 2D; rozšiř na dimenze mřížky (předpoklad 1 Tx anténa)
        mask = repmat(dataMask, [1 1 size(rxGrid,3)]);
        rxDataSym  = rxGrid(mask);
        rxDataHest = hest(mask);
    end
end
