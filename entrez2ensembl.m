function ensID =  entrez2ensembl(entrez, ID_conversion_names)

ix = find(strcmp(ID_conversion_names.EntrezGeneID, entrez));
ensID = ID_conversion_names.EnsemblTranscriptID(ix);

end