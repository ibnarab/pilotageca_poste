USE ${database};

DROP TABLE IF EXISTS ${table};

CREATE EXTERNAL TABLE ${table}

(
    fix_value                           STRING      COMMENT 'Id – Valeur fixe positionnée à 1'      ,
    product_code                        STRING      COMMENT 'Code produit'                          ,
    customer_id                         STRING      COMMENT 'Numéro COCLICO'                        ,
    customer_name                       STRING      COMMENT 'Raison sociale'                        ,
    siret_number                        STRING      COMMENT 'Numéro SIRET'                          ,
    adress_l2                           STRING      COMMENT 'Adresse'                               ,
    adress_l3                           STRING      COMMENT 'Complément d\’adresse'                 ,
    zip_code                            STRING      COMMENT 'Code postal'                           ,
    town                                STRING      COMMENT 'Commune'                               ,
    country                             STRING      COMMENT 'Pays'                                  ,
    product_label                       STRING      COMMENT 'Libellé produit \/ prestation'         ,
    revenue_year                        STRING      COMMENT 'Année'                                 ,
    revenue_month                       STRING      COMMENT 'Mois'                                  ,
    period                              STRING      COMMENT 'Période'                               ,
    ht_amount                           DEC(18,5)   COMMENT 'Montant HT'                            ,
    commercial_step                     STRING      COMMENT 'Etape commerciale'                     ,
    date_import                         STRING      COMMENT 'Date d\'import'                        ,
    cabestan_product_code               STRING      COMMENT 'Code produit \/service Cabestan'       ,
    cabestan_product_label              STRING      COMMENT 'Produit \/Service Cabestan'            ,
    cabestan_sub_product_code           STRING      COMMENT 'Code sous-produit Cabestan'            ,
    cabestan_sub_product_label          STRING      COMMENT 'Sous-produit Cabestan'                 ,
    cabestan_item_code                  STRING      COMMENT 'Code article Cabestan'                 ,
    cabestan_item_label                 STRING      COMMENT 'Article Cabestan'                      ,
    cabestan_indicateur_cap             STRING      COMMENT 'Indicateur CAP de Cabestan'            ,
    refpm_customer_id                   STRING      COMMENT 'Identifiant client courrier (coclico)' ,
    refpm_customer_name                 STRING      COMMENT 'nom du client courrier'                ,
    refpm_brand_name                    STRING      COMMENT 'Enseigne du client'                    ,
    refpm_customer_type_code            STRING      COMMENT 'Code type client'                      ,
    refpm_customer_type_label           STRING      COMMENT 'Type client'                           ,
    revenue_month_label                 STRING      COMMENT 'Libellé du mois de consommation'
)
STORED AS PARQUET
LOCATION '${hdfs_path}'
;

ALTER TABLE ${table}
ADD CONSTRAINT pk_${table} PRIMARY KEY (product_code,customer_id,period)
disable novalidate
;
