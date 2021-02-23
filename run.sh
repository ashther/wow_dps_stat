#!/usr/lib64/R/bin/Rscript
library(RSQLite)
library(dplyr)

wcl <- wow::WCL$new()
wcl$get_report('n', n = 500)
saveRDS(wcl, 'wcl_n.rds')
# wcl <- wow::WCL$new()
# wcl$get_report('m', n = 300)
# saveRDS(wcl, 'wcl_m.rds')

con <- dbConnect(SQLite(), 'wcl.sqlite')
report <- tidyr::unnest(wcl$report, report) %>% 
  select(-id_page, -time_death) %>% 
  mutate(talent = purrr::map_chr(talent, ~ tryCatch({
    paste0(.x$value, collapse = ',')
  }, error = function(e) NA_character_)))
dbWriteTable(con, 'report', report, row.names = FALSE, append = TRUE)
dbDisconnect(con)

Sys.setenv(RSTUDIO_PANDOC='/usr/lib/rstudio-server/bin/pandoc')
rmarkdown::render('index.Rmd', output_dir = 'docs', quiet = FALSE)
system('git add *')
system("git commit -m 'update data'")
system('git push')
