WITH
-- b_refpmclient_client_lien_so_actualise recuperation des importdatetime les plus recent
client_lien_so AS (
    SELECT *
    FROM (
        SELECT custaccnumber, custsubaccnumber, subsidiaryname, ROW_NUMBER() OVER (PARTITION BY custsubaccnumber ORDER BY importdatetime DESC) AS row_num
        FROM ${database_safe_rcom}.${table_safe_client_lien_so} WHERE subsidiaryname  = 'CH'
    ) AS so
    WHERE so.row_num = 1
),

-- b_refpmclient_client_lien_so_actualise recuperation des importdatetime les plus recent
catalogue AS (
    SELECT code_pdt_filiale, code_produit, libelle_produit, code_ss_pdt, libelle_ss_pdt, indic_pac
    FROM ${database_safe_rcom}.${table_safe_catalogue}
    WHERE code_type_filiale = 40
)

-- TRUNCATE TABLE fait dans le lanceur

INSERT INTO TABLE ${database_safe_xcom}.${table_safe_ca_mensuel_chronopost}
SELECT
    facture.contract_number                                                                                         ,
    facture.contract_creation_date                                                                                  ,
    facture.company_name                                                                                            ,
    facture.address_l1                                                                                              ,
    facture.address_l2                                                                                              ,
    facture.city_name                                                                                               ,
    facture.zip_code                                                                                                ,
    facture.siret_number                                                                                            ,
    facture.revenue_assignment_department_code                                                                      ,
    facture.sales_manager_code                                                                                      ,
    facture.commitment_revenue                                                                                      ,
    facture.account_manager_code                                                                                    ,
    facture.customer_category                                                                                       ,
    facture.reference_year                                                                                          ,
    facture.reference_month                                                                                         ,
    facture.product_code                                                                                            ,
    facture.product_label                                                                                           ,
    facture.product_amount_ht_francs                                                                                ,
    facture.product_amount_ht_euro                                                                                  ,
    facture.quantity                                                                                                ,
    facture.weight                                                                                                  ,
    facture.shipment_number                                                                                         ,
    facture.date_import                                                                                             ,
    catalogue.code_produit                                                          AS cabestan_product_code        ,
    catalogue.libelle_produit                                                       AS cabestan_product_label       ,
    catalogue.code_ss_pdt                                                           AS cabestan_sub_product_code    ,
    NVL(catalogue.libelle_ss_pdt, catalogue.libelle_produit)                        AS cabestan_sub_product_label   ,
    catalogue.indic_pac                                                             AS cabestan_indicateur_cap      ,
    client_lien_so.custaccnumber                                                    AS refpm_customer_id            ,
    client.compname                                                                 AS refpm_customer_name          ,
    client.brandname                                                                AS refpm_brand_name             ,
    client.custtypecode                                                             AS refpm_customer_type_code     ,
    IF(client.custtypecode ='0', "privé","public")                                  AS refpm_customer_type_label    ,
    cal.libelle_mois                                                                AS reference_month_label

FROM ${database_safe_xcom}.${table_safe_facture} AS facture
LEFT JOIN catalogue ON facture.product_code = catalogue.code_pdt_filiale
LEFT JOIN client_lien_so    ON  client_lien_so.custsubaccnumber  = facture.contract_number

LEFT JOIN (
    SELECT id, compname,brandname,custtypecode FROM ${database_safe_rcom}.${table_safe_client}
) AS client ON client.id = client_lien_so.custaccnumber
JOIN (
     SELECT DISTINCT mois, libelle_mois
     FROM ${database_safe_div}.${table_safe_calendrier}
     WHERE annee = YEAR(CURRENT_DATE())
     ) cal ON CAST(facture.reference_month AS INT) = cal.mois
;
