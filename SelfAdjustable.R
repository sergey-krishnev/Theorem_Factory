setwd("D:/Program Files/Theorem Factory/self_adjustable")
SACreatingTableTheorem <- readLines("CreatingTableTheorem.txt")

#Finding what t-model
setwd("D:/Program Files/Theorem Factory/choice")

selected_tmodel_template <- scan("selected_tmodel_template.txt", what="character", sep=" ")

selected_tmodel_template <- selected_tmodel_template[3]

selected_tmodel_template <- sub(".tex","",selected_tmodel_template)

selected_tmodel_template <- paste(selected_tmodel_template,".txt",sep ="")

setwd("D:/Program Files/Theorem Factory/text_input_documents")
table_tmodel_template <- readLines(selected_tmodel_template)

table_tmodel_template <- table_tmodel_template[(grep("begin\\{tabular\\}\\{\\|l\\|l\\|l\\|l\\|\\}",table_tmodel_template)+1):(grep("end\\{tabular\\}",table_tmodel_template)-1)] #table from tex

table_tmodel_template <- gsub("\t\t","",table_tmodel_template)
table_tmodel_template <- gsub("\\\\\\hline","",table_tmodel_template)
table_tmodel_template <- gsub("\\\\\\\\","",table_tmodel_template)
table_tmodel_template <- gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", table_tmodel_template, perl=TRUE) #removing extra spaces
table_tmodel_template <- gsub(" ","",table_tmodel_template)

tmodels <- data.frame( do.call( rbind, strsplit( table_tmodel_template[2:(length(table_tmodel_template))], "&" ) ) ) #create data.frame tmodels
names(tmodels) <-do.call( rbind, strsplit( table_tmodel_template[1], "&" ) )

Tmodels <- data.frame(lapply(tmodels, as.character), stringsAsFactors=FALSE)
Tmodels$PropertiesDelta <- strsplit(Tmodels$PropertiesDelta,",")
Tmodels$PropertiesX <- strsplit(Tmodels$PropertiesX,",")

PT <- paste(unlist(Tmodels$PropertiesTeta),collapse = "")
PD <- paste(unlist(Tmodels$PropertiesDelta),collapse = "")
PX <- paste(unlist(Tmodels$PropertiesX),collapse = "")
PTDX <- paste(PT,PD,PX,sep = "_")
WayOfTemplates <- paste("D:/Program Files/Theorem Factory/tmodel_templates/",PTDX,sep ="")
setwd(WayOfTemplates)
NamesTheoremasAndLemmas <- sub(".txt","",dir())
data_TAL <- unlist(lapply(dir(),readLines))

#Creating the replacement of code TAL
replace_code_TAL <- paste(" ",NamesTheoremasAndLemmas," = paste(",data_TAL,",sep = \"\")",sep ="")
replace_code_TAL[1:(length(replace_code_TAL)-1)] <- paste(replace_code_TAL[1:(length(replace_code_TAL)-1)],",",sep ="")
replace_code_TAL <- gsub("\\\\","\\\\\\\\",replace_code_TAL)

#Adjust the code
HeadTALIndex <- grep("TheoremsAndLemmas",SACreatingTableTheorem)
HeadTALIndex <- HeadTALIndex[1]
LegTALIndex <- grep("END OF THEOREMAS AND LEMMAS",SACreatingTableTheorem)-1

HeadOfCTT <- SACreatingTableTheorem[1:HeadTALIndex]
LegofCTT <- SACreatingTableTheorem[LegTALIndex:length(SACreatingTableTheorem)]
NewSACreatingTableTheorem <- c(HeadOfCTT,replace_code_TAL,LegofCTT)

setwd("D:/Program Files/Theorem Factory")
fileConn2<-file("CreatingTableTheorem.R")
writeLines(NewSACreatingTableTheorem, fileConn2)
close(fileConn2)