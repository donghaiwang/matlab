function schema





    mlock;

    package=findpackage('hdlfilterblks');
    parent=findclass(package,'FIRDecimationHDLInstantiation');
    schema.class(package,'FIRDecimationPartlySerial',parent);
