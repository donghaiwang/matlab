function jmaab_jc_0806

    rec=Advisor.Utils.getDefaultCheckObject('mathworks.jmaab.jc_0806',true,[],'None');
    rec.setLicense({styleguide_license});

    mdladvRoot=ModelAdvisor.Root;
    mdladvRoot.publish(rec,{sg_maab_group,sg_jmaab_group});

end
