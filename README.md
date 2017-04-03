# Coursera "Getting and Cleaning Data" Final Project

This is the repository for my final project of the course. Here you can find

- `CodeBook.md` - explanation of variables and procedure to generate the tidy dataset
- `run_analysis.R` - the R script responsible for generating the tidy dataset
- `tidy_dataset.txt` - the tidy dataset itself, exported using `write.table` function

In order to run the script use the command

```shell
Rscript run_analysis.R
```

If the script is unable to find the UCI dataset zip file it will download the dataset from the internet.
