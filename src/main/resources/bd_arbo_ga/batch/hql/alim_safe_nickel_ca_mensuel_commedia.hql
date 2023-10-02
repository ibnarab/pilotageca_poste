-- TRUNCATE TABLE fait dans le lanceur safe
WITH

-- n_calendrier
calendrier AS (
    SELECT DISTINCT mois, libelle_mois
    FROM ${database_safe_div}.${table_safe_calendrier}
)

INSERT INTO TABLE ${database_safe}.${table_ca_mensuel_commedia}

SELECT

    TRIM(prest.external_customer_id)        AS external_customer_id         ,
    TRIM(prest.trading_name)                AS trading_name                 ,
    TRIM(prest.brand)                       AS brand                        ,
    TRIM(prest.siret_number)                AS siret_number                 ,
    TRIM(prest.naf_code)                    AS naf_code                     ,
    TRIM(prest.regate_code)                 AS regate_code                  ,
    TRIM(prest.business_name)               AS business_name                ,
    TRIM(prest.customer_creation_date)      AS customer_creation_date       ,
    TRIM(prest.public_customer_indicator)   AS public_customer_indicator    ,
    TRIM(prest.customer_id)                 AS customer_id                  ,
    TRIM(prest.customer_address_l2)         AS customer_address_l2          ,
    TRIM(prest.customer_address_l3)         AS customer_address_l3          ,
    TRIM(prest.customer_address_l4)         AS customer_address_l4          ,
    TRIM(prest.customer_address_l5)         AS customer_address_l5          ,
    TRIM(prest.customer_address_l6)         AS customer_address_l6          ,
    TRIM(prest.customer_mail_routing_code)  AS customer_mail_routing_code   ,
    TRIM(prest.customer_address_l7)         AS customer_address_l7          ,
    TRIM(prest.movement_number)             AS movement_number              ,
    TRIM(prest.adv_regate_code)             AS adv_regate_code              ,
    TRIM(prest.movement_type_code)          AS movement_type_code           ,
    TRIM(prest.movement_type_label)         AS movement_type_label          ,
    TRIM(prest.credit_origin_code)          AS credit_origin_code           ,
    TRIM(prest.credit_origin_label)         AS credit_origin_label          ,
    TRIM(prest.accounting_sent_date)        AS accounting_sent_date         ,
    TRIM(prest.movement_issue_date)         AS movement_issue_date          ,
    TRIM(prest.due_date)                    AS due_date                     ,
    prest.movement_amount_ht                AS movement_amount_ht           ,
    prest.movement_tax_amount               AS movement_tax_amount          ,
    TRIM(prest.associate_invoice_number)    AS associate_invoice_number     ,
    TRIM(prest.movement_address_l2)         AS movement_address_l2          ,
    TRIM(prest.movement_address_l3)         AS movement_address_l3          ,
    TRIM(prest.movement_address_l4)         AS movement_address_l4          ,
    TRIM(prest.movement_address_l5)         AS movement_address_l5          ,
    TRIM(prest.movement_address_l6)         AS movement_address_l6          ,
    TRIM(prest.movement_mail_routing_code)  AS movement_mail_routing_code   ,
    TRIM(prest.movement_address_l7)         AS movement_address_l7          ,
    TRIM(prest.payment_condition_code)      AS payment_condition_code       ,
    TRIM(prest.payment_condition_label)     AS payment_condition_label      ,
    TRIM(prest.order_number)                AS order_number                 ,
    TRIM(prest.order_version_number)        AS order_version_number         ,
    TRIM(prest.order_validation_date)       AS order_validation_date        ,
    TRIM(prest.customer_seller_sector_code) AS customer_seller_sector_code  ,
    TRIM(prest.seller_team_regate_code)     AS seller_team_regate_code      ,
    TRIM(prest.app_regate_code)             AS app_regate_code              ,
    TRIM(prest.campaign_number)             AS campaign_number              ,
    TRIM(prest.distribution_start_date)     AS distribution_start_date      ,
    TRIM(prest.distribution_end_date)       AS distribution_end_date        ,
    prest.message_weight                    AS message_weight               ,
    TRIM(prest.message_type_code)           AS message_type_code            ,
    TRIM(prest.message_type_label)          AS message_type_label           ,
    TRIM(prest.framework_agreement_number)  AS framework_agreement_number   ,
    TRIM(prest.engagement_type)             AS engagement_type              ,
    TRIM(prest.product_code)                AS product_code                 ,
    TRIM(prest.service_type)                AS service_type                 ,
    TRIM(prest.order_line)                  AS order_line                   ,
    prest.unit_price_ht                     AS unit_price_ht                ,
    prest.quantity                          AS quantity                     ,
    prest.amount_ht                         AS amount_ht                    ,
    prest.tax_rate                          AS tax_rate                     ,
    prest.tax_amount                        AS tax_amount                   ,
    TRIM(prest.service_order_line)          AS service_order_line           ,
    TRIM(prest.date_import)                 AS date_import                  ,
    TRIM(catalogue.code_produit)            AS cabestan_product_code        ,
    TRIM(catalogue.libelle_produit)         AS cabestan_product_label       ,
    TRIM(catalogue.code_ss_pdt)             AS cabestan_sub_product_code    ,
    TRIM(catalogue.libelle_ss_pdt)          AS cabestan_sub_product_label   ,
    TRIM(catalogue.indic_pac)               AS cabestan_indicateur_cap      ,
    CASE WHEN SUBSTR(external_customer_id, 1, 1) = 'P' THEN cli_so.custaccnumber  WHEN SUBSTR(external_customer_id, 1, 1) = 'D' THEN SUBSTR(external_customer_id, 2) END AS refpm_customer_id            ,
    CASE WHEN SUBSTR(external_customer_id, 1, 1) = 'P' THEN TRIM(cli.compname)    WHEN SUBSTR(external_customer_id, 1, 1) = 'D' THEN TRIM(cli_d.compname)            END AS refpm_customer_name          ,
    CASE WHEN SUBSTR(external_customer_id, 1, 1) = 'P' THEN TRIM(cli.brandname)   WHEN SUBSTR(external_customer_id, 1, 1) = 'D' THEN TRIM(cli_d.brandname)           END AS refpm_brand_name             ,
    CASE WHEN SUBSTR(external_customer_id, 1, 1) = 'P' THEN cli.custtypecode      WHEN SUBSTR(external_customer_id, 1, 1) = 'D' THEN cli_d.custtypecode              END AS refpm_customer_type_code     ,
    CASE WHEN SUBSTR(external_customer_id, 1, 1) = 'P' THEN TRIM(cli.type_label)  WHEN SUBSTR(external_customer_id, 1, 1) = 'D' THEN TRIM(cli_d.type_label)          END AS refpm_customer_type_label    ,
    TRIM(p_cpt.accounting_year_month)       AS equinox_accounting_year_month,
    cal1.libelle_mois                       AS accounting_sent_month_label  ,
    cal2.libelle_mois                       AS equinox_accounting_month_label

