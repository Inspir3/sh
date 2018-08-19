#!/bin/sh

path=/media/nas/video/films/

ls -1 $path | while read -r file; do

  # Renomme "2016 Sing Street.en.srt" en "Sing Street (2016).en.srt"
  
  new=$(echo $file | sed -r 's/^([0-9]{4}) ([ a-zA-Z0-9]+)\.(.*)$/\2 (\1).\3/')

  mv "$path$file" "$path$new"
done
