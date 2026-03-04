#!/bin/bash
# Download the Comprehensive Formula 1 Dataset (2020-2025) from Kaggle
# URL: https://www.kaggle.com/datasets/vshreekamalesh/comprehensive-formula-1-dataset-2020-2025
# Prerequisite: Kaggle CLI must be installed (`pip install kaggle`) and `~/.kaggle/kaggle.json` must be configured.

DATASET="vshreekamalesh/comprehensive-formula-1-dataset-2020-2025"
OUTPUT_DIR="data"

echo "Checking prerequisites..."
if ! command -v kaggle &> /dev/null
then
    echo "Error: kaggle CLI could not be found."
    echo "Please install it via 'pip install kaggle' and configure your API credentials in ~/.kaggle/kaggle.json."
    exit 1
fi

echo "Creating output directory '$OUTPUT_DIR'..."
mkdir -p "$OUTPUT_DIR"

echo "Downloading dataset $DATASET to $OUTPUT_DIR..."
# Download and unzip the specific file requested (or entire dataset)
kaggle datasets download -d "$DATASET" -p "$OUTPUT_DIR" --unzip

if [ $? -eq 0 ]; then
    echo "Dataset successfully downloaded and unzipped to the '$OUTPUT_DIR' directory."
else
    echo "Error: Failed to download the dataset. Please check your Kaggle API key and internet connection."
    exit 1
fi
