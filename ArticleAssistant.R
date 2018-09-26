library(gWidgets)
library(gWidgetstcltk)
options(guiToolkit="tcltk")
#Строим диалогое окно
win_AA <- gbasicdialog("Article Assistant v.0.2",visible = F,do.buttons=FALSE)
#Группируем учетные данные
AA_group <- ggroup(container = win_AA)
#Кнопка Style Convertor
SC_gframe <- gframe("Style Converter",container = AA_group,horizontal = F)
gbutton("START THE CREATION", container = SC_gframe,handler = function(h,...) {
  setwd("D:/Program Files/Theorem Factory")
  source("InterfaceStyleConvertor.R")
})
#Кнопка Theorems Creator
TC_gframe <- gframe("Theorems Creator",container = AA_group,horizontal = F)
gbutton("START THE CREATION", container = TC_gframe,handler = function(h,...) {
  setwd("D:/Program Files/Theorem Factory")
  source("InterfaceTheoremFactory.R")
  dispose(win_AA)
})
#Включаем окно
visible(win_AA, set = T)