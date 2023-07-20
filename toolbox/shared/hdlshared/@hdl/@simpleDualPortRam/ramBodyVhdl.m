function str=ramBodyVhdl(this,clk,ce,di,wa,we,ra,rdo)








    str=[...
    'ARCHITECTURE rtl OF ',this.entityName,' IS\n'...
    ,'\n'...
    ];


    if this.dataIsComplex
        dipt=['std_logic_vector(',num2str(di(1).Width*2-1),' DOWNTO 0)'];
    elseif di.Width>1
        dipt=['std_logic_vector(',num2str(di.Width-1),' DOWNTO 0)'];
    else
        dipt='std_logic';
    end

    str=[str...
    ,'  TYPE ram_type IS ARRAY (',num2str(2^wa.Width-1),' DOWNTO 0) of ',dipt,';\n'...
    ,'\n'...
    ];


    if sum([di.Width])==1
        s1='''';
    else
        s1='"';
    end
    z=[s1,repmat('0',1,sum([di.Width])),s1];

    str=[str...
    ,'  -- Signals\n'...
    ,sprintf('%2s%-38s%s','','SIGNAL ram',[': ram_type := (OTHERS => ',z,');\n'])...
    ,sprintf('%2s%-38s%s','','SIGNAL data_int',[': ',dipt,' := ',z,';\n'])...
    ];



    swa=strrep(wa.PortType,'std_logic_vector','unsigned');
    sra=strrep(ra.PortType,'std_logic_vector','unsigned');

    str=[str...
    ,sprintf('%2s%-38s%s','','SIGNAL addr_a',[': ',swa,';\n'])...
    ,sprintf('%2s%-38s%s','','SIGNAL addr_b',[': ',sra,';\n'])...
    ];




    if this.isStdLogicIn
        s2={'unsigned(',')'};
    else
        s2={'',''};
    end

    str=[str...
    ,'\n'...
    ,'BEGIN\n'...
    ,'\n'...
    ,['  addr_a <= ',s2{1},wa.Name,s2{2},';\n']...
    ,['  addr_b <= ',s2{1},ra.Name,s2{2},';\n']...
    ,'\n'...
    ];

    if this.hasClkEn==1
        indent=2;
        s3={[blanks(6),'IF ',ce.Name,' = ''1'' THEN\n'],[blanks(6),'END IF;\n']};
    else
        indent=0;
        s3={'',''};
    end


    if(di(1).Width>1)&&~this.isStdLogicIn
        si={'std_logic_vector(',')'};
    else
        si={'',''};
    end


    if(rdo(1).Width>1)&&~this.isStdLogicOut
        sc=char(regexp(rdo(1).PortType,'.*(?=\()','match'));
        so={[sc,'('],')'};
    else
        so={'',''};
    end

    if~this.dataIsComplex
        s4=[si{1},di.Name,si{2}];
        s7='';
        s8='';
    else
        s4=[si{1},di(1).Name,si{2},' & ',si{1},di(2).Name,si{2}];
        [s7,s8]=this.getVectorSlice(rdo(1).Width);
    end

    procLabel=hdlgetparameter('clock_process_label');
    if hdlgetparameter('clockedge')==0
        clock_str=['    IF ',clk.Name,'''event AND ',clk.Name,' = ''1'' THEN\n'];
    else
        clock_str=['    IF ',clk.Name,'''event AND ',clk.Name,' = ''0'' THEN\n'];
    end

    str=[str...
    ,'  ',this.entityName,procLabel,' : PROCESS (',clk.Name,')\n'...
    ,'  BEGIN\n'...
    ,clock_str,...
    s3{1}...
    ,[blanks(indent+6),'IF ',we.Name,' = ''1'' THEN\n']...
    ,[blanks(indent+6),'  ram(to_integer(addr_a)) <= ',s4,';\n']...
    ,[blanks(indent+6),'END IF;\n']...
    ,[blanks(indent+6),'data_int <= ram(to_integer(addr_b));\n']...
    ,s3{2}...
    ,'    END IF;\n'...
    ,'  END PROCESS ',this.entityName,procLabel,';\n'...
    ,'\n'...
    ,'  ',rdo(1).Name,' <= ',so{1},'data_int',s7,so{2},';\n'...
    ];

    if this.dataIsComplex
        str=[str...
        ,'  ',rdo(2).Name,' <= ',so{1},'data_int',s8,so{2},';\n'...
        ];
    end

    str=[str...
    ,'\n'...
    ,'END rtl;\n'...
    ,'\n'...
    ];


