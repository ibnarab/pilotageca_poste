USE ${database};

DROP TABLE IF EXISTS ${table};

CREATE EXTERNAL TABLE ${table}
(
    entity_indicator                    STRING      COMMENT "Indicateur d’entité (0 : client privé, 1 : service public)"                                            ,
    customer_number                     STRING      COMMENT "Numéro de client ou Compte client"                                                                     ,
    account_type                        STRING      COMMENT "Type Compte"                                                                                           ,
    customer_name                       STRING      COMMENT "Nom du client"                                                                                         ,
    address_l1                          STRING      COMMENT "Adresse 1"                                                                                             ,
    address_l2                          STRING      COMMENT "Adresse 2"                                                                                             ,
    phone_number                        STRING      COMMENT "Téléphone"                                                                                             ,
    address_l3                          STRING      COMMENT "Adresse 3"                                                                                             ,
    zip_code                            STRING      COMMENT "Code postal"                                                                                           ,
    billing_type                        STRING      COMMENT "Type de facturation (valeur 0)"                                                                        ,
    etablishment_name                   STRING      COMMENT "Nom de l’établissement"                                                                                ,
    siret_code                          STRING      COMMENT "Code SIRET"                                                                                            ,
    payment_terms                       STRING      COMMENT "Modalité de paiement (PRB : Prélèvement bancaire, PRP : Prélèvement postal, PTD : Paiement direct)"    ,
    bank_account_number                 STRING      COMMENT "Numéro RIB"                                                                                            ,
    agency_accounting_poste             STRING      COMMENT "Poste comptable de l’agence"                                                                           ,
    group_code                          STRING      COMMENT "Code groupement"                                                                                       ,
    customer_currency_code              STRING      COMMENT "Code devise (EUR pour euros, blanc ou FF pour francs)"                                                 ,
    naf_code                            STRING      COMMENT "Code NAF"                                                                                              ,
    payor_name                          STRING      COMMENT "Nom du payeur"                                                                                         ,
    customer_account_assignment         STRING      COMMENT "Imputation comptable du client"                                                                        ,
    machine_number                      STRING      COMMENT "Numéro de machine"                                                                                     ,
    seller_sector                       STRING      COMMENT "Secteur vendeur"                                                                                       ,
    contract_creation_date              STRING      COMMENT "Date de création du contrat (au format AAAA-MM)"                                                       ,
    annual_contract_commitment_revenue  DEC(18, 5)  COMMENT "CA d'engagement annuel du contrat"                                                                     ,
    revenue_assignment_department_code  STRING      COMMENT "Code département d'affectation du CA"                                                                  ,
    invoice_number                      STRING      COMMENT "Numéro de facture"                                                                                     ,
    invoice_type                        STRING      COMMENT "Type de facture (I : facture, C : avoir)"                                                              ,
    deposit_date                        STRING      COMMENT "Date de dépôt (AAAA-MM-JJ)"                                                                            ,
    billing_date                        STRING      COMMENT "Date de facture (AAAA-MM-JJ)"                                                                          ,
    due_date                            STRING      COMMENT "Date d’échéance (AAAA-MM-JJ)"                                                                          ,
    cross_reference                     STRING      COMMENT "Référence croisée"                                                                                     ,
    payment_mode                        STRING      COMMENT "Mode de paiement"                                                                                      ,
    invoice_currency_code               STRING      COMMENT "Code devise (EUR pour euros, blanc ou FF pour francs)"                                                 ,
    invoice_amount                      DEC(18, 5)  COMMENT "Montant facture (converti en euros)"                                                                   ,
    marking_character                   STRING      COMMENT "Caractère de marquage (=1)"                                                                            ,
    detail_line_number                  STRING      COMMENT "Numéro de ligne détail (de 001 à 999)"                                                                 ,
    accounting_assignment               STRING      COMMENT "Imputation comptable (compte de produit ou de remise)"                                                 ,
    detail_amount                       DEC(18, 5)  COMMENT "Montant détail (converti en euros)"                                                                    ,
    etablishment_code                   STRING      COMMENT "Code établissement"                                                                                    ,
    analytic_assignment_code            STRING      COMMENT "Code affectation analytique (valeur = 207)"                                                            ,
    amount_sign                         STRING      COMMENT "Sens du montant(P = +, M = -)"                                                                         ,
    quantity                            INT         COMMENT "Quantité"                                                                                              ,
    weight                              INT         COMMENT "Poids (en grammes)"                                                                                    ,
    date_import                         STRING      COMMENT "Date d'import"                                                                                         ,
    cabestan_product_code               STRING      COMMENT "Date début facturation (AAAA-MM-JJ)"                                                                   ,
    cabestan_product_label              STRING      COMMENT "libellé produit cabestan"                                                                              ,
    cabestan_sub_product_code           STRING      COMMENT "code sous-produit cabestan"                                                                            ,
    cabestan_sub_product_label          STRING      COMMENT "libellé sous-produit cabestan"                                                                         ,
    cabestan_indicateur_cap             STRING      COMMENT "Indicateur du CAP "                                                                                    ,
    refpm_customer_id                   STRING      COMMENT "identifiant client courrier (coclico)"                                                                 ,
    refpm_customer_name                 STRING      COMMENT "nom du client courrier"                                                                                ,
    refpm_brand_name                    STRING      COMMENT "Enseigne du client"                                                                                    ,
    refpm_customer_type_code            STRING      COMMENT "Code type client"                                                                                      ,
    refpm_customer_type_label           STRING      COMMENT "Type Client"                                                                                           ,
    coliposte_management_account        STRING      COMMENT "compte de gestion La Poste",
    billing_month_label                 STRING      COMMENT "Libellé du mois de facture"
)
STORED AS PARQUET
LOCATION '${hdfs_path}'
;

ALTER TABLE ${table}
ADD CONSTRAINT pk_${table} PRIMARY KEY (customer_number, invoice_number, detail_line_number)
disable novalidate
;
