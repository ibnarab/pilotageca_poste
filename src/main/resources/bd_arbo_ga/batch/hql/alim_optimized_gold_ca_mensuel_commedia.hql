-- TRUNCATE TABLE fait dans le lanceur safe

INSERT INTO TABLE ${database_optimized}.${table_gold}

SELECT

    cabestan_product_code                                                                                                               ,
    cabestan_product_label                                                                                                              ,
    cabestan_sub_product_code                                                                                                           ,
    cabestan_sub_product_label                                                                                                          ,
    CASE WHEN service_type = 'PRESTATION' THEN product_code END                                     AS subsidiary_product_code          ,
    SUM(unit_price_ht)                                                                              AS unit_price_ht                    ,
    SUM(tax_rate)/100                                                                               AS tax_rate                         ,
    CASE WHEN service_type = 'REMISE' THEN product_code END                                         AS subsidiary_discount_code         ,
    refpm_customer_id                                                                                                                   ,
    refpm_customer_name                                                                                                                 ,
    external_customer_id                                                                            AS subsidiary_customer_number       ,
    trading_name                                                                                    AS subsidiary_customer_label        ,
    brand                                                                                           AS subsidiary_customer_brand        ,
    CASE WHEN public_customer_indicator = 'O' THEN 'PUBLIC'
         WHEN public_customer_indicator = 'N' THEN 'PRIVE'
         ELSE 'INCONNU'
    END                                                                                             AS subsidiary_customer_type         ,
    order_number                                                                                    AS subsidiary_contract_number       ,
    order_validation_date                                                                           AS subsidiary_contract_start_date   ,
    SUBSTR(accounting_sent_date, 1, 4)                                                              AS service_year                     ,
    SUBSTR(accounting_sent_date, 6, 2)                                                              AS service_month                    ,
    SUBSTR(accounting_sent_date, 1, 4)||'-'||SUBSTR(accounting_sent_date, 6, 2)                     AS service_period                   ,
    accounting_sent_month_label                                                                     AS service_month_label              ,
    SUBSTR(equinox_accounting_year_month, 1, 4)                                                     AS accounting_year                  ,
    SUBSTR(equinox_accounting_year_month, 6, 2)                                                     AS accounting_month                 ,
    SUBSTR(equinox_accounting_year_month, 1, 4)||'-'||SUBSTR(equinox_accounting_year_month, 6, 2)   AS accounting_period                ,
    equinox_accounting_month_label                                                                  AS accounting_month_label           ,
    SUM(quantity)                                                                                   AS quantity                         ,
    CASE WHEN service_type = 'PRESTATION' THEN SUM(amount_ht) END                                   AS ht_revenue                       ,
    SUM(amount_ht)                                                                                  AS ht_net_revenue                   ,
    (SUM(amount_ht) + SUM(tax_amount))                                                              AS ttc_net_revenue                  ,
    CASE WHEN service_type = 'REMISE' THEN SUM(amount_ht) END                                       AS discount_amount

FROM ${database_safe}.${table_nickel}
WHERE CAST(SUBSTR(accounting_sent_date, 1, 4) AS INT) >= CAST(YEAR(CURRENT_DATE()) AS INT) - 2
GROUP BY

    cabestan_product_code,
    cabestan_product_label,
    cabestan_sub_product_code,
    cabestan_sub_product_label,
    service_type,
    product_code,
    refpm_customer_id,
    refpm_customer_name,
    external_customer_id,
    trading_name,
    brand,
    public_customer_indicator,
    order_number,
    order_validation_date,
    SUBSTR(accounting_sent_date, 1, 4),
    SUBSTR(accounting_sent_date, 6, 2),
    accounting_sent_month_label,
    SUBSTR(equinox_accounting_year_month, 1, 4),
    SUBSTR(equinox_accounting_year_month, 6, 2),
    equinox_accounting_month_label
;
