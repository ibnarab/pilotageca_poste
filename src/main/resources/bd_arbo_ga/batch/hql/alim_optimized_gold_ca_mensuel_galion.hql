-- TRUNCATE TABLE fait dans le lanceur

INSERT INTO TABLE ${database_optimized}.${table_ca_mensuel_galion_mvp2}

SELECT

    cabestan_product_code                                                                               AS product_code                     ,
    cabestan_product_label                                                                              AS product_label                    ,
    cabestan_sub_product_code                                                                           AS sub_product_code                 ,
    cabestan_sub_product_label                                                                          AS sub_product_label                ,
    article_code                                                                                        AS item_code                        ,
    cabestan_item_label                                                                                 AS item_label                       ,
    discount_code                                                                                       AS discount_code                    ,
    cabestan_discount_label                                                                             AS discount_label                   ,
    cabestan_discount_type_code                                                                         AS discount_type_code               ,
    cabestan_discount_type_label                                                                        AS discount_type_label              ,
    cabestan_net_revenue_involving_indicator                                                            AS net_revenue_involving_indicator  ,
    billing_order_origin_code                                                                           AS billing_order_origin_code        ,
    customer_id                                                                                         AS customer_id                      ,
    refpm_customer_name                                                                                 AS customer_name                    ,
    refpm_brand_name                                                                                    AS brand_name                       ,
    refpm_customer_type_code                                                                            AS customer_type_code               ,
    refpm_customer_type_label                                                                           AS customer_type_label              ,
    contract_number                                                                                     AS contract_number                  ,
    hat_contract_number                                                                                 AS hat_contract_number              ,
    publipress_publication_title_number                                                                 AS publication_title_number         ,
    publipress_publication_title_label                                                                  AS publication_title_label          ,
    SUBSTR(service_start_date, 1, 4)                                                                    AS service_year                     ,
    SUBSTR(service_start_date, 6, 2)                                                                    AS service_month                    ,
    SUBSTR(service_start_date, 1, 7)                                                                    AS service_period                   ,
    service_month_label                                                                                 AS service_month_label              ,
    SUBSTR(invoice_generation_date, 1, 4)                                                               AS billing_year                     ,
    SUBSTR(invoice_generation_date, 6, 2)                                                               AS billing_month                    ,
    SUBSTR(invoice_generation_date, 1, 7)                                                               AS billing_period                   ,
    billing_month_label                                                                                 AS billing_month_label              ,
    SUBSTR(equinox_accounting_year_month, 1, 4)                                                         AS accounting_year                  ,
    SUBSTR(equinox_accounting_year_month, 7, 2)                                                         AS accounting_month                 ,
    SUBSTR(equinox_accounting_year_month, 1, 4) || "-" || SUBSTR(equinox_accounting_year_month, 7, 2)   AS accounting_period                ,
    accounting_month_label                                                                              AS accounting_month_label           ,
    SUM(NVL(invoice_line_quantity))                                                                     AS item_quantity                    ,
    SUM(NVL(article_line_amount_ht))                                                                    AS revenue_amount                   ,
    SUM(
        NVL(article_line_amount_ht, 0))
        -
        SUM(CASE WHEN cabestan_net_revenue_involving_indicator = 1 THEN NVL(discount_line_amount_ht,0) ELSE 0 END
    )                                                                                                   AS net_revenue_amount               ,
    SUM(NVL(discount_line_amount_ht))                                                                   AS discount_amount

FROM ${database_safe}.${table_ca_mensuel_galion}
WHERE invoice_generation_part_yyyy >= YEAR(CURRENT_DATE()) - 2
GROUP BY

    cabestan_product_code,
    cabestan_product_label,
    cabestan_sub_product_code,
    cabestan_sub_product_label,
    article_code,
    cabestan_item_label,
    discount_code,
    cabestan_discount_label,
    cabestan_discount_type_code,
    cabestan_discount_type_label,
    cabestan_net_revenue_involving_indicator,
    billing_order_origin_code,
    customer_id,
    refpm_customer_name,
    refpm_brand_name,
    refpm_customer_type_code,
    refpm_customer_type_label,
    contract_number,
    hat_contract_number,
    publipress_publication_title_number,
    publipress_publication_title_label,
    SUBSTR(service_start_date, 1, 4),
    SUBSTR(service_start_date, 6, 2),
    SUBSTR(service_start_date, 1, 7),
	service_month_label,
    SUBSTR(invoice_generation_date, 1, 4),
    SUBSTR(invoice_generation_date, 6, 2),
    SUBSTR(invoice_generation_date, 1, 7),
	billing_month_label,
    equinox_accounting_year_month,
	accounting_month_label
;
