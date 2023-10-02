-- TRUNCATE TABLE fait dans le lanceur safe

INSERT OVERWRITE TABLE ${database_safe}.${table_ca_mensuel_consolide}

SELECT

    'GA'                                                                                        AS code_dom_fact                ,
    billing_order_origin_code                                                                   AS code_appli_source            ,
    article_code                                                                                AS code_pdt_dom_fact            ,
    article_code                                                                                AS code_art_cabestan            ,
    cabestan_item_label                                                                         AS libelle_art_cabestan         ,
    cabestan_sub_product_code                                                                   AS code_ss_pdt_cabestan         ,
    cabestan_sub_product_label                                                                  AS libelle_ss_pdt_cabestan      ,
    cabestan_product_code                                                                       AS code_pdt_ser_cabestan        ,
    cabestan_product_label                                                                      AS libelle_pdt_ser_cabestan     ,
    cabestan_indicateur_cap                                                                     AS indicateur_cap               ,
    NULL                                                                                        AS code_offre_ops               ,
    NULL                                                                                        AS libelle_offre_ops            ,
    discount_code                                                                               AS code_remise_dom_fact         ,
    discount_code                                                                               AS code_remise_cabestan         ,
    cabestan_discount_label                                                                     AS libelle_remise_cabestan      ,
    cabestan_discount_type_code                                                                 AS code_type_remise_cabestan    ,
    cabestan_discount_type_label                                                                AS type_remise_cabestan         ,
    customer_id                                                                                 AS code_cli_dom_fact            ,
    NVL(customer_id,'0')                                                                        AS code_cli_courrier            ,
    refpm_customer_name                                                                         AS raison_soc_cli_courrier      ,
    refpm_brand_name                                                                            AS enseigne_cli                 ,
    refpm_customer_type_code                                                                    AS code_type_cli                ,
    refpm_customer_type_label                                                                   AS libelle_type_cli             ,
    NVL(billing_order_number,'0')                                                               AS num_bon_de_commande          ,
    contract_number                                                                             AS num_contrat                  ,
    hat_contract_number                                                                         AS num_contrat_chapeau          ,
    franking_machine_serial_number                                                              AS num_machine_affranchir       ,
    CASE WHEN SUBSTR(specific_header1, 1, 6)='Publi='        THEN SUBSTR(specific_header1, LENGTH(specific_header1) - INSTR(reverse(specific_header1),';') + 2) END     AS num_titre_publication,
    publipress_publication_title_label                                                          AS titre_publication            ,
    CASE WHEN SUBSTR(specific_header3, 1, 1) = 'N'
        THEN TRIM(SUBSTR(specific_header3,IF(instr(specific_header3,'=') <> 0,instr(specific_header3,'=')+1,NULL),
            IF(instr(specific_header3,';') <> 0,instr(specific_header3,';')-instr(specific_header3,'=')-1,LENGTH(specific_header3)-instr(specific_header3,'=')))) END   AS num_parution         ,
    CASE WHEN SUBSTR(specific_header3,1,1) = 'N' AND instr(specific_header3,';') <> 0
        THEN TRIM(SUBSTR(specific_header3, LENGTH(specific_header3)-instr(REVERSE(specific_header3),'=')+2)) END                                                        AS type_parution        ,
    invoice_id                                                                                  AS num_facture                  ,
    franking_mode_code                                                                          AS code_mode_affranchissement   ,
    SUBSTR(service_start_date, 1, 7)                                                            AS periode_prestation           ,
    SUBSTR(service_start_date, 1, 4)                                                            AS annee_prestation             ,
    SUBSTR(service_start_date, 6, 2)                                                            AS mois_prestation              ,
    service_month_label                                                                         AS libelle_mois_prestation      ,
    SUBSTR(invoice_generation_date, 1, 7)                                                       AS periode_facturation          ,
    SUBSTR(invoice_generation_date, 1, 4)                                                       AS annee_facturation            ,
    SUBSTR(invoice_generation_date, 6, 2)                                                       AS mois_facturation             ,
    billing_month_label                                                                         AS libelle_mois_facturation     ,
    SUBSTR(equinox_accounting_year_month, 1, 4)||'-'||SUBSTR(equinox_accounting_year_month, 7, 2) AS periode_comptable          ,
    SUBSTR(equinox_accounting_year_month, 1, 4)                                                 AS annee_comptable              ,
    SUBSTR(equinox_accounting_year_month, 7, 2)                                                 AS mois_comptable               ,
    accounting_month_label                                                                      AS libelle_mois_comptable       ,
    invoice_line_quantity                                                                       AS quantite                     ,
    article_line_amount_ht                                                                      AS montant_ca_brut_ht           ,
    COALESCE(article_line_amount_ht,0) - COALESCE(discount_line_amount_ht,0) * COALESCE(cabestan_net_revenue_involving_indicator,0) AS montant_ca_net_ht ,
    discount_line_amount_ht                                                                     AS montant_remise_ht            ,
    CAST(SUBSTR(invoice_generation_date, 1, 4) AS INT)                                          AS facturation_part_yyyy

