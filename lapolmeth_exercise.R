# LAPolMeth practical exercise
# Text classification using an LLM API

library(httr2)
library(jsonlite)

# Short text samples
texts <- data.frame(
  id = 1:4,
  text = c(
    "Many migrants arriving in the city report difficulties finding formal employment despite having previous work experience.",
    "Residents support expanding public transportation because long commuting times limit access to jobs and education.",
    "Some citizens express concern that local government institutions do not respond effectively to reports of neighborhood crime.",
    "Farmers report that increasingly unpredictable rainfall is affecting crop production and household income."
  )
)

# Get API key from environment
api_key <- Sys.getenv("GEMINI_API_KEY")

if (api_key == "") {
  stop("GEMINI_API_KEY is not configured.")
}

# Put the four texts together
input_texts <- paste(
  paste0(texts$id, ". ", texts$text),
  collapse = "\n"
)

# Instructions for the model
prompt <- paste(
  "Classify each of the following texts into one category:",
  "Migration, Transportation, Security, or Environment.",
  "Return only a JSON array with the id and category.",
  "Example:",
  '[{"id":1,"category":"Migration"}]',
  "",
  input_texts
)

# Send the request to Gemini
req <- request(
  "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent"
) |>
  req_headers(`x-goog-api-key` = api_key) |>
  req_body_json(list(
    contents = list(
      list(parts = list(list(text = prompt)))
    )
  ))

resp <- req |>
  req_retry(max_tries = 5) |>
  req_perform()

# Read the model response
result <- resp_body_json(resp)
json_result <- result$candidates[[1]]$content$parts[[1]]$text

categories <- fromJSON(json_result)

# Add classifications to the original data
output <- merge(texts, categories, by = "id")

print(output)