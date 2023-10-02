-- TRUNCATE TABLE fait dans le lanceur optimized

INSERT INTO TABLE ${database_optimized}.${table_ca_mensuel_docaposte_mvp2}

SELECT

    cabestan_product_code                           AS cabestan_product_code        ,
    cabestan_product_label                          AS cabestan_product_label       ,
    cabestan_sub_product_code                       AS cabestan_sub_product_code    ,
    cabestan_sub_product_label                      AS cabestan_sub_product_label   ,
    family_code                                     AS subsidiary_family_code       ,
    family_label                                    AS subsidiary_family_label      ,
    product_code                                    AS subsidiary_product_code      ,
    product_label                                   AS subsidiary_product_label     ,
    refpm_customer_id                               AS refpm_customer_id            ,
    refpm_customer_name                             AS refpm_customer_name          ,
    subsidiary_id                                   AS subsidiary_code              ,
    account_number                                  AS subsidiary_customer_id       ,
    company_name                                    AS subsidiary_customer_label    ,
    reference_year                                  AS billing_year                 ,
    reference_month                                 AS billing_month                ,
    CONCAT(reference_year, "-", reference_month)    AS billing_period               ,
    reference_month_label                           AS billing_month_label          ,
    SUM(revenue_amount)                             AS revenue_amount

FROM ${database_safe}.${table_ca_mensuel_docaposte}
WHERE CAST(reference_year AS INT) >= CAST(YEAR(CURRENT_DATE()) AS INT) - 2
GROUP BY

    cabestan_product_code      ,
    cabestan_product_label     ,
    cabestan_sub_product_code  ,
    cabestan_sub_product_label ,
    family_code                ,
    family_label               ,
    product_code               ,
    product_label              ,
    refpm_customer_id          ,
    refpm_customer_name        ,
    subsidiary_id              ,
    account_number             ,
    company_name               ,
    reference_year             ,
    reference_month            ,
    reference_month_label
;
