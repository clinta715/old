import sys
import os
from pathlib import Path

def list_file_extensions(directory):
    """Recursively find all file extensions in the given directory."""
    extensions = set()
    
    for root, _, files in os.walk(directory):
        for file in files:
            ext = Path(file).suffix.lower()
            if ext:
                extensions.add(ext)
    
    return extensions

if __name__ == "__main__":
    directory = sys.argv[1] if len(sys.argv) > 1 else '.'
    extensions = list_file_extensions(directory)
    
    print("Found file extensions:")
    for ext in sorted(extensions):
        print(ext)

