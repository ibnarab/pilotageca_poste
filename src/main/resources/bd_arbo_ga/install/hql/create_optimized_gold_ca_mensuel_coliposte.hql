USE ${database};

DROP TABLE IF EXISTS ${table};

CREATE EXTERNAL TABLE ${table}
(
    cabestan_product_code               STRING      COMMENT "Code produit/service Cabestan"     ,
    cabestan_product_label              STRING      COMMENT "Produit/Service Cabestan"          ,
    cabestan_sub_product_code           STRING      COMMENT "Code sous-produit Cabestan"        ,
    cabestan_sub_product_label          STRING      COMMENT "Sous-produit Cabestan"             ,
    subsidiary_product_code             STRING      COMMENT "Code produit système opérant"      ,
    subsidiary_product_label            STRING      COMMENT "Libellé produit système opérant"   ,
    refpm_customer_id                   STRING      COMMENT "Code client Courrier"              ,
    refpm_customer_name                 STRING      COMMENT "Client Courrier"                   ,
    subsidiary_customer_number          STRING      COMMENT "Numéro client COLIPOSTE"           ,
    subsidiary_customer_label           STRING      COMMENT "Libellé client COLIPOSTE"          ,
    invoice_type                        STRING      COMMENT "Type de facture"                   ,
    reference_year                      STRING      COMMENT "Année"                             ,
    reference_month                     STRING      COMMENT "Mois"                              ,
    reference_period                    STRING      COMMENT "Période"                           ,
    reference_month_label               STRING      COMMENT "Libellé du mois de la facture"     ,
    quantity                            INT         COMMENT "Quantité"                          ,
    detail_amount                       DEC(18, 5)  COMMENT "Montant HT"
)
STORED AS PARQUET
LOCATION '${hdfs_path}'
;

ALTER TABLE ${table}
ADD CONSTRAINT pk_${table} PRIMARY KEY (subsidiary_product_code, subsidiary_customer_number)
disable novalidate
;
