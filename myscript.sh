
#!/bin/bash

download_dir="$HOME/Downloads"
mkdir -p "$download_dir"

read -p "Enter tags separated by spaces: " tags


tag_name=$(echo "$tags" | tr ' ' '+')

folder_name="${tag_name}"
    mkdir -p "$folder_name"
for page in {1..10}; do
    api_url="https://wallhaven.cc/api/v1/search?q=$tag_name&&categories=010&page=$page&&purity=110&&sorting=relevance&&order=desc&ai_art_filter=1&atleast=1920x1080"
    image_paths=$(curl -s "$api_url" | jq '.data[]?.path')

     echo "$image_paths" | xargs -I {}  wget   -nc -P "$download_dir/$folder_name"   {}
       
    
done

echo "Download complete!"

filtered_images=$(find "$download_dir" -type f -newermt "$(date -d '1 minute ago' +'%Y-%m-%d %H:%M:%S')" -print | sort)

sxiv $filtered_images
