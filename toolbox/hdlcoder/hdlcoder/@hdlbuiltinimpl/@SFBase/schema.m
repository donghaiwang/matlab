function schema



    mlock;


    package=findpackage('hdlbuiltinimpl');
    parent=findclass(package,'EmlImplBase');

    package=findpackage('hdlbuiltinimpl');
    this=schema.class(package,'SFBase',parent);%#ok<NASGU>
end

