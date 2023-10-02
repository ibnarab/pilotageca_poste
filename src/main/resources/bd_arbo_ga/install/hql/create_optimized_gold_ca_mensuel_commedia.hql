USE ${database};

DROP TABLE IF EXISTS ${table};

CREATE EXTERNAL TABLE ${table}
(
    cabestan_product_code               STRING      COMMENT "Code produit/service Cabestan"     ,
    cabestan_product_label              STRING      COMMENT "Produit/Service Cabestan"          ,
    cabestan_sub_product_code           STRING      COMMENT "Code sous-produit Cabestan"        ,
    cabestan_sub_product_label          STRING      COMMENT "Sous-produit Cabestan"             ,
    subsidiary_product_code             STRING      COMMENT "Code produit système opérant"      ,
    unit_price_ht                       DEC(18,5)   COMMENT "Prix unitaire HT"                  ,
    tax_rate                            DEC(18,5)   COMMENT "Taux de TVA"                       ,
    subsidiary_discount_code            STRING      COMMENT "Code remise COMMEDIA"              ,
    refpm_customer_id                   STRING      COMMENT "Code client Courrier"              ,
    refpm_customer_name                 STRING      COMMENT "Client Courrier"                   ,
    subsidiary_customer_number          STRING      COMMENT "Numéro client COMMEDIA"            ,
    subsidiary_customer_label           STRING      COMMENT "Raison sociale"                    ,
    subsidiary_customer_brand           STRING      COMMENT "Enseigne"                          ,
    subsidiary_customer_type            STRING      COMMENT "Type de client"                    ,
    subsidiary_contract_number          STRING      COMMENT "Numéro de contrat COMMEDIA"        ,
    subsidiary_contract_start_date      STRING      COMMENT "Date de début contrat COMMEDIA"    ,
    service_year                        STRING      COMMENT "Année"                             ,
    service_month                       STRING      COMMENT "Mois"                              ,
    service_period                      STRING      COMMENT "Périodes"                          ,
    service_month_label                 STRING      COMMENT "Libellé du mois de prestation"     ,
    accounting_year                     STRING      COMMENT "Année"                             ,
    accounting_month                    STRING      COMMENT "Mois"                              ,
    accounting_period                   STRING      COMMENT "Période"                           ,
    accounting_month_label              STRING      COMMENT "Libellé du mois comptable"         ,
    quantity                            INT         COMMENT "Quantité"                          ,
    ht_revenue                          DEC(18,5)   COMMENT "CA brut HT"                        ,
    ht_net_revenue                      DEC(18,5)   COMMENT "CA net HT"                         ,
    ttc_net_revenue                     DEC(18,5)   COMMENT "CA net TTC"                        ,
    discount_amount                     DEC(18,5)   COMMENT "Montant remise"
)
STORED AS PARQUET
LOCATION '${hdfs_path}'
;

ALTER TABLE ${table}
ADD CONSTRAINT pk_${table} PRIMARY KEY (subsidiary_product_code, subsidiary_discount_code, subsidiary_contract_number, accounting_period)
disable novalidate
;