FROM ${database_safe}.${table_ca_mensuel_galion}

WHERE CAST(SUBSTR(invoice_generation_date, 1, 4) AS INT) > YEAR(CURRENT_DATE()) - ${nb_annee}

UNION

SELECT

    'PN'                                                                                        AS code_dom_fact                ,
    'CM'                                                                                        AS code_appli_source            ,
    product_code                                                                                AS code_pdt_dom_fact            ,
    NULL                                                                                        AS code_art_cabestan            ,
    NULL                                                                                        AS libelle_art_cabestan         ,
    cabestan_sub_product_code                                                                   AS code_ss_pdt_cabestan         ,
    cabestan_sub_product_label                                                                  AS libelle_ss_pdt_cabestan      ,
    cabestan_product_code                                                                       AS code_pdt_ser_cabestan        ,
    cabestan_product_label                                                                      AS libelle_pdt_ser_cabestan     ,
    cabestan_indicateur_cap                                                                     AS indicateur_cap               ,
    NULL                                                                                        AS code_offre_ops               ,
    NULL                                                                                        AS libelle_offre_ops            ,
    CASE WHEN service_type = 'REMISE' THEN product_code END                                     AS code_remise_dom_fact         ,
    NULL                                                                                        AS code_remise_cabestan         ,
    NULL                                                                                        AS libelle_remise_cabestan      ,
    NULL                                                                                        AS code_type_remise_cabestan    ,
    NULL                                                                                        AS type_remise_cabestan         ,
    external_customer_id                                                                        AS code_cli_dom_fact            ,
    NVL(refpm_customer_id,'0')                                                                  AS code_cli_courrier            ,
    refpm_customer_name                                                                         AS raison_soc_cli_courrier      ,
    refpm_brand_name                                                                            AS enseigne_cli                 ,
    refpm_customer_type_code                                                                    AS code_type_cli                ,
    refpm_customer_type_label                                                                   AS libelle_type_cli             ,
    NVL(order_number,'0')                                                                       AS num_bon_de_commande          ,
    NULL                                                                                        AS num_contrat                  ,
    NULL                                                                                        AS num_contrat_chapeau          ,
    NULL                                                                                        AS num_machine_affranchir       ,
    NULL                                                                                        AS num_titre_publication        ,
    NULL                                                                                        AS titre_publication            ,
    NULL                                                                                        AS num_parution                 ,
    NULL                                                                                        AS type_parution                ,
    '0'                                                                                         AS num_facture                  ,
    NULL                                                                                        AS code_mode_affranchissement   ,
    SUBSTR(accounting_sent_date, 1, 7)                                                          AS periode_prestation           ,
    SUBSTR(accounting_sent_date, 1, 4)                                                          AS annee_prestation             ,
    SUBSTR(accounting_sent_date, 6, 2)                                                          AS mois_prestation              ,
    accounting_sent_month_label                                                                 AS libelle_mois_prestation      ,
    SUBSTR(accounting_sent_date, 1, 7)                                                          AS periode_facturation          ,
    SUBSTR(accounting_sent_date, 1, 4)                                                          AS annee_facturation            ,
    SUBSTR(accounting_sent_date, 6, 2)                                                          AS mois_facturation             ,
    accounting_sent_month_label                                                                 AS libelle_mois_facturation     ,
    SUBSTR(equinox_accounting_year_month, 1, 4)||'-'||SUBSTR(equinox_accounting_year_month ,7, 2) AS periode_comptable          ,
    SUBSTR(equinox_accounting_year_month, 1, 4)                                                 AS annee_comptable              ,
    SUBSTR(equinox_accounting_year_month, 7, 2)                                                 AS mois_comptable               ,
    equinox_accounting_month_label                                                              AS libelle_mois_comptable       ,
    quantity                                                                                    AS quantite                     ,
    CASE WHEN service_type = 'PRESTATION' THEN amount_ht END                                    AS montant_ca_brut_ht           ,
    amount_ht                                                                                   AS montant_ca_net_ht            ,
    CASE WHEN service_type = 'REMISE' THEN amount_ht END                                        AS montant_remise_ht            ,
    CAST(SUBSTR(accounting_sent_date, 1, 4) AS INT)                                             AS facturation_part_yyyy

