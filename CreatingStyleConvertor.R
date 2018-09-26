#LOAD CHOOSEN DOCUMENT FOR EDIT
setwd("D:/Program Files/Theorem Factory/choice")
selected_style_document <- scan("selected_style_document.txt", what="character", sep=" ")
selected_type_style <- scan("selected_type_style.txt", what="character", sep=" ")
name_ofnewdocstyle <- scan("name_ofnewdocstyle.txt", what="character", sep=" ")

selected_style_document <- selected_style_document[3]
selected_type_style <- selected_type_style[3]
name_ofnewdocstyle <- name_ofnewdocstyle[3]

setwd("D:/Program Files/Theorem Factory/text_input_documents")
text_literature <- readLines(selected_style_document)

setwd("D:/Program Files/Theorem Factory/style_converter")
list_of_journals <- readLines("list_of_journals.txt")

detect_type_journal <- mapply(grep,list_of_journals,text_literature)

detected_type <- names(which(detect_type_journal==1))

detected_type_together <- gsub("\\.","",detected_type)
detected_type_together <- gsub(" ","",detected_type_together)


setwd("D:/Program Files/Theorem Factory/style_converter/MT_journals")
MT_journal_style <- readLines(paste("MT_",detected_type_together,".txt",sep =""))
text_literature <- sub(detected_type, "undotable",text_literature)
text_literature <- unlist(strsplit(text_literature,"\""))
text_literature <- unlist(strsplit(text_literature,","))
text_literature <- unlist(strsplit(text_literature,":"))
text_literature <- unlist(strsplit(text_literature,"\\("))
text_literature <- unlist(strsplit(text_literature,"\\)"))
text_literature <- unlist(strsplit(text_literature,"\\."))

MT_journal_style <- unlist(strsplit(MT_journal_style,"\""))
MT_journal_style <- unlist(strsplit(MT_journal_style,","))
MT_journal_style <- unlist(strsplit(MT_journal_style,":"))
MT_journal_style <- unlist(strsplit(MT_journal_style,"\\("))
MT_journal_style <- unlist(strsplit(MT_journal_style,"\\)"))
MT_journal_style <- unlist(strsplit(MT_journal_style,"\\."))

text_literature <- text_literature[which(text_literature!=" ")]
MT_journal_style <- MT_journal_style[which(MT_journal_style!=" ")]
MT_journal_style <- gsub(" ", "",MT_journal_style)

text_literature <- as.list(text_literature)
names(text_literature) <- MT_journal_style

text_literature[which(names(text_literature)!="paper")] <- gsub(" ", "", text_literature[which(names(text_literature)!="paper")])

text_literature[which(text_literature=="undotable")] <- sub("undotable",detected_type,text_literature[which(text_literature=="undotable")])

way_of_styles <- paste("D:/Program Files/Theorem Factory/style_converter/style_templates/",selected_type_style,sep ="")
setwd(way_of_styles)

if (grepl("full article", selected_type_style)) {oneortwo <- "1"} else {oneortwo <- "2"} 

name_translated_style <- paste(detected_type_together,"_in_",detected_type_together,oneortwo,".txt",sep ="")

readed_translated_style <- readLines(name_translated_style)

write.table(readed_translated_style, "D:/Program Files/Theorem Factory/choice/name_readed_translated_style.txt")

readed_translated_style2 <- readed_translated_style

#READ SELFSTYLIZING FILE
setwd("D:/Program Files/Theorem Factory/self_adjustable")


self_stylizing <-readLines("SelfStylizing.txt")
head_self_stylizing <- c("setwd(\"D:/Program Files/Theorem Factory/choice\")","readed_translated_style <- scan(\"name_readed_translated_style.txt\",what=\"character\", sep=\" \")")
neck_self_stylizing <-c("readed_translated_style <- readed_translated_style[3]")
leg_self_stylizing <- paste("readed_translated_style <- sub(\"",names(text_literature),"\",\"",text_literature,"\",","readed_translated_style)",sep ="")
heel_self_stylizing <- c("setwd(\"D:/Program Files/Theorem Factory/text_output_documents\")",paste("nameofoutput <- ","\"",name_ofnewdocstyle,"\""))
second_heel_self_stylizing <-c("nameofoutput <- gsub(\" \",\"\",nameofoutput)","nameofoutput <- paste(nameofoutput,\".txt\",sep = \"\")")
third_heel_self_stylizing <- c("fileConn4<-file(nameofoutput)","writeLines(readed_translated_style, fileConn4)","close(fileConn4)")
common_self_stylizing <-c(head_self_stylizing,neck_self_stylizing,leg_self_stylizing,heel_self_stylizing,second_heel_self_stylizing,third_heel_self_stylizing)

#Write SELFSTYLIZING FILE

setwd("D:/Program Files/Theorem Factory")
fileConn3<-file("SelfStylizing.R")
writeLines(common_self_stylizing, fileConn3)
close(fileConn3)

