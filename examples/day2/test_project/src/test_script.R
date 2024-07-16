INPUT_PATH = "./data"
OUTPUT_PATH = "./output"

input_file = file(file.path(INPUT_PATH, "input.txt"))
input_text = readLines(input_file)
close(input_file)

output_file = file(file.path(OUTPUT_PATH, "output.txt"))
writeLines(toupper(input_text), output_file)
close(output_file)