FROM ${database_safe}.${table_ca_mensuel_commedia}

WHERE CAST(SUBSTR(accounting_sent_date, 1, 4) AS INT) > YEAR(CURRENT_DATE()) - ${nb_annee}


UNION


SELECT

    'CH'                                                                                    AS code_dom_fact                ,
    'CH'                                                                                    AS code_appli_source            ,
    product_code                                                                            AS code_pdt_dom_fact            ,
    NULL                                                                                    AS code_art_cabestan            ,
    NULL                                                                                    AS libelle_art_cabestan         ,
    cabestan_sub_product_code                                                               AS code_ss_pdt_cabestan         ,
    cabestan_sub_product_label                                                              AS libelle_ss_pdt_cabestan      ,
    cabestan_product_code                                                                   AS code_pdt_ser_cabestan        ,
    cabestan_product_label                                                                  AS libelle_pdt_ser_cabestan     ,
    cabestan_indicateur_cap                                                                 AS indicateur_cap               ,
    NULL                                                                                    AS code_offre_ops               ,
    NULL                                                                                    AS libelle_offre_ops            ,
    NULL                                                                                    AS code_remise_dom_fact         ,
    NULL                                                                                    AS code_remise_cabestan         ,
    NULL                                                                                    AS libelle_remise_cabestan      ,
    NULL                                                                                    AS code_type_remise_cabestan    ,
    NULL                                                                                    AS type_remise_cabestan         ,
    contract_number                                                                         AS code_cli_dom_fact            ,
    NVL(refpm_customer_id, '0')                                                             AS code_cli_courrier            ,
    refpm_customer_name                                                                     AS raison_soc_cli_courrier      ,
    refpm_brand_name                                                                        AS enseigne_cli                 ,
    refpm_customer_type_code                                                                AS code_type_cli                ,
    refpm_customer_type_label                                                               AS libelle_type_cli             ,
    '0'                                                                                     AS num_bon_de_commande          ,
    NULL                                                                                    AS num_contrat                  ,
    NULL                                                                                    AS num_contrat_chapeau          ,
    NULL                                                                                    AS num_machine_affranchir       ,
    NULL                                                                                    AS num_titre_publication        ,
    NULL                                                                                    AS titre_publication            ,
    NULL                                                                                    AS num_parution                 ,
    NULL                                                                                    AS type_parution                ,
    '0'                                                                                     AS num_facture                  ,
    NULL                                                                                    AS code_mode_affranchissement   ,
    reference_year||'-'||reference_month                                                    AS periode_prestation           ,
    reference_year                                                                          AS annee_prestation             ,
    reference_month                                                                         AS mois_prestation              ,
    reference_month_label                                                                   AS libelle_mois_prestation      ,
    reference_year||'-'||reference_month                                                    AS periode_facturation          ,
    reference_year                                                                          AS annee_facturation            ,
    reference_month                                                                         AS mois_facturation             ,
    reference_month_label                                                                   AS libelle_mois_facturation     ,
    NULL                                                                                    AS periode_comptable            ,
    NULL                                                                                    AS annee_comptable              ,
    NULL                                                                                    AS mois_comptable               ,
    NULL                                                                                    AS libelle_mois_comptable       ,
    0                                                                                       AS quantite                     ,
    product_amount_ht_euro                                                                  AS montant_ca_brut_ht           ,
    product_amount_ht_euro                                                                  AS montant_ca_net_ht            ,
    0                                                                                       AS montant_remise_ht            ,
    CAST(reference_year AS INT)                                                             AS facturation_part_yyyy

