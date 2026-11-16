#!/bin/bash

# Script to extract a chapter from a PDF by page range
# Usage: ./pdf_extract_chapter.sh input.pdf -f first_page -l last_page output.pdf

# Check if at least input file is provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <input.pdf> -f <first_page> -l <last_page> <output.pdf>"
  echo "Example: $0 book.pdf -f 10 -l 25 chapter1.pdf"
  exit 1
fi

# Get input file as first argument
INPUT_PDF="$1"
shift

# Initialize variables
FIRST_PAGE=""
LAST_PAGE=""

# Parse command line options
while getopts "f:l:" opt; do
  case $opt in
  f)
    FIRST_PAGE="$OPTARG"
    ;;
  l)
    LAST_PAGE="$OPTARG"
    ;;
  \?)
    echo "Invalid option: -$OPTARG" >&2
    exit 1
    ;;
  :)
    echo "Option -$OPTARG requires an argument." >&2
    exit 1
    ;;
  esac
done

# Shift to get remaining arguments (output.pdf)
shift $((OPTIND - 1))

if [ "$#" -ne 1 ] || [ -z "$FIRST_PAGE" ] || [ -z "$LAST_PAGE" ]; then
  echo "Usage: $0 <input.pdf> -f <first_page> -l <last_page> <output.pdf>"
  echo "Example: $0 book.pdf -f 10 -l 25 chapter1.pdf"
  exit 1
fi

OUTPUT_PDF="$1"

# Check if input file exists
if [ ! -f "$INPUT_PDF" ]; then
  echo "Error: Input file '$INPUT_PDF' not found"
  exit 1
fi

# Validate page numbers
if ! [[ "$FIRST_PAGE" =~ ^[0-9]+$ ]] || ! [[ "$LAST_PAGE" =~ ^[0-9]+$ ]]; then
  echo "Error: Page numbers must be positive integers"
  exit 1
fi

if [ "$FIRST_PAGE" -gt "$LAST_PAGE" ]; then
  echo "Error: First page must be less than or equal to last page"
  exit 1
fi

# Create temporary directory for individual pages
TEMP_DIR=$(mktemp -d)
echo "Creating temporary directory: $TEMP_DIR"

# Extract pages using pdfseparate
echo "Extracting pages $FIRST_PAGE to $LAST_PAGE from $INPUT_PDF..."
pdfseparate -f "$FIRST_PAGE" -l "$LAST_PAGE" "$INPUT_PDF" "$TEMP_DIR/page-%d.pdf"

if [ $? -ne 0 ]; then
  echo "Error: Failed to separate pages"
  rm -rf "$TEMP_DIR"
  exit 1
fi

# Build list of page files to unite
PAGE_FILES=""
for ((i = FIRST_PAGE; i <= LAST_PAGE; i++)); do
  PAGE_FILES="$PAGE_FILES $TEMP_DIR/page-$i.pdf"
done

# Unite the pages into output file
echo "Creating $OUTPUT_PDF..."
pdfunite $PAGE_FILES "$OUTPUT_PDF"

if [ $? -ne 0 ]; then
  echo "Error: Failed to unite pages"
  rm -rf "$TEMP_DIR"
  exit 1
fi

# Clean up temporary files
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Success! Chapter extracted to $OUTPUT_PDF"
echo "Pages: $FIRST_PAGE-$LAST_PAGE ($(($LAST_PAGE - $FIRST_PAGE + 1)) pages)"
