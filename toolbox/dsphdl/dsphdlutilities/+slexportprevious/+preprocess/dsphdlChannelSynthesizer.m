function dsphdlChannelSynthesizer(obj)




    ChannelSynthesizerBlock='dsphdlfiltering2/Channel Synthesizer';
    verobj=obj.ver;
    blocks=obj.findLibraryLinksTo(ChannelSynthesizerBlock);
    n2bReplaced=length(blocks);

    if n2bReplaced>0
        if isR2021bOrEarlier(verobj)


            for i=1:n2bReplaced
                blk=blocks{i};

                subsys_msg=get_param(blk,'MaskType');
                replaceWithEmptySubsystem(obj,blk,[],subsys_msg);
            end
        end
    end
end