FROM ${database_safe}.${table_ca_mensuel_chronopost}

WHERE CAST(reference_year AS INT) > YEAR(CURRENT_DATE()) - ${nb_annee}


UNION


SELECT

    'VC'                                                                                    AS code_dom_fact                ,
    'VC'                                                                                    AS code_appli_source            ,
    CASE WHEN coliposte_management_account IN ('0', '2', '4', '6') THEN accounting_assignment END AS code_pdt_dom_fact      ,
    NULL                                                                                    AS code_art_cabestan            ,
    NULL                                                                                    AS libelle_art_cabestan         ,
    cabestan_sub_product_code                                                               AS code_ss_pdt_cabestan         ,
    cabestan_sub_product_label                                                              AS libelle_ss_pdt_cabestan      ,
    cabestan_product_code                                                                   AS code_pdt_ser_cabestan        ,
    cabestan_product_label                                                                  AS libelle_pdt_ser_cabestan     ,
    cabestan_indicateur_cap                                                                 AS indicateur_cap               ,
    NULL                                                                                    AS code_offre_ops               ,
    NULL                                                                                    AS libelle_offre_ops            ,
    NULL                                                                                    AS code_remise_dom_fact         ,
    NULL                                                                                    AS code_remise_cabestan         ,
    NULL                                                                                    AS libelle_remise_cabestan      ,
    NULL                                                                                    AS code_type_remise_cabestan    ,
    NULL                                                                                    AS type_remise_cabestan         ,
    CASE WHEN coliposte_management_account IN ('0', '2', '4', '6') THEN customer_number END AS code_cli_dom_fact            ,
    NVL(refpm_customer_id,'0')                                                              AS code_cli_courrier            ,
    refpm_customer_name                                                                     AS raison_soc_cli_courrier      ,
    refpm_brand_name                                                                        AS enseigne_cli                 ,
    refpm_customer_type_code                                                                AS code_type_cli                ,
    refpm_customer_type_label                                                               AS libelle_type_cli             ,
    '0'                                                                                     AS num_bon_de_commande          ,
    NULL                                                                                    AS num_contrat                  ,
    NULL                                                                                    AS num_contrat_chapeau          ,
    NULL                                                                                    AS num_machine_affranchir       ,
    NULL                                                                                    AS num_titre_publication        ,
    NULL                                                                                    AS titre_publication            ,
    NULL                                                                                    AS num_parution                 ,
    NULL                                                                                    AS type_parution                ,
    '0'                                                                                     AS num_facture                  ,
    NULL                                                                                    AS code_mode_affranchissement   ,
    SUBSTR(billing_date, 1, 7)                                                              AS periode_prestation           ,
    SUBSTR(billing_date, 1, 4)                                                              AS annee_prestation             ,
    SUBSTR(billing_date, 6, 2)                                                              AS mois_prestation              ,
    billing_month_label                                                                     AS libelle_mois_comptable       ,
    SUBSTR(billing_date, 1, 7)                                                              AS periode_facturation          ,
    SUBSTR(billing_date, 1, 4)                                                              AS annee_facturation            ,
    SUBSTR(billing_date, 6, 2)                                                              AS mois_facturation             ,
    billing_month_label                                                                     AS libelle_mois_comptable       ,
    NULL                                                                                    AS periode_comptable            ,
    NULL                                                                                    AS annee_comptable              ,
    NULL                                                                                    AS mois_comptable               ,
    NULL                                                                                    AS libelle_mois_comptable       ,
    0                                                                                       AS quantite                     ,
    CASE WHEN SUBSTR(accounting_assignment, 1, 1) = '7' AND SUBSTR(accounting_assignment, 3, 1) = '6'
        THEN detail_amount * IF(amount_sign = 'M', -1, 1) END                               AS montant_ca_brut_ht           ,
    CASE WHEN SUBSTR(accounting_assignment, 1, 1) = '7'
        THEN IF(SUBSTR(accounting_assignment, 3, 1) = '6',detail_amount * IF(amount_sign = 'M', -1, 1),0)
            -
            IF (SUBSTR(accounting_assignment, 3, 1) = '9',detail_amount * IF(amount_sign = 'M', -1, 1),0) END AS montant_ca_net_ht ,
    CASE WHEN SUBSTR(accounting_assignment, 1, 1) = '7' AND SUBSTR(accounting_assignment, 3, 1) = '9'
        THEN detail_amount * IF(amount_sign = 'M', -1, 1) END                               AS montant_remise_ht            ,
    CAST(SUBSTR(deposit_date, 1, 4) AS INT)                                                 AS facturation_part_yyyy

