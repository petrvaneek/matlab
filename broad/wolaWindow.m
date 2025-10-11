function y = wolaWindow(x, cpLens, nFFT, roll)
%WOLAWINDOW  Windowed OverLap-Add pro OFDM (CP-OFDM)
%   y = wolaWindow(x, cpLens, nFFT, roll)
%   x       ... časová vlna: [CP+Nfft][CP+Nfft]...
%   cpLens  ... vektor délek CP (samples) pro KAŽDÝ OFDM symbol
%   nFFT    ... délka IFFT/FFT (samples, bez CP)
%   roll    ... délka náběhu/doběhu okna (samples), typ. ~ 1/8 CP
%
%   Pozn.: roll musí být <= min(cpLens)

    arguments
        x (:,1) {mustBeNumeric}
        cpLens (:,1) {mustBeInteger, mustBeNonnegative}
        nFFT (1,1)  {mustBeInteger, mustBePositive}
        roll (1,1)  {mustBeInteger, mustBeNonnegative}
    end

    % --- typy na double kvůli cos/sin ---
    cpLens = double(cpLens);
    nFFT   = double(nFFT);
    roll   = double(roll);

    if any(cpLens < roll)
        error('wolaWindow:RollTooLong', ...
            'roll (%d) musí být <= min(CP) (%d).', roll, min(cpLens));
    end

    y = complex(zeros(size(x), 'like', x));
    inIdx  = 1;
    outIdx = 1;

    for s = 1:numel(cpLens)
        Ns = cpLens(s) + nFFT;                 % délka [CP+symbol]
        if inIdx+Ns-1 > numel(x), break; end

        seg = x(inIdx:inIdx+Ns-1);

        if roll > 0
            % raised-cosine okno (double výpočty, typ výstupu jako x)
            w = ones(Ns,1,'like',x);
            n = (0:roll-1).'; n = double(n);
            w(1:roll)           = cast(0.5*(1 - cos(pi*(n+1)/(roll+1))), 'like', x);
            w(end-roll+1:end)   = cast(0.5*(1 - cos(pi*(roll - n)/(roll+1))), 'like', x);
            seg = seg .* w;
        end

        if s == 1
            y(outIdx:outIdx+Ns-1) = seg;
            outIdx = outIdx + (Ns - roll);
        else
            % overlap-add v délce 'roll'
            y(outIdx-roll:outIdx-1) = y(outIdx-roll:outIdx-1) + seg(1:roll);
            y(outIdx:outIdx+Ns-roll-1) = seg(roll+1:end);
            outIdx = outIdx + (Ns - roll);
        end

        inIdx = inIdx + Ns;
        if outIdx > numel(y), break; end
    end
end
