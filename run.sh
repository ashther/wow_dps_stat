#!/usr/lib64/R/bin/Rscript
wcl <- wow::WCL$new()
wcl$get_report(n = 10)
saveRDS(wcl, 'wcl.rds')
rmarkdown::render('index.Rmd', output_dir = 'docs/', quiet = TRUE)
system('git add *')
system("git commit -m 'update data'")
system('git push')
