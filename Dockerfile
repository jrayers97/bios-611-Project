FROM rocker/verse
RUN Rscript --no-restore --no-save -e "install.packages('readxl')"
