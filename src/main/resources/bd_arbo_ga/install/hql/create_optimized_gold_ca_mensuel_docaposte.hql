USE ${database};

DROP TABLE IF EXISTS ${table};

CREATE EXTERNAL TABLE ${table}
(
    cabestan_product_code               STRING      COMMENT 'Code produit service Cabestan'     ,
    cabestan_product_label              STRING      COMMENT 'Produit Service Cabestan'          ,
    cabestan_sub_product_code           STRING      COMMENT 'Code sous-produit Cabestan'        ,
    cabestan_sub_product_label          STRING      COMMENT 'Sous-produit Cabestan'             ,
    subsidiary_family_code              STRING      COMMENT 'Code famille système opérant'      ,
    subsidiary_family_label             STRING      COMMENT 'Libellé famille système opérant'   ,
    subsidiary_product_code             STRING      COMMENT 'Code produit système opérant'      ,
    subsidiary_product_label            STRING      COMMENT 'Libellé produit système opérant'   ,
    refpm_customer_id                   STRING      COMMENT 'Code client Courrier'              ,
    refpm_customer_name                 STRING      COMMENT 'Client Courrier'                   ,
    subsidiary_code                     STRING      COMMENT 'Code Filiales DOCAPOST'            ,
    subsidiary_customer_id              STRING      COMMENT 'Numéro client DOCAPOST'            ,
    subsidiary_customer_label           STRING      COMMENT 'Libellé client DOCAPOST'           ,
    billing_year                        STRING      COMMENT 'Année'                             ,
    billing_month                       STRING      COMMENT 'Mois'                              ,
    billing_period                      STRING      COMMENT 'Période'                           ,
    billing_month_label                 STRING      COMMENT 'Libellé du mois comptable'         ,
    revenue_amount                      DEC(18,5)   COMMENT 'Montant du CA (en Euros)'
)
STORED AS PARQUET
LOCATION '${hdfs_path}'
;

--ALTER TABLE ${table}
--ADD CONSTRAINT pk_${table} PRIMARY KEY (framework_agreement_code, date_import)
--disable novalidate;
-- TODO : est-ce fait volontairement ?