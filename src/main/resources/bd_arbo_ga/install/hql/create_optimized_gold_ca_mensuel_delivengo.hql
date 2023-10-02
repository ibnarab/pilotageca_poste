USE ${database};

DROP TABLE IF EXISTS ${table};

CREATE EXTERNAL TABLE ${table}
(
    cabestan_product_code               STRING      COMMENT "Code produit Cabestan"                                                         ,
    cabestan_product_label              STRING      COMMENT "Libellé du code produit Cabestan"                                              ,
    cabestan_sub_product_code           STRING      COMMENT "Code du sous produit Cabestan"                                                 ,
    cabestan_sub_product_label          STRING      COMMENT "Libellé du code du sous produit Cabestan"                                      ,
    cabestan_item_code                  STRING      COMMENT "Code article cabestan avec : Valeur par défaut égal à \"87091\" "              ,
    cabestan_item_label                 STRING      COMMENT "Libellé du code article Cabestan"                                              ,
    cabestan_indicateur_cap             STRING      COMMENT "Indicateur CAP Cabestan"                                                       ,
    product_code                        STRING      COMMENT "Code produit Delivengo"                                                        ,
    customer_id                         STRING      COMMENT "Numéro COCLICO : numéro client Delivengo en supprimant les zéro à gauche"      ,
    refpm_customer_name                 STRING      COMMENT "Raison sociale de la personne morale ou nom et prénom de la personne physique" ,
    delivengo_customer_id               STRING      COMMENT "Numéro client Delivengo"                                                       ,
    revenue_year                        STRING      COMMENT "Année de la date consommation"                                                 ,
    revenue_month                       STRING      COMMENT "Mois de la date consommation"                                                  ,
    period                              STRING      COMMENT "A partir de la date consommation (Format AAAA-MM)"                             ,
    revenue_month_label                 STRING      COMMENT "Libellé du mois"                                                               ,
    ht_amount                           DEC(18,5)   COMMENT "Somme des montant HT du CA"
)
STORED AS PARQUET
LOCATION '${hdfs_path}'
;

ALTER TABLE ${table}
ADD CONSTRAINT pk_${table} PRIMARY KEY (cabestan_product_code, cabestan_sub_product_code, cabestan_item_code, customer_id, revenue_year, revenue_month, period)
disable novalidate
;
