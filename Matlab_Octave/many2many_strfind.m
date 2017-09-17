function positions = many2many_strfind(array, elements)
positions = [];
for i=1:numel(elements)
    if ~isempty(elements{i})
        matches = strfind(array,elements(i));
        positions = [positions find(~cellfun('isempty', matches))];
    end
end
