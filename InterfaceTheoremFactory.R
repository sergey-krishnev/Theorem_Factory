library(gWidgets)
library(gWidgetstcltk)
options(guiToolkit="tcltk")

#��������� � ������� ����������
setwd("D:/Program Files/Theorem Factory/input_documents")
input_files <-dir()
#������ ���������� ����
win <- gbasicdialog("Theorems Creator v.0.2 by Sergey Krishnev",visible = F,do.buttons=FALSE)
#���������� ������� ������
cred_group <- ggroup(container = win)
#�������� ���������
mysqlgr <- gframe("Functors",container = cred_group,horizontal = F)
glabel("Choose the document:",container = mysqlgr)
functor <- gcombobox(input_files, container=mysqlgr)
#�������� ���������
gagroup <- gframe("Relations",container = cred_group,horizontal = F)
glabel("Choose the document:",container = gagroup)
relation <- gcombobox(input_files, container = gagroup)
#�������� T-������
tchoosemodel <- gframe("T-model",container = cred_group,horizontal = F)
glabel("Choose the document:",container = tchoosemodel)
tmodel <- gcombobox(input_files, container = tchoosemodel)

#����� ���� ���������
article_group <- ggroup(container = win)
#����� ����� ������ ������
choosenamearticle <- gframe("Name of new document",container = article_group,horizontal = F)
glabel("Write the name (without extension):",container = choosenamearticle)
namearticle <- gedit("", container = choosenamearticle)

#������ Start
  gbutton("Create the theorems!", container = win,handler = function(h,...) {
  selected_functor <- svalue(functor)
  write.table(selected_functor, "D:/Program Files/Theorem Factory/choice/selected_functor.txt")
  selected_relation <- svalue(relation)
  write.table(selected_relation, "D:/Program Files/Theorem Factory/choice/selected_relation.txt")
  selected_tmodel <- svalue(tmodel)
  write.table(selected_tmodel, "D:/Program Files/Theorem Factory/choice/selected_tmodel_template.txt")
  nameofarticle <- svalue(namearticle)
  write.table(nameofarticle, "D:/Program Files/Theorem Factory/choice/nameofarticle.txt")
  gmessage(paste0("Theorems are created!"))
  setwd("D:/Program Files/Theorem Factory")
  source("SelfAdjustable.R")
  source("CreatingTableTheorem.R")
})
#������ Cancel
gbutton("Cancel", container = win,handler = function(h,...) {
  dispose(win)
})
#�������� ����
visible(win, set = T)