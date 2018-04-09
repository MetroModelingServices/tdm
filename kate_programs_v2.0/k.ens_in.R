# k.ens_in.R
# pulls ensembles in XLSX format into R


enssheet <- readxl::read_xlsx(proj.inputs, "ensembles") # loads all data in spreadsheet into a temporary data frame
ensnames <- colnames(enssheet[2:ncol(enssheet),])       # determine how many vectors are in spreadsheet
ensnames <- ensnames[-1]                                # removes first element (TAZ field) from vector

for (i in 1:length(ensnames)) {
  assign(paste("ensemble.",ensnames[i],sep=''), readXLSXvector(proj.inputs,ensnames[i],spreadsheetName="ensembles"))
}

rm (ensnames)
