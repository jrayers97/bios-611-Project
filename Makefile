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

figures/federalRev-against-state.png: edited_data/df_tidied.csv Code/tidy_states_all.R source_data/states_all.csv
	Rscript Code/tidy_states_all.R

figures/NC-year-grade.png: Code/plots-for-hw.R source_data/states_all.csv
	Rscript Code/plots-for-hw.R


#Build the final report for the project
writeup.pdf: figures/federalRev-against-state.png
	pdflatex writeup.tex

report.pdf: figures/federalRev-against-state.png
	R -e "rmarkdown::render(\"writeup.Rmd\", output_format=\"pdf_document\")"
