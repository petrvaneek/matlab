function rx = ch_sfn_channel(tx, chCfg, sfnCfg, snrDb)
% chCfg.type: 'EPA'|'EVA'|'ETU'|'TDL-C' ...
% sfnCfg = struct('enable',true,'delaySamp',200,'attenLin',0.8)
    Fs = chCfg.Fs;  fc = chCfg.fc;  v = chCfg.speedKmh;
    fd = (v/3.6)*fc/3e8;

    switch upper(chCfg.type)
        case {'EPA','EVA','ETU'}
            [tau,g] = lteDLChannelProfile(chCfg.type); % helper dole
            ch = comm.RayleighChannel('SampleRate',Fs,'PathDelays',tau,...
                 'AveragePathGains',g,'MaximumDopplerShift',fd);
            y = ch(tx);
        case {'TDL-A','TDL-C','TDL-E'}
            ch = nrTDLChannel; ch.DelayProfile = chCfg.type;
            ch.SampleRate = Fs; ch.CarrierFrequency=fc; ch.MaximumDopplerShift=fd;
            y = ch(tx);
        otherwise
            y = tx;
    end

    if isfield(sfnCfg,'enable') && sfnCfg.enable
        d = sfnCfg.delaySamp; a = sfnCfg.attenLin;
        y2 = [zeros(d,1); y(1:end-d)] * a;
        y  = y + y2;
    end

    rx = awgn(y, snrDb, 'measured');
end

function [tau,g] = lteDLChannelProfile(name)
    switch upper(name)
        case 'EPA'
            tau=[0 30 70 90 110 190 410]*1e-9; g=[0 -1 -2 -3 -8 -17.2 -20.8];
        case 'EVA'
            tau=[0 30 150 310 370 710 1090 1730]*1e-9; g=[0 -1.5 -1.4 -3.6 -0.6 -9.1 -7 -12];
        case 'ETU'
            tau=[0 50 120 200 230 500 1600 2300 5000]*1e-9; g=[-1 -1 -1 0 0 0 -3 -5 -7];
        otherwise, tau=0; g=0;
    end
end
