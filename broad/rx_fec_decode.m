function [tbHat, crcOK] = rx_fec_decode(llr, TBlen, rv)
%RX_FEC_DECODE  Rate-recover → Turbo decode → Code-block desegment → TB CRC
%   [tbHat, crcOK] = rx_fec_decode(llr, TBlen, rv)
%   llr   : sloupcový vektor LLR (double), délky E (po rate-match)
%   TBlen : délka transport bloku (bitů) PŘED TB-CRC (např. 2088)
%   rv    : redundancy version (0..3)

    % 0) tvar & typ
    llr = double(llr(:));

    % Stejný NIR jako na Tx (přes STRUCT — kompatibilní s tvou verzí)
    opts = struct('NIR', 3*6144);   % 18432

    % 1) inverse rate-matching
    recCoded = lteRateRecoverTurbo(llr, TBlen, rv, opts);

    % 2) turbo decode
    numIter = 8;
    decBits = lteTurboDecode(recCoded, numIter);

    % 3) code-block desegmentace
    tbWithCRC = lteCodeBlockDesegment(decBits, TBlen);

    % 4) TB CRC 24A — err==0 znamená OK → crcOK = true
    [tbHat, err] = lteCRCDecode(tbWithCRC, '24A');
    tbHat = uint8(tbHat(:));        % sloupec
    crcOK = ~logical(err);
end