FROM ${database_safe}.${table_ca_mensuel_coliposte}

WHERE CAST(SUBSTR(deposit_date, 1, 4) AS INT) > YEAR(CURRENT_DATE()) - ${nb_annee}

UNION


SELECT

    'TL'                                                                                    AS code_dom_fact                ,
    CASE
        WHEN subsidiary_id = "ASPH" THEN 'AS'
        WHEN subsidiary_id = "BRET" THEN 'BR'
        WHEN subsidiary_id = "EXTL" THEN 'EX'
        WHEN subsidiary_id = "MAIL" THEN 'TL'
        WHEN subsidiary_id = "ORSI" THEN 'OR'
    END                                                                                     AS code_appli_source            ,
    product_code                                                                            AS code_pdt_dom_fact            ,
    NULL                                                                                    AS code_art_cabestan            ,
    NULL                                                                                    AS libelle_art_cabestan         ,
    cabestan_sub_product_code                                                               AS code_ss_pdt_cabestan         ,
    cabestan_sub_product_label                                                              AS libelle_ss_pdt_cabestan      ,
    cabestan_product_code                                                                   AS code_pdt_ser_cabestan        ,
    cabestan_product_label                                                                  AS libelle_pdt_ser_cabestan     ,
    cabestan_indicateur_cap                                                                 AS indicateur_cap               ,
    NULL                                                                                    AS code_offre_ops               ,
    NULL                                                                                    AS libelle_offre_ops            ,
    NULL                                                                                    AS code_remise_dom_fact         ,
    NULL                                                                                    AS code_remise_cabestan         ,
    NULL                                                                                    AS libelle_remise_cabestan      ,
    NULL                                                                                    AS code_type_remise_cabestan    ,
    NULL                                                                                    AS type_remise_cabestan         ,
    account_number                                                                          AS code_cli_dom_fact            ,
    NVL(refpm_customer_id, '0')                                                             AS code_cli_courrier            ,
    refpm_customer_name                                                                     AS raison_soc_cli_courrier      ,
    refpm_brand_name                                                                        AS enseigne_cli                 ,
    refpm_customer_type_code                                                                AS code_type_cli                ,
    refpm_customer_type_label                                                               AS libelle_type_cli             ,
    '0'                                                                                     AS num_bon_de_commande          ,
    NULL                                                                                    AS num_contrat                  ,
    NULL                                                                                    AS num_contrat_chapeau          ,
    NULL                                                                                    AS num_machine_affranchir       ,
    NULL                                                                                    AS num_titre_publication        ,
    NULL                                                                                    AS titre_publication            ,
    NULL                                                                                    AS num_parution                 ,
    NULL                                                                                    AS type_parution                ,
    '0'                                                                                     AS num_facture                  ,
    NULL                                                                                    AS code_mode_affranchissement   ,
    reference_year||'-'||reference_month                                                    AS periode_prestation           ,
    reference_year                                                                          AS annee_prestation             ,
    reference_month                                                                         AS mois_prestation              ,
    reference_month_label                                                                   AS libelle_mois_prestation      ,
    reference_year||'-'||reference_month                                                    AS periode_facturation          ,
    reference_year                                                                          AS annee_facturation            ,
    reference_month                                                                         AS mois_facturation             ,
    reference_month_label                                                                   AS libelle_mois_facturation     ,
    NULL                                                                                    AS periode_comptable            ,
    NULL                                                                                    AS annee_comptable              ,
    NULL                                                                                    AS mois_comptable               ,
    NULL                                                                                    AS libelle_mois_comptable       ,
    0                                                                                       AS quantite                     ,
    revenue_amount                                                                          AS montant_ca_brut_ht           ,
    revenue_amount                                                                          AS montant_ca_net_ht            ,
    0                                                                                       AS montant_remise_ht            ,
    CAST(reference_year AS INT)                                                             AS facturation_part_yyyy

