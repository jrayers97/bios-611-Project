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
	Rscript Code/plots-for-NC.R

figures/states_revenue.png: .created-dirs edited_data/df_tidied.csv Code/tidy_states_all.R source_data/states_all.csv
	Rscript Code/tidy_states_all.R

figures/NC_year_avg_math.png: .created-dirs Code/plots-for-NC.R source_data/states_all.csv
	Rscript Code/plots_for_NC.R

figures/US_scatterplot.png: .created-dirs Code/basic_plots.R source_data/states_all.csv
	Rscript Code/basic_plots.R

figures/NE_hist.png: .created-dirs Code/basic_plots.R source_data/states_all.csv
	Rscript Code/basic_plots.R

figures/PCA_0.png: .created-dirs Code/PCA_No_Impute.R source_data/states_all.csv
	Rscript Code/PCA_No_Impute.R

figures/PCA_Impute.png: .created-dirs Code/PCA_With_Impute.R source_data/states_all.csv
	Rscript Code/PCA_With_Impute.R

figures/PCA_NE_Impute.png: .created-dirs Code/NE_PCA.R source_data/states_all.csv
	Rscript Code/NE_PCA.R

figures/NE_Exp_Year.png: .created-dirs Code/NE_Exp_Year.R source_data/states_all.csv
	Rscript Code/NE_Exp_Year.R

figures/US_M411.png: .created-dirs Code/US_total_exp.R source_data/states_all.csv
	Rscript Code/US_total_exp.R

figures/US_M_811.png: .created-dirs Code/US_total_exp.R source_data/states_all.csv
	Rscript Code/US_total_exp.R

figures/US_mEnroll.png: .created-dirs Code/US_total_exp.R source_data/states_all.csv
	Rscript Code/NE_Exp_Year.R

figures/US_texp11.png: .created-dirs Code/US_total_exp.R source_data/states_all.csv
	Rscript Code/US_total_exp.R

figures/mean_money.png: .created-dirs Code/US_total_exp.R source_data/states_all.csv
	Rscript Code/US_total_exp.R

#Build the final report for the project
writeup.pdf: figures/NC_year_grade.png figures/states_revenue.png figures/NC_year_avg_math.png figures/NC_year_grade.png figures/US_scatterplot.png figures/NE_hist.png figures/PCA_0.png figures/PCA_Impute.png figures/PCA_NE_Impute.png figures/NE_Exp_Year.png figures/US_M411.png figures/US_M_811.png figures/US_mEnroll.png figures/US_texp11.png figures/mean_money.png
	pdflatex writeup.tex

report.pdf: figures/NC_year_grade.png figures/states_revenue.png figures/NC_year_avg_math.png figures/NC_year_grade.png figures/US_scatterplot.png figures/NE_hist.png figures/PCA_0.png figures/PCA_Impute.png figures/PCA_NE_Impute.png figures/NE_Exp_Year.png figures/US_M_411.png figures/US_M_811.png figures.US_mEnroll.png figures/US_texp11.png
	R -e "rmarkdown::render(\"writeup.Rmd\", output_format=\"pdf_document\")"
