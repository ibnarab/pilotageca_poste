-- TRUNCATE TABLE fait dans le lanceur safe

INSERT INTO TABLE ${database_optimized}.${table_optimized_ca_mensuel_chronopost}

SELECT

    cabestan_product_code                                                           ,
    cabestan_product_label                                                          ,
    cabestan_sub_product_code                                                       ,
    cabestan_sub_product_label                                                      ,
    product_code                                    AS subsidiay_family_code        ,
    product_label                                   AS subsidiay_family_label       ,
    refpm_customer_id                                                               ,
    refpm_customer_name                                                             ,
    contract_number                                 AS subsidiary_customer_number   ,
    company_name                                    AS subsidiary_customer_label    ,
    reference_year                                                                  ,
    reference_month                                                                 ,
    CONCAT(reference_year, "-", reference_month)    AS reference_period             ,
    reference_month_label                                                           ,
    SUM(NVL(quantity, 0))                           AS quantity                     ,
    SUM(NVL(product_amount_ht_euro, 0))             AS product_amount_ht_euro

FROM ${database_safe}.${table_nickel_ca_mensuel_chronopost}
WHERE SUBSTR(reference_year, 1, 4) >= YEAR(CURRENT_DATE()) - 2
GROUP BY

    cabestan_product_code,
    cabestan_product_label,
    cabestan_sub_product_code,
    cabestan_sub_product_label,
    product_code,
    product_label,
    refpm_customer_id,
    refpm_customer_name,
    contract_number,
    company_name,
    reference_year,
    reference_month,
    CONCAT(reference_year, "-", reference_month),
    reference_month_label
;
