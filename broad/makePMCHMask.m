function dataMask = makePMCHMask(enb, ctrlSymbols, rsCombK, rsCombL)
%MAKEPMCHMASK  Vytvoří logickou masku RE pro PMCH data v MBSFN subframu
% dataMask: [Nsc x Nsym] (na 1 Tx anténu)
% enb:   LTE struct (NDLRB, CyclicPrefix='Extended' pro PMCH, DuplexMode, NCellID…)
% ctrlSymbols: kolik prvních OFDM symbolů je "control region" (typ. 2 nebo 3)
% rsCombK: krok v subnosičích (např. 6) – dočasný hřebínek MBSFN-RS
% rsCombL: krok v čase (např. 4) – dočasný hřebínek MBSFN-RS

    arguments
        enb struct
        ctrlSymbols (1,1) double {mustBeInteger, mustBePositive} = 2
        rsCombK (1,1) double {mustBeInteger, mustBePositive} = 6
        rsCombL (1,1) double {mustBeInteger, mustBePositive} = 4
    end

    % Rozměry DL mřížky (viz DownlinkLTEWaveformModelingExample)
    gridSize = lteDLResourceGridSize(enb);  % [Nsc, Nsym, Nant]
    Nsc   = gridSize(1);
    Nsym  = gridSize(2);

    % 1) Základ: vše povoleno
    dataMask = true(Nsc, Nsym);

    % 2) Zakázat "non-MBSFN" control region (prvních ctrlSymbols)
    cs = min(ctrlSymbols, Nsym);   % ochrana
    dataMask(:, 1:cs) = false;

    % 3) (Volitelně) zakázat i PBCH/PCFICH/PDCCH/CRS, pokud bys masku použil
    %    v ne-MBSFN subframech. Příklad jak:
    %{
    % CRS
    crsIdx = lteCellRSIndices(enb,'1based');           % indexy CRS (1-D)
    [r,c,~] = ind2sub([Nsc Nsym enb.CellRefP], crsIdx); % na 1 Tx portu
    dataMask(sub2ind([Nsc Nsym], r, c)) = false;
    % PBCH
    pbchIdx = ltePBCHIndices(enb,'1based');
    [r,c] = ind2sub([Nsc Nsym], pbchIdx);
    dataMask(sub2ind([Nsc Nsym], r, c)) = false;
    % PDCCH/PCFICH… (analogicky)
    %}

    % 4) Dočasné MBSFN-RS: jednoduchý comb na anténním portu 4
    %    (pozn.: tohle je dočasný vzor; nahraď ho spec-přesným patternem)
    k0 = 1; l0 = cs+1;             % začneme na 1. subnosiči a 1. MBSFN symbolu
    k = k0:rsCombK:Nsc;
    l = l0:rsCombL:Nsym;
    [KK,LL] = ndgrid(k,l);
    rsLin = sub2ind([Nsc Nsym], KK(:), LL(:));
    dataMask(rsLin) = false;

    % 5) Hotovo – dataMask říká, kam smíš mapovat PMCH data
end
