function errorOpenCircuit(block)





    pere=bdroot(block);
    block=strrep(block,char(10),' ');
    block=strrep(block,pere,'');
    block=block(2:end);
    message=['In mask of ''',block,''' block:',char(10),'The specified parameters result in an open-circuit.'];
    Erreur.message=message;
    Erreur.identifier='SpecializedPowerSystems:BlockParameterError';
    psberror(Erreur);