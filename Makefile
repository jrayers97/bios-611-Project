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

figures/NC_year_grade.png: .created-dirs Code/plots-for-NC.R source_data/states_all.csv
	Rscript Code/plots_for_NC.R

figures/states_revenue.png: .created-dirs edited_data/df_tidied.csv Code/tidy_states_all.R source_data/states_all.csv
	Rscript Code/tidy_states_all.R

figures/NC_year_avg_math.png: .created-dirs Code/plots-for-NC.R source_data/states_all.csv
	Rscript Code/plots_for_NC.R

#Build the final report for the project
writeup.pdf: figures/NC_year_grade.png figures/states_revenue.png figures/NC_year_avg_math.png
	pdflatex writeup.tex

report.pdf: figures/NC_year_grade.png figures/states_revenue.png
	R -e "rmarkdown::render(\"writeup.Rmd\", output_format=\"pdf_document\")"
