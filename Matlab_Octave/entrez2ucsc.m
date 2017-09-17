function ucscID =  entrez2ucsc(entrez, ID_conversion_names)

ix = find(strcmp(ID_conversion_names.EntrezGeneID,entrez));
ucscID = ID_conversion_names.UCSCID(ix);

end
