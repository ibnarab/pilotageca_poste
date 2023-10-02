-- TRUNCATE TABLE fait dans le lanceur optimized

INSERT INTO TABLE ${database_optimized}.${table_optimized_ca_mensuel_coliposte}

SELECT

    cabestan_product_code                                                                                           ,
    cabestan_product_label                                                                                          ,
    cabestan_sub_product_code                                                                                       ,
    cabestan_sub_product_label                                                                                      ,
    accounting_assignment                                                           AS subsidiary_product_code      ,
    accounting_assignment                                                           AS subsidiary_product_label     ,
    refpm_customer_id                                                                                               ,
    refpm_customer_name                                                                                             ,
    customer_number                                                                 AS subsidiary_customer_number   ,
    customer_name                                                                   AS subsidiary_customer_label    ,
    billing_type                                                                    AS invoice_type                 ,
    SUBSTR(billing_date, 1, 4)                                                      AS reference_year               ,
    SUBSTR(billing_date, 6, 2)                                                      AS reference_month              ,
    SUBSTR(billing_date, 1, 7)                                                      AS reference_period             ,
    billing_month_label                                                             AS reference_month_label             ,
    SUM(quantity)                                                                   AS quantity                     ,
    SUM(CASE WHEN amount_sign = 'P' THEN detail_amount ELSE -1 * detail_amount END) AS detail_amount

FROM ${database_safe}.${table_safe_ca_mensuel_coliposte}
WHERE SUBSTR(billing_date, 1, 4) >= YEAR(CURRENT_DATE()) - 2
GROUP BY

    cabestan_product_code,
    cabestan_product_label,
    cabestan_sub_product_code,
    cabestan_sub_product_label,
    accounting_assignment,
    refpm_customer_id,
    refpm_customer_name,
    customer_number,
    customer_name,
    billing_type,
    SUBSTR(billing_date, 1, 4),
    SUBSTR(billing_date, 6, 2),
    SUBSTR(billing_date, 1, 7),
    billing_month_label
;
