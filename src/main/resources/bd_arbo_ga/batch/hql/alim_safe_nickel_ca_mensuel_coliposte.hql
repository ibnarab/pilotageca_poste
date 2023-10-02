WITH

-- b_cabestan_catalogue_derniere_version recuperation de la derniere version du catalogue produit
cabestan AS (
    SELECT code_pdt_filiale, code_produit, libelle_produit, code_ss_pdt, libelle_ss_pdt, indic_pac
    FROM ${database_safe_rcom}.${table_safe_cabestan_catalogue}
    WHERE code_type_filiale = '50'
),

-- b_refpmclient_client_lien_so_actualise recuperation des dates importdatetime les plus recent
refpmclient_client_lien_so AS (
    SELECT * FROM (
    SELECT custaccnumber, custsubaccnumber, subsidiaryname, ROW_NUMBER() OVER (PARTITION BY custsubaccnumber ORDER BY importdatetime  desc) AS row_num
    FROM ${database_safe_rcom}.${table_safe_refpmclient_client_lien_so} WHERE subsidiaryname = 'VC') AS v_m
    WHERE v_m.row_num = 1
),

coliposte_compte_gestion AS (
    SELECT customer_number,management_account
    FROM ${database_safe_rcom}.${table_safe_coliposte_compte_gestion}
),

-- n_calendrier
calendrier AS (
    SELECT DISTINCT mois, libelle_mois
    FROM ${database_safe_div}.${table_safe_calendrier}
)


-- TRUNCATE TABLE fait dans le lanceur safe
INSERT INTO TABLE ${database_safe_xcom}.${table_safe_ca_mensuel_coliposte}
SELECT
    coliposte_client.entity_indicator                                                                             ,
    coliposte_client.customer_number                                                                              ,
    coliposte_client.account_type                                                                                 ,
    coliposte_client.customer_name                                                                                ,
    coliposte_client.address_l1                                                                                   ,
    coliposte_client.address_l2                                                                                   ,
    coliposte_client.phone_number                                                                                 ,
    coliposte_client.address_l3                                                                                   ,
    coliposte_client.zip_code                                                                                     ,
    coliposte_client.billing_type                                                                                 ,
    coliposte_client.etablishment_name                                                                            ,
    coliposte_client.siret_code                                                                                   ,
    coliposte_client.payment_terms                                                                                ,
    coliposte_client.bank_account_number                                                                          ,
    coliposte_client.agency_accounting_poste                                                                      ,
    coliposte_client.group_code                                                                                   ,
    coliposte_client.currency_code                                                AS customer_currency_code       ,
    coliposte_client.naf_code                                                                                     ,
    coliposte_client.payor_name                                                                                   ,
    coliposte_client.customer_account_assignment                                                                  ,
    coliposte_client.machine_number                                                                               ,
    coliposte_client.seller_sector                                                                                ,
    coliposte_client.contract_creation_date                                                                       ,
    coliposte_client.annual_contract_commitment_revenue                                                           ,
    coliposte_client.revenue_assignment_department_code                                                           ,
    coliposte_facture.invoice_number                                                                              ,
    coliposte_facture.invoice_type                                                                                ,
    coliposte_facture.deposit_date                                                                                ,
    coliposte_facture.billing_date                                                                                ,
    coliposte_facture.due_date                                                                                    ,
    coliposte_facture.cross_reference                                                                             ,
    coliposte_facture.payment_mode                                                                                ,
    coliposte_facture.currency_code                                               AS invoice_currency_code        ,
    coliposte_facture.invoice_amount                                                                              ,
    coliposte_facture.marking_character                                                                           ,
    coliposte_facture.detail_line_number                                                                          ,
    coliposte_facture.accounting_assignment                                                                       ,
    coliposte_facture.detail_amount                                                                               ,
    coliposte_facture.etablishment_code                                                                           ,
    coliposte_facture.analytic_assignment_code                                                                    ,
    coliposte_facture.amount_sign                                                                                 ,
    coliposte_facture.quantity                                                                                    ,
    coliposte_facture.weight                                                                                      ,
    coliposte_facture.date_import                                                                                 ,
    cabestan.code_produit                                                          AS cabestan_product_code       ,
    cabestan.libelle_produit                                                       AS cabestan_product_label      ,
    cabestan.code_ss_pdt                                                           AS cabestan_sub_product_code   ,
    cabestan.libelle_ss_pdt                                                        AS cabestan_sub_product_label  ,
    cabestan.indic_pac                                                             AS cabestan_indicateur_cap     ,
    refpmclient_client_lien_so.custaccnumber                                       AS refpm_customer_id           ,
    refpmclient_client.compname                                                    AS refpm_customer_name         ,
    refpmclient_client.brandname                                                   AS refpm_brand_name            ,
    refpmclient_client.custtypecode                                                AS refpm_customer_type_code    ,
    IF(refpmclient_client.custtypecode ='0', "privé", "public")                    AS refpm_customer_type_label   ,
    coliposte_compte_gestion.management_account                                    AS coliposte_management_account,
    calendrier.libelle_mois                                                        AS billing_month_label

FROM ${database_safe_xcom}.${table_safe_coliposte_facture} AS coliposte_facture

LEFT JOIN ${database_safe_xcom}.${table_safe_coliposte_client} AS coliposte_client
    ON  coliposte_facture.customer_number  = coliposte_client.customer_number

LEFT JOIN cabestan
    ON  coliposte_facture.accounting_assignment = cabestan.code_pdt_filiale

LEFT JOIN refpmclient_client_lien_so
    ON coliposte_facture.customer_number = refpmclient_client_lien_so.custsubaccnumber

LEFT JOIN ${database_safe_rcom}.${table_safe_refpmclient_client} AS refpmclient_client
    ON refpmclient_client_lien_so.custaccnumber = refpmclient_client.id

LEFT JOIN coliposte_compte_gestion
    ON coliposte_client.customer_number = coliposte_compte_gestion.customer_number

LEFT JOIN calendrier
    ON CAST(SUBSTRING(coliposte_facture.billing_date,6,2) AS INT) = calendrier.mois
;
