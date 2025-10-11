function [grid, dataMask, dataIdx] = tx_buildGrid(enb, modSym)
% vytvoří DL mřížku a naplní ji symboly jen tam, kde dataMask==true
    grid = lteDLResourceGrid(enb,1);
    dataMask = makePMCHMask(enb, 2, 6, 4);     % ctrl=2, demo pilot comb 6x4
    dataIdx  = find(dataMask);
    grid(dataIdx) = modSym(1:numel(dataIdx));
end
