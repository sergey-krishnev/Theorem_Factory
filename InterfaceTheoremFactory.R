library(gWidgets)
library(gWidgetstcltk)
options(guiToolkit="tcltk")

#переходим в рабочую директорию
setwd("D:/Program Files/Theorem Factory/input_documents")
input_files <-dir()
#Строим диалоговое окно
win <- gbasicdialog("Theorems Creator v.0.2 by Sergey Krishnev",visible = F,do.buttons=FALSE)
#Группируем учетные данные
cred_group <- ggroup(container = win)
#Документ функторов
mysqlgr <- gframe("Functors",container = cred_group,horizontal = F)
glabel("Choose the document:",container = mysqlgr)
functor <- gcombobox(input_files, container=mysqlgr)
#Документ отношений
gagroup <- gframe("Relations",container = cred_group,horizontal = F)
glabel("Choose the document:",container = gagroup)
relation <- gcombobox(input_files, container = gagroup)
#Документ T-модели
tchoosemodel <- gframe("T-model",container = cred_group,horizontal = F)
glabel("Choose the document:",container = tchoosemodel)
tmodel <- gcombobox(input_files, container = tchoosemodel)

#Новый блок программы
article_group <- ggroup(container = win)
#Выбор имени набора теорем
choosenamearticle <- gframe("Name of new document",container = article_group,horizontal = F)
glabel("Write the name (without extension):",container = choosenamearticle)
namearticle <- gedit("", container = choosenamearticle)

#Кнопка Start
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
#Кнопка Cancel
gbutton("Cancel", container = win,handler = function(h,...) {
  dispose(win)
})
#Включаем окно
visible(win, set = T)