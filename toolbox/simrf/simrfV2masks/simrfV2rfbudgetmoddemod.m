function simrfV2rfbudgetmoddemod(block,action)









    switch(action)
    case 'simrfInit'
        top_sys=bdroot(block);

        if strcmpi(top_sys,'rfBudgetAnalyzer_lib')
            return
        end


        MaskVals=get_param(block,'MaskValues');
        idxMaskNames=simrfV2getblockmaskparamsindex(block);

        if strcmpi(MaskVals{idxMaskNames.ConverterType},'Up')
            Conn1Port='IF';
            Conn2Port='RF';
        else
            Conn1Port='RF';
            Conn2Port='IF';
        end
        repBlkFullPath=find_system(block,'LookUnderMasks',...
        'all','FollowLinks','on','SearchDepth',1,'Name',...
        'Conn1');
        if~isempty(repBlkFullPath)
            set_param([block,'/Conn1'],'Name',Conn1Port);
            set_param([block,'/Conn2'],'Name',Conn2Port);
        end

        IRFilter=sprintf('Ideal\nImage Reject');
        CSFilter=sprintf('Ideal\nChannel Select');

        isSetFilters=false;
        isNewFromLib=false;
        if(~any(strcmpi(get_param(top_sys,'SimulationStatus'),...
            {'running','paused'})))
            if(strcmpi(MaskVals{idxMaskNames.SetFilters},'on'))
                isSetFilters=true;


                set_param(block,'SetFilters','off')
            end



            repBlkFullPath=find_system(block,'LookUnderMasks',...
            'all','FollowLinks','on','SearchDepth',1,'Name',...
            IRFilter);
            if(~isempty(repBlkFullPath))
                userData=get_param(repBlkFullPath{1},'UserData');
                if((isfield(userData,'initIRFilter'))&&...
                    (userData.initIRFilter))
                    isNewFromLib=true;


                    userData.initIRFilter=false;
                    set_param(repBlkFullPath{1},'UserData',userData);
                end
            end
        end
        if(isSetFilters||isNewFromLib)


            set_param([block,'/Mixer'],...
            'Source_linear_gain','Available power gain',...
            'linear_gain',MaskVals{idxMaskNames.linear_gain},...
            'linear_gain_unit','dB',...
            'Zin',MaskVals{idxMaskNames.Zin},...
            'Zout',MaskVals{idxMaskNames.Zout},...
            'NF',MaskVals{idxMaskNames.NF},...
            'Source_Poly','Even and odd order',...
            'IPType','Output',...
            'IP2','Inf',...
            'IP2_unit','dBm',...
            'IP3',MaskVals{idxMaskNames.IP3},...
            'IP3_unit','dBm')
            set_param([block,'/LO'],...
            'CWSourceType','Ideal voltage',...
            'IVoltage','1',...
            'CarrierFreq',MaskVals{idxMaskNames.LOFreq},...
            'CarrierFreq_unit',MaskVals{idxMaskNames.LOFreq_unit})


            MaskEnables=get_param(block,'MaskEnables');
            if strcmpi(MaskVals{idxMaskNames.IRFilterOnInit},'off')
                set_param(block,'IRFilterOn','off')
                MaskEnables{idxMaskNames.IRFilterOn}='off';
            end
            if strcmpi(MaskVals{idxMaskNames.CSFilterOnInit},'off')
                set_param(block,'CSFilterOn','off')
                MaskEnables{idxMaskNames.CSFilterOn}='off';
            end
            MaskVals=get_param(block,'MaskValues');
            set_param(block,'MaskEnables',MaskEnables);


            repBlkFullPath=find_system(block,'LookUnderMasks',...
            'all','FollowLinks','on','SearchDepth',1,'Name',...
            IRFilter);
            if(strcmpi(MaskVals{idxMaskNames.IRFilterOn},'on')&&...
                ~isempty(repBlkFullPath))
                set_param([block,'/',IRFilter],...
                'DataSource','Network-parameters',...
                'Paramtype','S-parameters',...
                'Sparam',MaskVals{idxMaskNames.SparamIR},...
                'SparamFreq',MaskVals{idxMaskNames.SparamFreqIR},...
                'SparamFreq_unit',...
                MaskVals{idxMaskNames.SparamFreqIR_unit},...
                'SparamRepresentation','Frequency domain',...
                'AutoImpulseLength','off',...
                'ImpulseLength','0',...
                'AddNoise','off',...
                'SparamZ0','50')
            end
            repBlkFullPath=find_system(block,'LookUnderMasks',...
            'all','FollowLinks','on','SearchDepth',1,'Name',...
            CSFilter);
            if(strcmpi(MaskVals{idxMaskNames.CSFilterOn},'on')&&...
                ~isempty(repBlkFullPath))
                set_param([block,'/',CSFilter],...
                'DataSource','Network-parameters',...
                'Paramtype','S-parameters',...
                'Sparam',MaskVals{idxMaskNames.SparamCS},...
                'SparamFreq',MaskVals{idxMaskNames.SparamFreqCS},...
                'SparamFreq_unit',...
                MaskVals{idxMaskNames.SparamFreqCS_unit},...
                'SparamRepresentation','Frequency domain',...
                'AutoImpulseLength','off',...
                'ImpulseLength','0',...
                'AddNoise','off',...
                'SparamZ0','50')
            end
        end



        if((isSetFilters||isNewFromLib)||...
            ~isempty(regexpi(get_param(top_sys,'SimulationStatus'),...
            '^(updating|initializing)$')))

            repBlkFullPath=find_system(block,'LookUnderMasks',...
            'all','FollowLinks','on','SearchDepth',1,'Name',...
            IRFilter);
            if strcmpi(MaskVals{idxMaskNames.IRFilterOn},'on')
                if isempty(repBlkFullPath)

                    posSparamBlk=...
                    get_param('simrfV2elements/S-parameters',...
                    'Position');
                    posSparamBlk_dx=posSparamBlk(3)-posSparamBlk(1);
                    posSparamBlk_dy=posSparamBlk(4)-posSparamBlk(2);
                    posConn1Blk=get_param([block,'/',Conn1Port],...
                    'Position');
                    phConn1Blk=get_param([block,'/',Conn1Port],...
                    'PortHandles');
                    simrfV2deletelines(get(phConn1Blk.RConn,'Line'));
                    posMixerBlk=get_param([block,'/Mixer'],'Position');
                    posConn1Blk_y_mid=(posConn1Blk(2)+posConn1Blk(4))/2;
                    posConn1Blk_x_mid=(posConn1Blk(1)+posConn1Blk(3))/2;
                    Blks_halfway=(-posConn1Blk(1)+posMixerBlk(1))/2;
                    add_block('simrfV2elements/S-parameters',...
                    [block,'/',IRFilter],...
                    'DataSource','Network-parameters',...
                    'Paramtype','S-parameters',...
                    'Sparam',MaskVals{idxMaskNames.SparamIR},...
                    'SparamFreq',MaskVals{idxMaskNames.SparamFreqIR},...
                    'SparamFreq_unit',...
                    MaskVals{idxMaskNames.SparamFreqIR_unit},...
                    'SparamRepresentation','Frequency domain',...
                    'AutoImpulseLength','off',...
                    'ImpulseLength','0',...
                    'AddNoise','off',...
                    'SparamZ0','50',...
                    'Position',[posConn1Blk_x_mid-...
                    posSparamBlk_dx/2+Blks_halfway...
                    ,posConn1Blk_y_mid-posSparamBlk_dy/2...
                    ,posConn1Blk_x_mid+posSparamBlk_dx/2+...
                    Blks_halfway,posConn1Blk_y_mid+...
                    posSparamBlk_dy/2]);



                    userData=get_param([block,'/',IRFilter],'UserData');
                    userData.initIRFilter=false;
                    set_param([block,'/',IRFilter],'UserData',userData);
                    simrfV2connports(struct('SrcBlk',IRFilter,...
                    'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                    'DstBlk','Mixer','DstBlkPortStr',...
                    'LConn','DstBlkPortIdx',1),block);
                    simrfV2connports(struct('SrcBlk',IRFilter,...
                    'SrcBlkPortStr','LConn','SrcBlkPortIdx',1,...
                    'DstBlk',Conn1Port,'DstBlkPortStr','RConn',...
                    'DstBlkPortIdx',1),block);
                end
            else
                if~isempty(repBlkFullPath)


                    phIRBlk=get_param(repBlkFullPath,'PortHandles');

                    simrfV2deletelines(get(phIRBlk{1}.LConn,'Line'));

                    simrfV2deletelines(get(phIRBlk{1}.RConn,'Line'));
                    delete_block(repBlkFullPath);
                    simrfV2connports(struct('SrcBlk',Conn1Port,...
                    'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                    'DstBlk','Mixer','DstBlkPortStr',...
                    'LConn','DstBlkPortIdx',1),block);
                end
            end


            repBlkFullPath=find_system(block,'LookUnderMasks',...
            'all','FollowLinks','on','SearchDepth',1,'Name',...
            CSFilter);
            if strcmpi(MaskVals{idxMaskNames.CSFilterOn},'on')
                if isempty(repBlkFullPath)

                    posSparamBlk=...
                    get_param('simrfV2elements/S-parameters',...
                    'Position');
                    posSparamBlk_dx=posSparamBlk(3)-posSparamBlk(1);
                    posSparamBlk_dy=posSparamBlk(4)-posSparamBlk(2);
                    posConn2Blk=get_param([block,'/',Conn2Port],...
                    'Position');
                    phConn2Blk=get_param([block,'/',Conn2Port],...
                    'PortHandles');
                    simrfV2deletelines(get(phConn2Blk.RConn,'Line'));
                    posMixerBlk=get_param([block,'/Mixer'],'Position');
                    posConn2Blk_y_mid=(posConn2Blk(2)+posConn2Blk(4))/2;
                    posConn2Blk_x_mid=(posConn2Blk(1)+posConn2Blk(3))/2;
                    Blks_halfway=(-posMixerBlk(3)+posConn2Blk(3))/2;
                    add_block('simrfV2elements/S-parameters',...
                    [block,'/',CSFilter],...
                    'DataSource','Network-parameters',...
                    'Paramtype','S-parameters',...
                    'Sparam',MaskVals{idxMaskNames.SparamCS},...
                    'SparamFreq',MaskVals{idxMaskNames.SparamFreqCS},...
                    'SparamFreq_unit',...
                    MaskVals{idxMaskNames.SparamFreqCS_unit},...
                    'SparamRepresentation','Frequency domain',...
                    'AutoImpulseLength','off',...
                    'ImpulseLength','0',...
                    'AddNoise','off',...
                    'SparamZ0','50',...
                    'Position',[posConn2Blk_x_mid-...
                    posSparamBlk_dx/2-Blks_halfway...
                    ,posConn2Blk_y_mid-posSparamBlk_dy/2...
                    ,posConn2Blk_x_mid+posSparamBlk_dx/2-...
                    Blks_halfway,posConn2Blk_y_mid+...
                    posSparamBlk_dy/2]);
                    simrfV2connports(struct('SrcBlk',CSFilter,...
                    'SrcBlkPortStr','LConn','SrcBlkPortIdx',1,...
                    'DstBlk','Mixer','DstBlkPortStr',...
                    'RConn','DstBlkPortIdx',1),block);
                    simrfV2connports(struct('SrcBlk',CSFilter,...
                    'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                    'DstBlk',Conn2Port,'DstBlkPortStr','RConn',...
                    'DstBlkPortIdx',1),block);
                end
            else
                if~isempty(repBlkFullPath)


                    phCSBlk=get_param(repBlkFullPath,'PortHandles');

                    simrfV2deletelines(get(phCSBlk{1}.LConn,'Line'));

                    simrfV2deletelines(get(phCSBlk{1}.RConn,'Line'));
                    delete_block(repBlkFullPath);
                    simrfV2connports(struct('SrcBlk',Conn2Port,...
                    'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                    'DstBlk','Mixer','DstBlkPortStr',...
                    'RConn','DstBlkPortIdx',1),block);
                end
            end
        end

    case 'simrfDelete'

    case 'simrfCopy'

    case 'simrfDefault'

    end

end