FROM ${database_safe}.${table_commedia_prest} prest

LEFT JOIN
    (SELECT code_pdt_filiale, code_produit, libelle_produit, code_ss_pdt, libelle_ss_pdt, indic_pac
    FROM ${database_safe_rcom}.${table_safe_cabestan_catalogue}
    WHERE code_type_filiale = '60'
    ) catalogue ON catalogue.code_pdt_filiale = prest.product_code

LEFT JOIN
    (SELECT custaccnumber, custsubaccnumber, subsidiaryname, ROW_NUMBER() OVER (PARTITION BY custsubaccnumber ORDER BY importdatetime DESC) AS row_num
    FROM ${database_safe_rcom}.${table_refpm_client_so}
    WHERE subsidiaryname = 'PN'
    ) cli_so ON cli_so.custsubaccnumber = prest.external_customer_id AND SUBSTR(external_customer_id, 1, 1) = 'P' AND cli_so.row_num = 1

LEFT JOIN
    (SELECT id, brandname, custtypecode, compname, CASE WHEN custtypecode = 0 THEN 'privé' ELSE 'public' END AS type_label
    FROM ${database_safe_rcom}.${table_refpm_client}
    ) cli ON cli_so.custaccnumber = cli.id

LEFT JOIN
    (SELECT id, brandname, custtypecode, compname, CASE WHEN custtypecode = 0 THEN 'privé' ELSE 'public' END AS type_label
    FROM ${database_safe_rcom}.${table_refpm_client}
    ) cli_d ON SUBSTR(prest.external_customer_id, 1, 1) = 'D' AND SUBSTR(prest.external_customer_id, 2) = cli_d.id

LEFT JOIN
    ${database_safe}.${table_equinox_periodecomptable} p_cpt ON substr(p_cpt.invoice_number, 6) = prest.movement_number AND p_cpt.operating_system_code='CM'

LEFT JOIN
    calendrier cal1 ON CAST(SUBSTRING(prest.accounting_sent_date,6,2) AS INT) = cal1.mois

LEFT JOIN
    calendrier cal2 ON CAST(SUBSTRING(p_cpt.accounting_year_month,7,2) AS INT) = cal2.mois
;
