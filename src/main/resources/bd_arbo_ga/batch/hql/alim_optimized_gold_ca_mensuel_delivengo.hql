-- TRUNCATE TABLE fait dans le lanceur optimized

INSERT INTO TABLE ${database_optimized}.${table_gold}

SELECT

    cabestan_product_code                       AS cabestan_product_code        ,
    cabestan_product_label                      AS cabestan_product_label       ,
    cabestan_sub_product_code                   AS cabestan_sub_product_code    ,
    cabestan_sub_product_label                  AS cabestan_sub_product_label   ,
    cabestan_item_code                          AS cabestan_item_code           ,
    cabestan_item_label                         AS cabestan_item_label          ,
    cabestan_indicateur_cap                     AS cabestan_indicateur_cap      ,
    product_code                                AS product_code                 ,
    CAST(CAST(customer_id AS INT) AS STRING)    AS customer_id                  ,
    refpm_customer_name                         AS refpm_customer_name          ,
    customer_id                                 AS delivengo_customer_id        ,
    revenue_year                                AS revenue_year                 ,
    revenue_month                               AS revenue_month                ,
    period                                      AS period                       ,
    revenue_month_label                         AS revenue_month_label          ,
    SUM(ht_amount)                              AS ht_amount

FROM ${database_safe}.${table_nickel}
WHERE CAST(revenue_year AS INT) >= CAST(YEAR(CURRENT_DATE()) AS INT) - 2
GROUP BY
    cabestan_product_code,
    cabestan_product_label,
    cabestan_sub_product_code,
    cabestan_sub_product_label,
    cabestan_item_code,
    cabestan_item_label,
    cabestan_indicateur_cap,
    product_code,
    CAST(CAST(customer_id AS INT) AS STRING),
    refpm_customer_name,
    customer_id,
    revenue_year,
    revenue_month,
    period,
    revenue_month_label
;
