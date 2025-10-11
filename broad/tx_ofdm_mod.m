function [txWave, ofdmInfo] = tx_ofdm_mod(enb, grid, mode, rollFrac)
%TX_OFDM_MOD  OFDM modulace + (volitelně) WOLA
%   mode     : 'lte' (lteOFDMModulate) | 'custom' (TODO)
%   rollFrac : podíl z min(CP) pro WOLA (např. 1/8). Pokud <=0, WOLA se neaplikuje.

    if nargin < 3 || isempty(mode), mode = 'lte'; end
    if nargin < 4 || isempty(rollFrac), rollFrac = 0; end   % <- default: WOLA OFF

    switch lower(mode)
        case 'lte'
            [txWave, infoLte] = lteOFDMModulate(enb, grid);
            oi = lteOFDMInfo(enb);                 % kvůli SamplingRate
            ofdmInfo = infoLte;
            ofdmInfo.SamplingRate = oi.SamplingRate;
            ofdmInfo.SampleRate   = oi.SamplingRate;  % alias
            cpLens = double(ofdmInfo.CyclicPrefixLengths);
            nfft   = double(ofdmInfo.Nfft);
        case 'custom'
            error('custom OFDM: doplň konfiguraci comm.OFDMModulator a ofdmInfo.');
        otherwise
            error('mode must be ''lte'' or ''custom''.');
    end

    % WOLA jen pokud rollFrac > 0
    if rollFrac > 0
        roll = max(1, floor(min(cpLens) * rollFrac));
        txWave = wolaWindow(txWave, cpLens, nfft, roll);
    end
end
