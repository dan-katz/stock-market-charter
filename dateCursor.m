%Dan Katz Lab LI
%ES-2 Final Project
function dateCursorText = dateCursor(obj,event_obj)
%Purpose: dataCursorText changes the text displayed by the data cursor
%to date format from date number format

%Position of data cursor is obtained
pos = get(event_obj,'Position');

%Date cursor text is set as date string at chosen point and share price 
%at chosen point
dateCursorText = {['Date: ', datestr(pos(1))],['Price: $',num2str(pos(2),4)]};
end