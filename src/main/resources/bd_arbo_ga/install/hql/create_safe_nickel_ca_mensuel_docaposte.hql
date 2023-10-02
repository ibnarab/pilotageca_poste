USE ${database};

DROP TABLE IF EXISTS ${table};

CREATE EXTERNAL TABLE ${table}
(
    subsidiary_id                       STRING      COMMENT 'Identifiant La Filiale'                            ,
    account_number                      STRING      COMMENT 'Numéro de compte'                                  ,
    reference_year                      STRING      COMMENT 'Année'                                             ,
    reference_month                     STRING      COMMENT 'Mois'                                              ,
    product_code                        STRING      COMMENT 'Code produit'                                      ,
    revenue_amount                      DEC(18,5)   COMMENT 'Montant du CA (en euros)'                          ,
    providor_seller_sector_code         STRING      COMMENT 'Code Secteur Vendeur Apporteur (suivi commercial)' ,
    company_name                        STRING      COMMENT 'Nom ou raison sociale'                             ,
    siren_code                          STRING      COMMENT 'Code SIREN'                                        ,
    nic_code                            STRING      COMMENT 'Code NIC'                                          ,
    address_l2                          STRING      COMMENT 'Ligne adresse 2'                                   ,
    address_l3                          STRING      COMMENT 'Ligne adresse 3'                                   ,
    address_l4                          STRING      COMMENT 'Ligne adresse 4'                                   ,
    address_l5                          STRING      COMMENT 'Ligne adresse 5'                                   ,
    zip_code                            STRING      COMMENT 'Code Postal'                                       ,
    town                                STRING      COMMENT 'Ville'                                             ,
    country                             STRING      COMMENT 'Pays'                                              ,
    department_code                     STRING      COMMENT 'Code Département'                                  ,
    framework_agreement_code            STRING      COMMENT 'Code accord cadre'                                 ,
    creation_date                       STRING      COMMENT 'Date Création au format AAAA-MM-JJ'                ,
    termination_date                    STRING      COMMENT 'Date Résiliation au format AAAA-MM-JJ'             ,
    product_label                       STRING      COMMENT 'Libellé produit'                                   ,
    family_code                         STRING      COMMENT 'code famille'                                      ,
    family_label                        STRING      COMMENT 'Libellé famille'                                   ,
    framework_agreement_label           STRING      COMMENT 'Libellé accord cadre'                              ,
    date_import                         STRING      COMMENT 'Date d\'import'                                    ,
    cabestan_product_code               STRING      COMMENT 'Code produit cabestan'                             ,
    cabestan_product_label              STRING      COMMENT 'Libellé produit cabestan'                          ,
    cabestan_sub_product_code           STRING      COMMENT 'Code sous-produit cabestan'                        ,
    cabestan_sub_product_label          STRING      COMMENT 'Libellé sous-produit cabestan'                     ,
    cabestan_indicateur_cap             STRING      COMMENT "Indicateur du CAP"                                 ,
    refpm_customer_id                   STRING      COMMENT 'Identifiant client courrier (coclico)'             ,
    refpm_customer_name                 STRING      COMMENT 'Nom du client courrier'                            ,
    refpm_brand_name                    STRING      COMMENT "Enseigne du client"                                ,
    refpm_customer_type_code            STRING      COMMENT "Code type client"                                  ,
    refpm_customer_type_label           STRING      COMMENT "Type Client"                                       ,
    reference_month_label               STRING      COMMENT "Libellé du mois de consommation"


)
STORED AS PARQUET
LOCATION '${hdfs_path}'
;

ALTER TABLE ${table}
ADD CONSTRAINT pk_${table} PRIMARY KEY (account_number, subsidiary_id, reference_year, reference_month, product_code, siren_code, framework_agreement_code, family_code, cabestan_product_code, cabestan_sub_product_code, refpm_customer_id)
disable novalidate;
