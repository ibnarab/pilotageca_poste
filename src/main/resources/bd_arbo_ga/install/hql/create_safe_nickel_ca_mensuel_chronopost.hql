USE ${database};

DROP TABLE IF EXISTS ${table};

CREATE EXTERNAL TABLE ${table}
(
    contract_number                     STRING      COMMENT "Identifiant du contrat client"                                     ,
    contract_creation_date              STRING      COMMENT "Date de création du contrat (AAAA/MM/JJ)"                          ,
    company_name                        STRING      COMMENT "Nom du client (raison sociale)"                                    ,
    address_l1                          STRING      COMMENT "Nom de la voie"                                                    ,
    address_l2                          STRING      COMMENT "Suite d’adresse"                                                   ,
    city_name                           STRING      COMMENT "Nom de la ville"                                                   ,
    zip_code                            STRING      COMMENT "Code Postal"                                                       ,
    siret_number                        STRING      COMMENT "Numéro SIRET"                                                      ,
    revenue_assignment_department_code  STRING      COMMENT "Code département d’affectation du CA"                              ,
    sales_manager_code                  STRING      COMMENT "Code CHRONOPOST secteur chef des ventes Poste"                     ,
    commitment_revenue                  DEC(18,5)   COMMENT "CA engagement (converti en Euros)"                                 ,
    account_manager_code                STRING      COMMENT "Code gestionnaire de compte (Valeurs possibles : P ou C)"          ,
    customer_category                   STRING      COMMENT "Catégorie Client (GPO, GPA, NEW, DOM)"                             ,
    reference_year                      STRING      COMMENT "Année de référence"                                                ,
    reference_month                     STRING      COMMENT "Mois de référence"                                                 ,
    product_code                        STRING      COMMENT "Code produit"                                                      ,
    product_label                       STRING      COMMENT "Libellé produit"                                                   ,
    product_amount_ht_francs            DEC(18,5)   COMMENT "Montant produit HT en FF (signé à gauche, converti en euros)"      ,
    product_amount_ht_euro              DEC(18,5)   COMMENT "Montant produit HT en EUROS (signé à gauche, converti en euros)"   ,
    quantity                            INT         COMMENT "Quantité"                                                          ,
    weight                              INT         COMMENT "Poids (en grammes)"                                                ,
    shipment_number                     INT         COMMENT "Nombre d’expéditions"                                              ,
    date_import                         STRING      COMMENT "ajouter lors de l'intégration dans le safe empile"                 ,
    cabestan_product_code               STRING      COMMENT "code produit cabestan"                                             ,
    cabestan_product_label              STRING      COMMENT "libellé produit cabestan"                                          ,
    cabestan_sub_product_code           STRING      COMMENT "code sous-produit cabestan"                                        ,
    cabestan_sub_product_label          STRING      COMMENT "libellé sous-produit cabestan"                                     ,
    cabestan_indicateur_cap             STRING      COMMENT "Indicateur du CAP"                                                 ,
    refpm_customer_id                   STRING      COMMENT "identifiant client courrier (coclico)"                             ,
    refpm_customer_name                 STRING      COMMENT "nom du client courrier"                                            ,
    refpm_brand_name                    STRING      COMMENT "Enseigne du client"                                                ,
    refpm_customer_type_code            STRING      COMMENT "Code type client"                                                  ,
    refpm_customer_type_label           STRING      COMMENT "Type Client"                                                       ,
    reference_month_label               STRING      COMMENT "Libellé du mois de la période"
)
STORED AS PARQUET
LOCATION '${hdfs_path}'
;

ALTER TABLE ${table}
ADD CONSTRAINT pk_${table} PRIMARY KEY (contract_number, reference_year, reference_month, product_code)
disable novalidate
;
