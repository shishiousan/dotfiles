#!/bin/sh
# Compile Fortran file and parse errors/warnings into single lines

if [ $# -eq 0 ]; then
  echo "Usage: $0 <fortran_file>"
  exit 1
fi

fortran_file="$1"

if [ ! -f "$fortran_file" ]; then
  echo "Error: File '$fortran_file' not found"
  exit 1
fi

# Compile and parse errors
gfortran -fsyntax-only -Wall -Wextra -fimplicit-none "$fortran_file" 2>&1 | awk '
BEGIN {
    in_error = 0
    first_line = ""
}

# Match filename:line:col pattern
/^[^:]+:[0-9]+:[0-9]+:/ {
    # Print previous error if exists
    if (in_error && first_line != "" && last_line != "") {
        print first_line " " last_line
    }
    # Start new error
    first_line = $0
    last_line = ""
    in_error = 1
    next
}

# Match Error/Warning/Note lines
/^(Error|Warning|Note):/ {
    if (in_error) {
        last_line = $0
    }
    next
}

# Ignore code snippet lines (lines with |)
/\|/ {
    next
}

END {
    # Print last error if exists
    if (in_error && first_line != "" && last_line != "") {
        print first_line " " last_line
    }
}
'
exit 1
