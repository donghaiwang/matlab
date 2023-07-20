function name=getcyclename(cycle)
    DriveCycleItems={

    getString(message('autoblks_shared:autoblkDriveCycleNames:FTP72'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:FTP75'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:US06'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:SC03'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:HWFET'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:NYCC'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:HUDDS'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:LA92'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:LA92Short'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:IM240'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:UDDS'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:WLTP1'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:WLTP2'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:WLTP3'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:ECE1'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:ECE4'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:EUDC'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:ECExtra'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:NEDC'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:ADAC'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:ArtemisU'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:ArtemisR'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:Artemis130'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:Artemis150'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:JC08'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:JC08Hot'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:Japanese10'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:Japanese15'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:Japanese1015'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:World'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:Braunschweig'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:Central'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:BusinessA'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:BusinessC'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:City'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:Neighborhood'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:NewY'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:NewYbus'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:Manhattan'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:HeavyCreep'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:HeavyTrans'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:HeavyCruise'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:Orange'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:West'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:RTS'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:ETC'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:JE05'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:CUEDCp'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:CUEDCspc'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:CUEDCdMC'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:CUEDCdNA'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:CUEDCdNB'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:dME'))
    getString(message('autoblks_shared:autoblkDriveCycleNames:CUEDCdNC'));...
    getString(message('autoblks_shared:autoblkDriveCycleNames:CUEDCdNCH'));...



    };
    DriveCycleNames={
    'cycleFTP72';...
    'cycleFTP75';...
    'cycleUS06';...
    'cycleSC03';...
    'cycleHWFET';...
    'cycleNYCC';...
    'cycleHUDDS';...
    'cycleLA92';...
    'cycleLA92Short';...
    'cycleIM240';...
    'cycleUDDS';...
    'cycleWLTP1';...
    'cycleWLTP2';...
    'cycleWLTP3';...
    'cycleECE15';...
    'cycleECE15Full';...
    'cycleEUDC';...
    'cycleECEUrbanLP';...
    'cycleNEDC';...
    'cycleADACBAB130';...
    'cycleArtUrb';...
    'cycleArtRR';...
    'cycleArtMw130';...
    'cycleArtMw150';...
    'cycleJC08';...
    'cycleJC08H';...
    'cycleJPN10';...
    'cycleJPN15';...
    'cycleJPN1015';...
    'cycleWHVC';...
    'cycleBraun';...
    'cycleCBD';...
    'cycleBACA';...
    'cycleBACC';...
    'cycleCSC';...
    'cycleNRTC';...
    'cycleNYComp';...
    'cycleNYBus';...
    'cycleManBus';...
    'cycleHHDDTCreep';...
    'cycleHHDDTTrans';...
    'cycleHHDDTCruise';...
    'cycleOCBus';...
    'cycleWVU5Peak';...
    'cycleRTS95';...
    'cycleETCFIGE4';...
    'cycleJE05';...
    'cycleCUEDCP';...
    'cycleCUEDCPS';...
    'cycleCUEDCMC';...
    'cycleCUEDCNA';...
    'cycleCUEDCNB';...
    'cycleCUEDCME';...
    'cycleCUEDCNC';...
    'cycleCUEDCNCH'};


    DriveCycleMap=containers.Map(DriveCycleItems,DriveCycleNames);
    name=DriveCycleMap(cycle);



end