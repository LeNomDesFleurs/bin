#!/bin/bash
#
## Find all .flac files and process them
find . -type f -name '*.flac' -print0 | while IFS= read -r -d '' f; do
    album="$(metaflac --show-tag=album "$f" | sed 's/[^=]*=//')"
    artist="$(metaflac --show-tag=artist "$f" | sed 's/[^=]*=//')"
    date="$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')"
    title="$(metaflac --show-tag=title "$f" | sed 's/[^=]*=//')"
    year="$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')"
    genre="$(metaflac --show-tag=genre "$f" | sed 's/[^=]*=//')"
    tracknumber="$(metaflac --show-tag=tracknumber "$f" | sed 's/[^=]*=//')"

    flac --decode --stdout "$f" | lame --preset extreme --add-id3v2 --tt "$title" --ta "$artist" --tl "$album" --ty "$year" --tn "$tracknumber" --tg "$genre" - "${f%.flac}.mp3"

    # Delete the original FLAC file
    rm -f "$f"
done

echo "Conversion and cleanup complete."
