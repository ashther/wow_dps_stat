#!/bin/bash
Rscript -e "wcl=wow::WCL$new();wcl$get_report(n=30);saveRDS(wcl, 'wcl.rds')"
Rscript -e "rmarkdown::render('index.Rmd', output_dir='docs', quiet=TRUE)"
git add *
git commit -m "update data"
git push