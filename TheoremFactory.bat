@echo off
d:
cd D:\Program Files\Theorem Factory\input_documents
copy /Y *tex "D:\Program Files\Theorem Factory\text_input_documents\*.txt"
cd D:\Program Files\Theorem Factory
Rscript ArticleAssistant.R