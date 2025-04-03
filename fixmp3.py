import sys
import glob
import shutil
import os
from pathlib import Path
from mutagen.easyid3 import EasyID3

def get_mp3_metadata(mp3_path):
    """Extract artist and album title from an MP3 file."""
    try:
        tags = EasyID3(mp3_path)
        artist = tags.get("artist", ["Unknown Artist"])[0]
        album = tags.get("album", ["Unknown Album"])[0]
        return artist, album
    except Exception:
        return "Unknown Artist", "Unknown Album"

def organize_mp3s(pattern):
    """Organize MP3 files matching the given pattern."""
    for mp3_file in glob.glob(pattern):
        mp3_path = Path(mp3_file)
        if mp3_path.suffix.lower() != ".mp3":
            continue

        artist, album = get_mp3_metadata(mp3_path)
        folder_name = f"{artist}_{album}".replace("/", "_").replace("\\", "_")
        folder_path = Path(folder_name)
        folder_path.mkdir(exist_ok=True)

        destination = folder_path / mp3_path.name
        shutil.move(mp3_path, destination)
        print(f"Moved {mp3_path} -> {destination}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python organize_mp3s.py '<wildcard_pattern>'")
        sys.exit(1)
    
    pattern = sys.argv[1]
    organize_mp3s(pattern)

