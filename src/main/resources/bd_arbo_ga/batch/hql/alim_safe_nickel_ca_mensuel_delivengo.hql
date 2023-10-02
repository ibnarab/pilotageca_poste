-- TRUNCATE TABLE fait dans le lanceur safe

INSERT INTO TABLE ${database_safe_xcom}.${table_ca_mensuel_delivengo}

SELECT DISTINCT

    DELIVENGO_ACTU.fix_value                                        AS fix_value                    ,
    DELIVENGO_ACTU.product_code                                     AS product_code                 ,
    DELIVENGO_ACTU.customer_id                                      AS customer_id                  ,
    DELIVENGO_ACTU.customer_name                                    AS customer_name                ,
    DELIVENGO_ACTU.siret_number                                     AS siret_number                 ,
    DELIVENGO_ACTU.adress_l2                                        AS adress_l2                    ,
    DELIVENGO_ACTU.adress_l3                                        AS adress_l3                    ,
    DELIVENGO_ACTU.zip_code                                         AS zip_code                     ,
    DELIVENGO_ACTU.town                                             AS town                         ,
    DELIVENGO_ACTU.country                                          AS country                      ,
    DELIVENGO_ACTU.product_label                                    AS product_label                ,
    DELIVENGO_ACTU.revenue_year                                     AS revenue_year                 ,
    DELIVENGO_ACTU.revenue_month                                    AS revenue_month                ,
    regexp_replace(DELIVENGO_ACTU.period,  "/",  "-")               AS period                       ,
    DELIVENGO_ACTU.ht_amount                                        AS ht_amount                    ,
    DELIVENGO_ACTU.commercial_step                                  AS commercial_step              ,
    DELIVENGO_ACTU.date_import                                      AS date_import                  ,
    CATALOGUE_CABESTAN.code_produit                                 AS cabestan_product_code        ,
    CATALOGUE_CABESTAN.libelle_produit                              AS cabestan_product_label       ,
    CATALOGUE_CABESTAN.code_ss_pdt                                  AS cabestan_sub_product_code    ,
    CATALOGUE_CABESTAN.libelle_ss_pdt                               AS cabestan_sub_product_label   ,
    CATALOGUE_CABESTAN.code_article                                 AS cabestan_item_code           ,
    CATALOGUE_CABESTAN.libelle_article                              AS cabestan_item_label          ,
    CATALOGUE_CABESTAN.indic_pac                                    AS cabestan_indicateur_cap      ,
    DELIVENGO_ACTU.customer_id                                      AS refpm_customer_id            ,
    BREFPM.compname                                                 AS refpm_customer_name          ,
    BREFPM.brandname                                                AS refpm_brand_name             ,
    BREFPM.custtypecode                                             AS refpm_customer_type_code     ,
    CASE WHEN  custtypecode = '0' THEN  "privé" ELSE "public" END   AS refpm_customer_type_label    ,
    cal.libelle_mois                                                AS revenue_month_label

FROM

${database_safe_xcom}.${table_delivengo_actu} DELIVENGO_ACTU
LEFT JOIN
${database_safe_rcom}.${table_safe_cabestan_catalogue} CATALOGUE_CABESTAN
    ON CATALOGUE_CABESTAN.code_produit = DELIVENGO_ACTU.product_code AND CATALOGUE_CABESTAN.code_article = "87091"
LEFT JOIN
${database_safe_rcom}.${table_refpm_client} BREFPM
    ON BREFPM.id = CAST(DELIVENGO_ACTU.customer_id AS INT)
LEFT JOIN
(SELECT DISTINCT mois, libelle_mois FROM ${database_safe_div}.${table_safe_calendrier}) cal
    ON CAST(DELIVENGO_ACTU.revenue_month AS INT) = cal.mois
;
