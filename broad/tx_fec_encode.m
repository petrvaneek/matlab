function cw = tx_fec_encode(tbBits, E, rv)
% TB→CRC(24A)→CodeBlock segmentace→Turbo(1/3)→RateMatch (NIR sjednocen přes struct)
%
% tbBits : transport block bity (před TB-CRC)
% E      : počet bitů po rate-match
% rv     : redundancy version (0..3)

    % 36.212: TB CRC
    tbCRC = lteCRCEncode(tbBits,'24A');

    % Code-block segmentace
    cbs   = lteCodeBlockSegment(tbCRC);

    % Turbo kódování (1/3)
    coded = lteTurboEncode(cbs);

    % === DŮLEŽITÉ: sjednocený soft buffer (NIR) — přes STRUCT (tvoje verze TB to chce) ===
    opts = struct('NIR', 3*6144);   % 18432 soft bitů

    % Rate matching
    cw    = lteRateMatchTurbo(coded, E, rv, opts);
end
