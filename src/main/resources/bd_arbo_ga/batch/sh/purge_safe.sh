#!/bin/bash

. ${UTILoutilsbdd}/sh/hive/fct_submit.sh


bdl_utllogging_info "Traitement spécifique de Purge du SAFE"


_table_tgt="${LOC_NOM_DATASET}"
_database_tgt=$(bdl_utlconfig_get "app.${_table_tgt}.database")
_hdfs_tgt=$(bdl_utlconfig_get "app.${_table_tgt}.hdfs.path")

current_year=$(date +"%Y")
nb_min_part_to_keep=$(bdl_utlconfig_get "app.purge.hdfs.retention")
annee_purge=$((${current_year}-${nb_min_part_to_keep}))




bdl_logger_info "Table a purger                   = [${_database_tgt}.${_table_tgt}]"
bdl_logger_info "Nb min de partition à conserver  = [${nb_min_part_to_keep}]"
bdl_logger_info "Année courante                   = [${current_year}]"
bdl_logger_info "Année à purger                   = [${annee_purge}]"
bdl_logger_info "Repertoire HDFS                  = [${_hdfs_tgt}]"




hdfs dfs -ls -d ${_hdfs_tgt}/*| grep -v COMPACTED | while read f; do
    # Get File Year Partition and File Name
    file_year=`echo $f | awk -F"=" '{print $2}'`
    file_prep=`echo $f | awk -F"=" '{print $1}'`
    file_name=`echo ${file_prep} | awk '{print $8}'`
    bdl_logger_info "=> Analyse de la partition ${file_name}=${file_year}"

        # Calculate Days Difference
        if [ ${annee_purge} -ge ${file_year} ]; then

        # Suppression de la partition sur HDFS
read -r -d '' _cmd <<EOS
hdfs dfs -rm -r ${file_name}=${file_year}
EOS
        bdl_logger_info "COMMANDE EXECUTEE="$'\n'"${_cmd}"
        eval "${_cmd}"
        _cr1=${?}
        fi
    done

# Gestion du CR des suppressions
if [[ ${_cr1} -ne 0 ]]; then
    bdl_logger_error "Erreur lors de l'exécution d'une des requetes HDFS"
    return 1
fi
return 0
