USE ${database};

DROP TABLE IF EXISTS ${table};

CREATE EXTERNAL TABLE ${table}
(
    product_code                        STRING      COMMENT "Code produit/service Cabestan"      ,
    product_label                       STRING      COMMENT "Produit/Service Cabestan"           ,
    sub_product_code                    STRING      COMMENT "Code sous-produit Cabestan"         ,
    sub_product_label                   STRING      COMMENT "Sous-produit Cabestan"              ,
    item_code                           STRING      COMMENT "Code article Cabestan"              ,
    item_label                          STRING      COMMENT "Article Cabestan"                   ,
    discount_code                       STRING      COMMENT "Code remise Cabestan"               ,
    discount_label                      STRING      COMMENT "Remise Cabestan"                    ,
    discount_type_code                  STRING      COMMENT "Code type remise Cabestan"          ,
    discount_type_label                 STRING      COMMENT "Type remise Cabestan"               ,
    net_revenue_involving_indicator     STRING      COMMENT "Remise participant au CA net"       ,
    billing_order_origin_code           STRING      COMMENT "Code origine bon de commande"       ,
    customer_id                         STRING      COMMENT "Code client Courrier"               ,
    customer_name                       STRING      COMMENT "Client Courrier"                    ,
    brand_name                          STRING      COMMENT "Enseigne du client"                 ,
    customer_type_code                  STRING      COMMENT "Code type client"                   ,
    customer_type_label                 STRING      COMMENT "Type Client"                        ,
    contract_number                     STRING      COMMENT "Numéro de contrat"                  ,
    hat_contract_number                 STRING      COMMENT "Numéro de contrat chapeau"          ,
    publication_title_number            STRING      COMMENT "N° titre publication"               ,
    publication_title_label             STRING      COMMENT "Titre publication"                  ,
    service_year                        STRING      COMMENT "Année de prestation"                ,
    service_month                       STRING      COMMENT "Mois de prestation"                 ,
    service_period                      STRING      COMMENT "Période de prestation"              ,
    service_month_label                 STRING      COMMENT "Libellé du mois de prestation"      ,
    billing_year                        STRING      COMMENT "Année de facturation"               ,
    billing_month                       STRING      COMMENT "Mois de facturation"                ,
    billing_period                      STRING      COMMENT "Période de facturation"             ,
    billing_month_label                 STRING      COMMENT "Libellé du mois de facturation"     ,
    accounting_year                     STRING      COMMENT "Année comptable"                    ,
    accounting_month                    STRING      COMMENT "Mois comptable"                     ,
    accounting_period                   STRING      COMMENT "Période comptable"                  ,
    accounting_month_label              STRING      COMMENT "Libellé du mois comptable"          ,
    item_quantity                       INT         COMMENT "Quantité"                           ,
    revenue_amount                      DEC(18,5)   COMMENT "CA brut"                            ,
    net_revenue_amount                  DEC(18,5)   COMMENT "CA net"                             ,
    discount_amount                     DEC(18,5)   COMMENT "Montant remise"
)
STORED AS PARQUET
LOCATION '${hdfs_path}'
;

ALTER TABLE ${table}
ADD CONSTRAINT pk_${table} PRIMARY KEY (item_code, discount_code, discount_type_code, net_revenue_involving_indicator, billing_order_origin_code, customer_id, contract_number, hat_contract_number, publication_title_number, service_period, billing_period, accounting_period)
disable novalidate
;
