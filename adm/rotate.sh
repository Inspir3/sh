#!/bin/sh

# Exemple de configuration avec la crontab
# Garde que les 5 fichiers les plus récents dans /home/redge/tmp
#* * * * * /home/redge/bin/rotate.sh /home/redge/tmp 5 > /dev/null

pwd=`pwd`

. $pwd/../lib/log.sh

log_PREFIX="rotate.sh"
log_NIVEAU=$log_DEBUG
log_FILE="/var/log/actedev.log"

dir=$1
nb=$2
action=$3

if [ ! -d $dir ]; then
  log_erreur "$dir n'est pas un répertoire"
  exit
fi

cpt=1

#Liste les fichiers en les triant du plus récent au plus ancien
ls $dir -t1 \
| while read -r file; do

  #On garde que les $nb plus récents
  if [ "$cpt" -gt "$nb" ]; then
    if [ "$action" = "supprime" ]; then
      log_info "Supprime $dir/$file"
      rm $dir/$file
    else
      log_debug "Supprime $dir/$file"
    fi
  fi

  cpt=$((cpt+1))
done
