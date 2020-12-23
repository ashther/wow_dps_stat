#!/usr/lib64/R/bin/Rscript
# wcl <- wow::WCL$new()
# wcl$get_report(n = 30)
# saveRDS(wcl, 'wcl.rds')
Sys.setenv(RSTUDIO_PANDOC='/usr/lib/rstudio-server/bin/pandoc')
rmarkdown::render('index.Rmd', output_dir = 'docs', quiet = FALSE)
system('git add *')
system("git commit -m 'update data'")
system('git push')
