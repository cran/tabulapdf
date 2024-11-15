## -----------------------------------------------------------------------------
library(tabulapdf)

# optional: set memory for Java
options(java.parameters = "-Xmx50m")

## -----------------------------------------------------------------------------
f <- system.file("examples", "mtcars.pdf", package = "tabulapdf")
extract_tables(f)

## -----------------------------------------------------------------------------
extract_tables(f, pages = 1)

## ----eval = FALSE-------------------------------------------------------------
#  f2 <- "https://raw.githubusercontent.com/ropensci/tabulapdf/main/inst/examples/mtcars.pdf"
#  extract_tables(f2, pages = 1)

## -----------------------------------------------------------------------------
# incorrect
extract_tables(f, pages = 2, method = "lattice")[[1]]

# correct
extract_tables(f, pages = 2, method = "stream")[[1]]

## -----------------------------------------------------------------------------
extract_tables(
  f,
  pages = c(2, 2),
  area = list(c(58, 125, 182, 488), c(387, 125, 513, 492)),
  guess = FALSE
)

## ----out.width = "100%", out.height = "30%", fig.cap = "Selecting areas for table extraction.", fig.alt = "Selected area in a table shown as a red rectangle with transparency over a simple table with black borders and text in white background.", echo = FALSE----
knitr::include_graphics("selectarea.png")

## -----------------------------------------------------------------------------
# manual selection, result transcribed below
# first_table <- locate_areas(f, pages = 2)[[1]]
# second_table <- locate_areas(f, pages = 2)[[1]]

first_table <- c(58.15032, 125.26869, 182.02355, 488.12966)
second_table <- c(387.7791, 125.2687, 513.7519, 492.3246)

extract_tables(f, pages = 2, area = list(first_table), guess = FALSE)
extract_tables(f, pages = 2, area = list(second_table), guess = FALSE)

## -----------------------------------------------------------------------------
f <- system.file("examples", "covid.pdf", package = "tabulapdf")

# this corresponds to page four in the original document
# locate_areas(f, pages = 1)

covid <- extract_tables(f,
  pages = 1, guess = FALSE, col_names = FALSE,
  area = list(c(140.75, 88.14, 374.17, 318.93))
)

covid <- covid[[1]]

colnames(covid) <- c("region", "treatments", "pct_increase")
covid$treatments <- as.numeric(gsub("\\.", "", covid$treatments))
covid$pct_increase <- as.numeric(
  gsub(",", ".", gsub("%", "", covid$pct_increase))
) / 100

covid