FROM ${database_safe}.${table_ca_mensuel_docaposte}

WHERE CAST(reference_year AS INT) > YEAR(CURRENT_DATE()) - ${nb_annee}


UNION


SELECT

    'DV'                                                                                    AS code_dom_fact                ,
    'DV'                                                                                    AS code_appli_source            ,
    product_code                                                                            AS code_pdt_dom_fact            ,
    NULL                                                                                    AS code_art_cabestan            ,
    NULL                                                                                    AS libelle_art_cabestan         ,
    cabestan_sub_product_code                                                               AS code_ss_pdt_cabestan         ,
    cabestan_sub_product_label                                                              AS libelle_ss_pdt_cabestan      ,
    cabestan_product_code                                                                   AS code_pdt_ser_cabestan        ,
    cabestan_product_label                                                                  AS libelle_pdt_ser_cabestan     ,
    cabestan_indicateur_cap                                                                 AS indicateur_cap               ,
    NULL                                                                                    AS code_offre_ops               ,
    NULL                                                                                    AS libelle_offre_ops            ,
    NULL                                                                                    AS code_remise_dom_fact         ,
    NULL                                                                                    AS code_remise_cabestan         ,
    NULL                                                                                    AS libelle_remise_cabestan      ,
    NULL                                                                                    AS code_type_remise_cabestan    ,
    NULL                                                                                    AS type_remise_cabestan         ,
    customer_id                                                                             AS code_cli_dom_fact            ,
    NVL(refpm_customer_id, '0')                                                             AS code_cli_courrier            ,
    refpm_customer_name                                                                     AS raison_soc_cli_courrier      ,
    refpm_brand_name                                                                        AS enseigne_cli                 ,
    refpm_customer_type_code                                                                AS code_type_cli                ,
    refpm_customer_type_label                                                               AS libelle_type_cli             ,
    '0'                                                                                     AS num_bon_de_commande          ,
    NULL                                                                                    AS num_contrat                  ,
    NULL                                                                                    AS num_contrat_chapeau          ,
    NULL                                                                                    AS num_machine_affranchir       ,
    NULL                                                                                    AS num_titre_publication        ,
    NULL                                                                                    AS titre_publication            ,
    NULL                                                                                    AS num_parution                 ,
    NULL                                                                                    AS type_parution                ,
    '0'                                                                                     AS num_facture                  ,
    NULL                                                                                    AS code_mode_affranchissement   ,
    revenue_year||'-'||revenue_month                                                        AS periode_prestation           ,
    revenue_year                                                                            AS annee_prestation             ,
    revenue_month                                                                           AS mois_prestation              ,
    revenue_month_label                                                                     AS libelle_mois_prestation      ,
    revenue_year||'-'||revenue_month                                                        AS periode_facturation          ,
    revenue_year                                                                            AS annee_facturation            ,
    revenue_month                                                                           AS mois_facturation             ,
    revenue_month_label                                                                     AS libelle_mois_facturation     ,
    NULL                                                                                    AS periode_comptable            ,
    NULL                                                                                    AS annee_comptable              ,
    NULL                                                                                    AS mois_comptable               ,
    NULL                                                                                    AS libelle_mois_comptable       ,
    0                                                                                       AS quantite                     ,
    ht_amount                                                                               AS montant_ca_brut_ht           ,
    ht_amount                                                                               AS montant_ca_net_ht            ,
    0                                                                                       AS montant_remise_ht            ,
    CAST(revenue_year AS INT)                                                               AS facturation_part_yyyy

FROM ${database_safe}.${table_ca_mensuel_delivengo}

WHERE CAST(revenue_year AS INT) > YEAR(CURRENT_DATE()) - ${nb_annee}

;
