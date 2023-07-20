function updateTitleFont(p)




    set(p.hTitleTop,...
    'Interpreter',p.TitleTopTextInterpreter,...
    'FontName',p.FontName,...
    'FontWeight',p.TitleTopFontWeight,...
    'FontSize',getTitleFontSize(p,'top'));

    set(p.hTitleBottom,...
    'Interpreter',p.TitleBottomTextInterpreter,...
    'FontName',p.FontName,...
    'FontWeight',p.TitleBottomFontWeight,...
    'FontSize',getTitleFontSize(p,'bottom'));
