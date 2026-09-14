# LLM Text Classification in R

This exercise shows a simple example of using an LLM API from R to classify short text samples.

I used four texts related to social science topics and asked Gemini to classify each one into one of four categories: Migration, Transportation, Security, or Environment.

## Requirements

The script uses the following R packages:

- httr2
- jsonlite

They can be installed with:

install.packages(c("httr2", "jsonlite"))

## API key

The Gemini API key is stored as an environment variable, so it is not included directly in the R script.

Before running the script, the API key can be configured in R with:

Sys.setenv(GEMINI_API_KEY = "your_api_key")

## Running the script

Open `lapolmeth_exercise.R` in RStudio and run the script.

The code creates the text samples, sends them to Gemini through the API, and asks the model to return the classifications in JSON format. The JSON response is then converted into a DataFrame containing the original texts and their assigned categories.

## Limitation

LLM classifications may change depending on the wording of the prompt or the model being used. In a research project, I would validate a sample of the results against human-coded labels before applying the method to a larger dataset.