.PHONY: clean
.PHONY: d3-vis
.PHONY: visualization

clean:
	rm -rf edited_data
	rm -rf figures
	rm -rf .created-dirs #can't add an empty directory into git
	rm -rf writeup.pdf

.created-dirs:
	mkdir -p figures
	mkdir -p edited_data
	touch .created-dirs

edited_data/df_tidied.csv: .created-dirs Code/tidy_states_all.R source_data/states_all.csv
	Rscript Code/tidy_states_all.R

figures/NC-year-grade.png: Code/plots-for-NC.R source_data/states_all.csv
	Rscript Code/plots-for-NC.R

figures/states-revenue.png: edited_data/df_tidied.csv Code/tidy_states_all.R source_data/states_all.csv
	Rscript Code/tidy_states_all.R

figures/NC-year-avg-math.png: Code/plots-for-NC.R source_data/states_all.csv
	Rscript Code/plots-for-NC.R

#Build the final report for the project
writeup.pdf: figures/NC-year-grade.png figures/states-revenue.png figures/NC-year-avg-math.png
	pdflatex writeup.tex

report.pdf: figures/NC-year-grade.png figures/states-revenue.png
	R -e "rmarkdown::render("writeup.Rmd", output_format="pdf_document")"
