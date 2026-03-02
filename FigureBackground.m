function FigureBackground(hex)
% Changes the current active figure background to the specified hex code.
% Alternatively, an input of 'light' simply changes the theme to light and
% an input of 'dark' changes the background to '393939'.
if ~isequal(hex(1),'#') && ~isequal(hex,'light') && ~isequal(hex,'dark')
    hex = cat(2,'#',hex);
end
if isequal(hex,'light')
    theme('light')
elseif isequal(hex,'dark')
    FigureBackground('393939')
else
    theme('dark')
    set(gcf,"Color",hex)
    set(findall(gcf,'type','axes'),'Color',hex)
end
set(gcf,'InvertHardcopy','off')
end