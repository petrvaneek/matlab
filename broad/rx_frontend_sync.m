function [downsampled, enbCAS, ofdmInfo] = rx_resample_cas(rxIQ, FsIn)
%RX_RESAMPLE_CAS  Úvodní CAS downsampling na NDLRB=6 (LTE Toolbox)
%   [downsampled, enbCAS, ofdmInfo] = rx_resample_cas(rxIQ, FsIn)
%   - nastaví CAS konfiguraci (NDLRB=6, Normal CP),
%   - zjistí cílovou Fs z lteOFDMInfo(enbCAS),
%   - převede vstupní IQ na tuhle Fs do proměnné "downsampled".
%
%   Vstup:
%     rxIQ   ... [Nsamp x Nant] komplexní vektor(y) I/Q
%     FsIn   ... vstupní vzorkovací frekvence (Hz)
%   Výstup:
%     downsampled ... převedený signál na cílovou Fs
%     enbCAS      ... CAS enb struktura (NDLRB=6, Normal CP)
%     ofdmInfo    ... info z lteOFDMInfo (obsahuje SamplingRate, Nfft, CP délky, ...)

    arguments
        rxIQ (:,:) {mustBeNumeric}
        FsIn (1,1) double {mustBePositive}
    end

    % 1) CAS konfigurace (robustní šířka pásma 6 PRB)
    enbCAS = struct();
    enbCAS.NDLRB        = 6;
    enbCAS.CyclicPrefix = 'Normal';
    enbCAS.DuplexMode   = 'FDD';
    enbCAS.CellRefP     = 1;
    enbCAS.NCellID      = 0;

    % 2) Cílová Fs z LTE OFDM info
    ofdmInfo = lteOFDMInfo(enbCAS);
    FsTar    = ofdmInfo.SamplingRate;

    % 3) Převzorkování (resample) → "downsampled"
    if abs(FsIn - FsTar) > 1  % rozdíl > 1 Hz → resamplujeme
        if FsIn < FsTar
            warning('The received signal sampling rate (%.3f Ms/s) is lower than the desired rate for NDLRB=6 (%.3f Ms/s).',
                    FsIn/1e6, FsTar/1e6);
        end
        fprintf('\nResampling from %.3f Ms/s to %.3f Ms/s ...\n', FsIn/1e6, FsTar/1e6);
        [p,q] = rat(FsTar/FsIn, 1e-12);  % přesný racionální poměr
        downsampled = zeros(ceil(size(rxIQ,1)*p/q), size(rxIQ,2));
        for ant = 1:size(rxIQ,2)
            downsampled(:,ant) = resample(rxIQ(:,ant), p, q);
        end
    else
        fprintf('\nResampling not required; input Fs matches NDLRB=6 (%.3f Ms/s).\n', FsIn/1e6);
        downsampled = rxIQ;
    end
end
