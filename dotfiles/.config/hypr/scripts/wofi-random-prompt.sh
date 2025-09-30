#!/bin/bash

# Define the path to your prompts file
PROMPTS_FILE="$HOME/.config/wofi/prompts.txt"

# Get a random line from the file
RANDOM_PROMPT=$(shuf -n 1 "$PROMPTS_FILE")

# Launch Wofi with the random prompt
# The --show drun part is what tells Wofi to show applications
# The --prompt "$RANDOM_PROMPT" part sets the prompt
wofi --show drun --prompt "$RANDOM_PROMPT"
