# k.corridors_in.R
# pulls corridors in XLSX format into R


corrssheet <- readxl::read_xlsx(proj.inputs, "corridors") # loads all data in spreadsheet into a temporary data frame
corrsnames <- colnames(corrssheet[2:ncol(corrssheet),])   # determine how many vectors are in spreadsheet
corrsnames <- corrsnames[-1]                              # removes first element (TAZ field) from vector

for (i in 1:length(corrsnames)) {
  assign(paste("corridor.",corrsnames[i],sep=''), readXLSXvector(proj.inputs,corrsnames[i],spreadsheetName="corridors"))
}

rm (corrsnames)
