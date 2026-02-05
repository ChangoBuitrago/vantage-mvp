#!/bin/bash

# Output filename
OUTPUT="vantage-complete-spec.md"

# Clear the output file if it exists
> "$OUTPUT"

echo "Merging files from docs/ into $OUTPUT..."

# Define the file order explicitly to ensure the flow makes sense
# 1. Overview
# 2. Module A (Identity)
# 3. Module B (Chain)
# 4. Module C (Settlement)

FILES=(
  "docs/vantage-modules-overview.md"
  "docs/vantage-module-a-identity-wallet.md"
  "docs/vantage-module-b-chain.md"
  "docs/vantage-module-c-settlement.md"
)

# Loop through files and append to output
for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "Processing $file..."
    
    # Add a visual separator and the filename as a comment for clarity
    echo "" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    
    # Append content
    cat "$file" >> "$OUTPUT"
    
    # Add page break/spacer between documents
    echo -e "\n\n---\n\n" >> "$OUTPUT"
  else
    echo "WARNING: $file not found. Skipping."
  fi
done

echo "Done! Created $OUTPUT"