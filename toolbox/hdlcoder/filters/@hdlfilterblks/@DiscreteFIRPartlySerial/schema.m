function schema






    mlock;

    package=findpackage('hdlfilterblks');
    parent=findclass(package,'DiscreteFIRFilterHDLInstantiation');
    schema.class(package,'DiscreteFIRPartlySerial',parent);
