-- TRUNCATE TABLE fait dans le lanceur safe

INSERT OVERWRITE TABLE ${database_safe}.${table_ca_mensuel_galion}

SELECT DISTINCT

    la.invoice_id                                                   AS invoice_id                               ,
    la.invoice_detail_line_number                                   AS invoice_detail_line_number               ,
    la.article_code                                                 AS article_code                             ,
    la.attached_invoice_id                                          AS attached_invoice_id                      ,
    la.attached_invoice_line_number                                 AS attached_invoice_line_number             ,
    la.article_label                                                AS article_label                            ,
    la.invoice_line_quantity                                        AS invoice_line_quantity                    ,
    la.unit_price_ht                                                AS unit_price_ht                            ,
    la.article_line_amount_ht                                       AS article_line_amount_ht                   ,
    la.tax_code                                                     AS tax_code                                 ,
    la.franking_mode_code                                           AS franking_mode_code                       ,
    la.invoice_line_tax_rate                                        AS invoice_line_tax_rate                    ,
    la.billing_order_number                                         AS billing_order_number                     ,
    la.billing_order_origin_code                                    AS billing_order_origin_code                ,
    la.downgrading_reason_code                                      AS downgrading_reason_code                  ,
    la.downgrading_reason_label                                     AS downgrading_reason_label                 ,
    la.sender_customer_code                                         AS sender_customer_code                     ,
    la.deposit_date                                                 AS deposit_date                             ,
    la.deposit_establishment_code                                   AS deposit_establishment_code               ,
    la.semaphore_note_id                                            AS semaphore_note_id                        ,
    la.semaphore_customer_note_id                                   AS semaphore_customer_note_id               ,
    la.tax_amount                                                   AS tax_amount                               ,
    la.destination_zone_code                                        AS destination_zone_code                    ,
    la.tax_rule_code                                                AS tax_rule_code                            ,
    NULL                                                            AS invoice_discount_line_number             ,
    NULL                                                            AS discount_code                            ,
    NULL                                                            AS discount_base                            ,
    NULL                                                            AS discount_line_percentage                 ,
    NULL                                                            AS discount_line_fixed_amount               ,
    NULL                                                            AS discount_line_unit_amount                ,
    NULL                                                            AS discount_line_amount_ht                  ,
    NULL                                                            AS discount_line_tax_code                   ,
    NULL                                                            AS discount_line_tax_rate                   ,
    NULL                                                            AS discount_type_code                       ,
    f.invoice_or_credit_number                                      AS invoice_or_credit_number                 ,
    f.invoice_type                                                  AS invoice_type                             ,
    f.invoice_generation_date                                       AS invoice_generation_date                  ,
    f.invoice_due_date                                              AS invoice_due_date                         ,
    f.invoice_support_code                                          AS invoice_support_code                     ,
    f.invoice_type_code                                             AS invoice_type_code                        ,
    f.asap_invoice_indicator                                        AS asap_invoice_indicator                   ,
    f.payment_type_code                                             AS payment_type_code                        ,
    f.reimbursement_type_code                                       AS reimbursement_type_code                  ,
    f.refund_period                                                 AS refund_period                            ,
    f.billing_start_date                                            AS billing_start_date                       ,
    f.billing_end_date                                              AS billing_end_date                         ,
    f.invoice_gross_total_amount_ht                                 AS invoice_gross_total_amount_ht            ,
    f.invoice_discount_total_amount_ht                              AS invoice_discount_total_amount_ht         ,
    f.invoice_net_total_amount_ht                                   AS invoice_net_total_amount_ht              ,
    f.invoice_net_total_amount_ttc                                  AS invoice_net_total_amount_ttc             ,
    f.invoice_tax_total_amount                                      AS invoice_tax_total_amount                 ,
    f.total_amount_already_paid_ttc                                 AS total_amount_already_paid_ttc            ,
    f.amount_to_be_paid                                             AS amount_to_be_paid                        ,
    f.contractual_discount_amount_ht                                AS contractual_discount_amount_ht           ,
    f.customer_id                                                   AS customer_id                              ,
    f.customer_id_extension_code                                    AS customer_id_extension_code               ,
    f.vat_customer_indicator                                        AS vat_customer_indicator                   ,
    f.master_customer_id                                            AS master_customer_id                       ,
    f.master_customer_id_extension                                  AS master_customer_id_extension             ,
    f.customer_account_nature_code                                  AS customer_account_nature_code             ,
    f.billing_back_office_wallet_code                               AS billing_back_office_wallet_code          ,
    NVL(bdc.contract_number, f.contract_number)                     AS contract_number                          ,
    f.hat_contract_number                                           AS hat_contract_number                      ,
    f.contract_format_code                                          AS contract_format_code                     ,
    f.billing_adress_id                                             AS billing_adress_id                        ,
    f.direct_debit_bank_details                                     AS direct_debit_bank_details                ,
    f.bank_transfer_bank_details                                    AS bank_transfer_bank_details               ,
    f.payment_deadline                                              AS payment_deadline                         ,
    f.first_billing_month_number                                    AS first_billing_month_number               ,
    f.billing_frequency                                             AS billing_frequency                        ,
    f.last_billed_operation_date                                    AS last_billed_operation_date               ,
    f.contract_model_code                                           AS contract_model_code                      ,
    f.complex_contract_mode                                         AS complex_contract_mode                    ,
    f.billing_sector_code                                           AS billing_sector_code                      ,
    c.seller_sector_code                                            AS seller_sector_code                       ,
    c.commercial_entity_code                                        AS commercial_entity_code                   ,
    c.recovery_division_code                                        AS recovery_division_code                   ,
    c.payment_period                                                AS payment_period                           ,
    c.customer_naf_code                                             AS customer_naf_code                        ,
    c.customer_siren                                                AS customer_siren                           ,
    c.customer_nic                                                  AS customer_nic                             ,
    c.customer_account_category_code                                AS customer_account_category_code           ,
    c.customer_type_code                                            AS customer_type_code                       ,
    c.name_recipient_institution_label                              AS name_recipient_institution_label         ,
    c.recipient_establishment_subdivision_name                      AS recipient_establishment_subdivision_name ,
    c.recipient_address_line_description_3                          AS recipient_address_line_description_3     ,
    c.recipient_address_line_description_4                          AS recipient_address_line_description_4     ,
    c.recipient_address_line_description_5                          AS recipient_address_line_description_5     ,
    c.recipient_address_line_description_6                          AS recipient_address_line_description_6     ,
    c.competitor_customer_indicator                                 AS competitor_customer_indicator            ,
    bdc.corrected_billing_order_number                              AS corrected_billing_order_number           ,
    bdc.establishment_code                                          AS establishment_code                       ,
    bdc.accounting_year                                             AS accounting_year                          ,
    bdc.accounting_month                                            AS accounting_month                         ,
    bdc.service_start_date                                          AS service_start_date                       ,
    bdc.service_end_date                                            AS service_end_date                         ,
    bdc.credit_note_reference_invoice_number                        AS credit_note_reference_invoice_number     ,
    bdc.payment_amount                                              AS payment_amount                           ,
    bdc.payment_date                                                AS payment_date                             ,
    bdc.payment_number                                              AS payment_number                           ,
    bdc.payment_place_establishment_code                            AS payment_place_establishment_code         ,
    bdc.service_number                                              AS service_number                           ,
    bdc.specific_header1                                            AS specific_header1                         ,
    bdc.specific_header2                                            AS specific_header2                         ,
    bdc.specific_header3                                            AS specific_header3                         ,
    bdc.specific_header4                                            AS specific_header4                         ,
    bdc.specific_header5                                            AS specific_header5                         ,
    bdc.billing_order_amount_ht                                     AS billing_order_amount_ht                  ,
    bdc.billing_order_message                                       AS billing_order_message                    ,
    bdc.billing_order_type_code                                     AS billing_order_type_code                  ,
    bdc.franking_machine_postal_type_code                           AS franking_machine_postal_type_code        ,
    bdc.franking_machine_serial_number                              AS franking_machine_serial_number           ,
    bdc.franking_machine_category_code                              AS franking_machine_category_code           ,
    bdc.sales_channel_code                                          AS sales_channel_code                       ,
    bdc.sales_channel_label                                         AS sales_channel_label                      ,
    bdc.seller_code                                                 AS seller_code                              ,
    bdc.supply_mode_indicator                                       AS supply_mode_indicator                    ,
    bdc.eva_norm_indicator                                          AS eva_norm_indicator                       ,
    bdc.eva_visa_indicator                                          AS eva_visa_indicator                       ,
    bdc.mail_product_contract_type_code                             AS mail_product_contract_type_code          ,
    bdc.mail_product_contract_id                                    AS mail_product_contract_id                 ,
    bdc.mail_product_contract_number                                AS mail_product_contract_number             ,
    bdc.overlay_color                                               AS overlay_color                            ,
    bdc.cap_type_code                                               AS cap_type_code                            ,
    bdc.cap_id                                                      AS cap_id                                   ,
    bdc.cap_number                                                  AS cap_number                               ,
    bdc.intermediate_customer_id                                    AS intermediate_customer_id                 ,
    bdc.deadline_commitment_indicator                               AS deadline_commitment_indicator            ,
    bdc.meridien_contract_id                                        AS meridien_contract_id                     ,
    bdc.meridien_authorization_number                               AS meridien_authorization_number            ,
    bdc.distance_selling_indicator                                  AS distance_selling_indicator               ,
    bdc.external_piece_number                                       AS external_piece_number                    ,
    bdc.transmitter_system_code                                     AS transmitter_system_code                  ,
    bdc.customer_contract_reference                                 AS customer_contract_reference              ,
    bdc.execution_order_number                                      AS execution_order_number                   ,
    bdc.multi_transmitter_indicator                                 AS multi_transmitter_indicator              ,
    bdc.contractor_equals_depositor_indicator                       AS contractor_equals_depositor_indicator    ,
    bdc.accounting_document_number                                  AS accounting_document_number               ,
    bdc.external_customer_id                                        AS external_customer_id                     ,
    bdc.establishment_area_code                                     AS establishment_area_code                  ,
    bdc.tax_type_code                                               AS tax_type_code                            ,
    bdc.affranchigo_service_amount                                  AS affranchigo_service_amount               ,
    bdc.next_invoice_credit                                         AS next_invoice_credit                      ,
    la.date_import                                                  AS date_import                              ,
    cabestan.code_produit                                           AS cabestan_product_code                    ,
    cabestan.libelle_produit                                        AS cabestan_product_label                   ,
    cabestan.code_ss_pdt                                            AS cabestan_sub_product_code                ,
    cabestan.libelle_ss_pdt                                         AS cabestan_sub_product_label               ,
    cabestan.libelle_article                                        AS cabestan_item_label                      ,
    cabestan.indic_pac                                              AS cabestan_indicateur_cap                  ,
    NULL                                                            AS cabestan_discount_label                  ,
    NULL                                                            AS cabestan_discount_type_code              ,
    NULL                                                            AS cabestan_discount_type_label             ,
    NULL                                                            AS cabestan_net_revenue_involving_indicator ,
    TRIM(rpc.compname)                                              AS refpm_customer_name                      ,
    TRIM(rpc.brandname)                                             AS refpm_brand_name                         ,
    rpc.custtypecode                                                AS refpm_customer_type_code                 ,
    CASE WHEN rpc.custtypecode = 0 THEN 'privé' ELSE 'public' END   AS refpm_customer_type_label                ,
    TRIM(n_rpp.s_numero)                                            AS publipress_publication_title_number      ,
    TRIM(n_rpp.s_titre)                                             AS publipress_publication_title_label       ,
    pc.accounting_year_month                                        AS equinox_accounting_year_month            ,
    cal_prest.libelle_mois                                          AS service_month_label                      ,
    cal_fact.libelle_mois                                           AS billing_month_label                      ,
    cal_compt.libelle_mois                                          AS accounting_month_label                   ,
	CAST(SUBSTR(f.invoice_generation_date,1,4) AS INT)              AS invoice_generation_part_yyyy

FROM ${database_safe}.${table_galion_lignearticle} la

JOIN ${database_safe}.${table_galion_facture} f ON la.invoice_id = f.invoice_id

LEFT JOIN ${database_safe}.${table_galion_client} c ON c.customer_id = f.customer_id and c.customer_id_extension_code = f.customer_id_extension_code

LEFT JOIN ( SELECT *, CASE WHEN SUBSTR(specific_header1, 1, 6)='Publi=' THEN SUBSTR(specific_header1, LENGTH(specific_header1)-INSTR(reverse(specific_header1), ';') + 2) END AS specific_header
            FROM ${database_safe}.${table_galion_bondecommande}
            ) bdc ON la.billing_order_number = bdc.billing_order_number AND la.billing_order_origin_code = bdc.billing_order_origin_code

LEFT JOIN ${database_safe}.${table_equinox_periodecomptable} pc ON CAST(invoice_number AS INT) = la.invoice_id AND pc.operating_system_code='GA'

LEFT JOIN ${database_safe_rcom}.${table_refpublipresse_publication} n_rpp ON n_rpp.s_numero = bdc.specific_header

LEFT JOIN ${database_safe_rcom}.${table_refpmclient_client} rpc ON rpc.id = f.customer_id

LEFT JOIN (SELECT DISTINCT code_article, libelle_article, code_ss_pdt, NVL(libelle_ss_pdt, libelle_produit) AS libelle_ss_pdt, code_produit, libelle_produit, indic_pac
           FROM ${database_safe_rcom}.${table_safe_cabestan_catalogue}) cabestan on la.article_code = cabestan.code_article

LEFT JOIN (SELECT DISTINCT mois, libelle_mois
     FROM ${database_safe_div}.${table_safe_calendrier}
     WHERE annee = YEAR(CURRENT_DATE())) cal_prest ON SUBSTR(bdc.service_start_date,6,2) = cal_prest.mois

LEFT JOIN (SELECT DISTINCT mois, libelle_mois
     FROM ${database_safe_div}.${table_safe_calendrier}
     WHERE annee = YEAR(CURRENT_DATE())) cal_fact ON SUBSTR(f.invoice_generation_date,6,2) = cal_fact.mois

LEFT JOIN (SELECT DISTINCT mois, libelle_mois
     FROM ${database_safe_div}.${table_safe_calendrier}
     WHERE annee = YEAR(CURRENT_DATE())) cal_compt ON SUBSTR(pc.accounting_year_month,7,2) = cal_compt.mois

WHERE SUBSTR(f.invoice_generation_date,1,4) > YEAR(CURRENT_DATE()) - ${nb_annee}


UNION


SELECT

    lr.invoice_id                                                   AS invoice_id                               ,
    NULL                                                            AS invoice_detail_line_number               ,
    NVL(la.article_code, cvr.code_art_pilotage)                     AS article_code                             ,
    lr.attached_invoice_id                                          AS attached_invoice_id                      ,
    lr.attached_invoice_line_number                                 AS attached_invoice_line_number             ,
    la.article_label                                                AS article_label                            ,
    NULL                                                            AS invoice_line_quantity                    ,
    NULL                                                            AS unit_price_ht                            ,
    NULL                                                            AS article_line_amount_ht                   ,
    NULL                                                            AS tax_code                                 ,
    NULL                                                            AS franking_mode_code                       ,
    NULL                                                            AS invoice_line_tax_rate                    ,
    lr.billing_order_number                                         AS billing_order_number                     ,
    lr.billing_order_origin_code                                    AS billing_order_origin_code                ,
    NULL                                                            AS downgrading_reason_code                  ,
    NULL                                                            AS downgrading_reason_label                 ,
    NULL                                                            AS sender_customer_code                     ,
    NULL                                                            AS deposit_date                             ,
    NULL                                                            AS deposit_establishment_code               ,
    NULL                                                            AS semaphore_note_id                        ,
    NULL                                                            AS semaphore_customer_note_id               ,
    lr.tax_amount                                                   AS tax_amount                               ,
    lr.destination_zone_code                                        AS destination_zone_code                    ,
    lr.tax_rule_code                                                AS tax_rule_code                            ,
    lr.invoice_discount_line_number                                 AS invoice_discount_line_number             ,
    lr.discount_code                                                AS discount_code                            ,
    lr.discount_base                                                AS discount_base                            ,
    lr.discount_line_percentage                                     AS discount_line_percentage                 ,
    lr.discount_line_fixed_amount                                   AS discount_line_fixed_amount               ,
    lr.discount_line_unit_amount                                    AS discount_line_unit_amount                ,
    lr.discount_line_amount_ht                                      AS discount_line_amount_ht                  ,
    lr.discount_line_tax_code                                       AS discount_line_tax_code                   ,
    lr.discount_line_tax_rate                                       AS discount_line_tax_rate                   ,
    lr.discount_type_code                                           AS discount_type_code                       ,
    f.invoice_or_credit_number                                      AS invoice_or_credit_number                 ,
    f.invoice_type                                                  AS invoice_type                             ,
    f.invoice_generation_date                                       AS invoice_generation_date                  ,
    f.invoice_due_date                                              AS invoice_due_date                         ,
    f.invoice_support_code                                          AS invoice_support_code                     ,
    f.invoice_type_code                                             AS invoice_type_code                        ,
    f.asap_invoice_indicator                                        AS asap_invoice_indicator                   ,
    f.payment_type_code                                             AS payment_type_code                        ,
    f.reimbursement_type_code                                       AS reimbursement_type_code                  ,
    f.refund_period                                                 AS refund_period                            ,
    f.billing_start_date                                            AS billing_start_date                       ,
    f.billing_end_date                                              AS billing_end_date                         ,
    f.invoice_gross_total_amount_ht                                 AS invoice_gross_total_amount_ht            ,
    f.invoice_discount_total_amount_ht                              AS invoice_discount_total_amount_ht         ,
    f.invoice_net_total_amount_ht                                   AS invoice_net_total_amount_ht              ,
    f.invoice_net_total_amount_ttc                                  AS invoice_net_total_amount_ttc             ,
    f.invoice_tax_total_amount                                      AS invoice_tax_total_amount                 ,
    f.total_amount_already_paid_ttc                                 AS total_amount_already_paid_ttc            ,
    f.amount_to_be_paid                                             AS amount_to_be_paid                        ,
    f.contractual_discount_amount_ht                                AS contractual_discount_amount_ht           ,
    f.customer_id                                                   AS customer_id                              ,
    f.customer_id_extension_code                                    AS customer_id_extension_code               ,
    f.vat_customer_indicator                                        AS vat_customer_indicator                   ,
    f.master_customer_id                                            AS master_customer_id                       ,
    f.master_customer_id_extension                                  AS master_customer_id_extension             ,
    f.customer_account_nature_code                                  AS customer_account_nature_code             ,
    f.billing_back_office_wallet_code                               AS billing_back_office_wallet_code          ,
    NVL(bdc.contract_number, f.contract_number)                     AS contract_number                          ,
    f.hat_contract_number                                           AS hat_contract_number                      ,
    f.contract_format_code                                          AS contract_format_code                     ,
    f.billing_adress_id                                             AS billing_adress_id                        ,
    f.direct_debit_bank_details                                     AS direct_debit_bank_details                ,
    f.bank_transfer_bank_details                                    AS bank_transfer_bank_details               ,
    f.payment_deadline                                              AS payment_deadline                         ,
    f.first_billing_month_number                                    AS first_billing_month_number               ,
    f.billing_frequency                                             AS billing_frequency                        ,
    f.last_billed_operation_date                                    AS last_billed_operation_date               ,
    f.contract_model_code                                           AS contract_model_code                      ,
    f.complex_contract_mode                                         AS complex_contract_mode                    ,
    f.billing_sector_code                                           AS billing_sector_code                      ,
    c.seller_sector_code                                            AS seller_sector_code                       ,
    c.commercial_entity_code                                        AS commercial_entity_code                   ,
    c.recovery_division_code                                        AS recovery_division_code                   ,
    c.payment_period                                                AS payment_period                           ,
    c.customer_naf_code                                             AS customer_naf_code                        ,
    c.customer_siren                                                AS customer_siren                           ,
    c.customer_nic                                                  AS customer_nic                             ,
    c.customer_account_category_code                                AS customer_account_category_code           ,
    c.customer_type_code                                            AS customer_type_code                       ,
    c.name_recipient_institution_label                              AS name_recipient_institution_label         ,
    c.recipient_establishment_subdivision_name                      AS recipient_establishment_subdivision_name ,
    c.recipient_address_line_description_3                          AS recipient_address_line_description_3     ,
    c.recipient_address_line_description_4                          AS recipient_address_line_description_4     ,
    c.recipient_address_line_description_5                          AS recipient_address_line_description_5     ,
    c.recipient_address_line_description_6                          AS recipient_address_line_description_6     ,
    c.competitor_customer_indicator                                 AS competitor_customer_indicator            ,
    bdc.corrected_billing_order_number                              AS corrected_billing_order_number           ,
    bdc.establishment_code                                          AS establishment_code                       ,
    bdc.accounting_year                                             AS accounting_year                          ,
    bdc.accounting_month                                            AS accounting_month                         ,
    bdc.service_start_date                                          AS service_start_date                       ,
    bdc.service_end_date                                            AS service_end_date                         ,
    bdc.credit_note_reference_invoice_number                        AS credit_note_reference_invoice_number     ,
    bdc.payment_amount                                              AS payment_amount                           ,
    bdc.payment_date                                                AS payment_date                             ,
    bdc.payment_number                                              AS payment_number                           ,
    bdc.payment_place_establishment_code                            AS payment_place_establishment_code         ,
    bdc.service_number                                              AS service_number                           ,
    bdc.specific_header1                                            AS specific_header1                         ,
    bdc.specific_header2                                            AS specific_header2                         ,
    bdc.specific_header3                                            AS specific_header3                         ,
    bdc.specific_header4                                            AS specific_header4                         ,
    bdc.specific_header5                                            AS specific_header5                         ,
    bdc.billing_order_amount_ht                                     AS billing_order_amount_ht                  ,
    bdc.billing_order_message                                       AS billing_order_message                    ,
    bdc.billing_order_type_code                                     AS billing_order_type_code                  ,
    bdc.franking_machine_postal_type_code                           AS franking_machine_postal_type_code        ,
    bdc.franking_machine_serial_number                              AS franking_machine_serial_number           ,
    bdc.franking_machine_category_code                              AS franking_machine_category_code           ,
    bdc.sales_channel_code                                          AS sales_channel_code                       ,
    bdc.sales_channel_label                                         AS sales_channel_label                      ,
    bdc.seller_code                                                 AS seller_code                              ,
    bdc.supply_mode_indicator                                       AS supply_mode_indicator                    ,
    bdc.eva_norm_indicator                                          AS eva_norm_indicator                       ,
    bdc.eva_visa_indicator                                          AS eva_visa_indicator                       ,
    bdc.mail_product_contract_type_code                             AS mail_product_contract_type_code          ,
    bdc.mail_product_contract_id                                    AS mail_product_contract_id                 ,
    bdc.mail_product_contract_number                                AS mail_product_contract_number             ,
    bdc.overlay_color                                               AS overlay_color                            ,
    bdc.cap_type_code                                               AS cap_type_code                            ,
    bdc.cap_id                                                      AS cap_id                                   ,
    bdc.cap_number                                                  AS cap_number                               ,
    bdc.intermediate_customer_id                                    AS intermediate_customer_id                 ,
    bdc.deadline_commitment_indicator                               AS deadline_commitment_indicator            ,
    bdc.meridien_contract_id                                        AS meridien_contract_id                     ,
    bdc.meridien_authorization_number                               AS meridien_authorization_number            ,
    bdc.distance_selling_indicator                                  AS distance_selling_indicator               ,
    bdc.external_piece_number                                       AS external_piece_number                    ,
    bdc.transmitter_system_code                                     AS transmitter_system_code                  ,
    bdc.customer_contract_reference                                 AS customer_contract_reference              ,
    bdc.execution_order_number                                      AS execution_order_number                   ,
    bdc.multi_transmitter_indicator                                 AS multi_transmitter_indicator              ,
    bdc.contractor_equals_depositor_indicator                       AS contractor_equals_depositor_indicator    ,
    bdc.accounting_document_number                                  AS accounting_document_number               ,
    bdc.external_customer_id                                        AS external_customer_id                     ,
    bdc.establishment_area_code                                     AS establishment_area_code                  ,
    bdc.tax_type_code                                               AS tax_type_code                            ,
    bdc.affranchigo_service_amount                                  AS affranchigo_service_amount               ,
    bdc.next_invoice_credit                                         AS next_invoice_credit                      ,
    lr.date_import                                                  AS date_import                              ,
    cabestan.code_produit                                           AS cabestan_product_code                    ,
    cabestan.libelle_produit                                        AS cabestan_product_label                   ,
    cabestan.code_ss_pdt                                            AS cabestan_sub_product_code                ,
    cabestan.libelle_ss_pdt                                         AS cabestan_sub_product_label               ,
    cabestan.libelle_article                                        AS cabestan_item_label                      ,
    cabestan.indic_pac                                              AS cabestan_indicateur_cap                  ,
    cvr.libelle_ver_remise                                          AS cabestan_discount_label                  ,
    cvr.code_type_remise                                            AS cabestan_discount_type_code              ,
    CASE WHEN cvr.code_type_remise = '01' THEN 'Remise ponct. liée à une vente'
         WHEN cvr.code_type_remise = '02' THEN 'Rem. pct. non liée à une vente'
         WHEN cvr.code_type_remise = '03' THEN 'Remise contractuelle'
         WHEN cvr.code_type_remise = '04' THEN 'Remise contract. tous clients'
    END                                                             AS cabestan_discount_type_label             ,
    cvr.indic_particip_calcul_ca                                    AS cabestan_net_revenue_involving_indicator ,
    TRIM(rpc.compname)                                              AS refpm_customer_name                      ,
    TRIM(rpc.brandname)                                             AS refpm_brand_name                         ,
    rpc.custtypecode                                                AS refpm_customer_type_code                 ,
    CASE WHEN rpc.custtypecode = 0 THEN 'privé' ELSE 'public' END   AS refpm_customer_type_label                ,
    TRIM(n_rpp.s_numero)                                            AS publipress_publication_title_number      ,
    TRIM(n_rpp.s_titre)                                             AS publipress_publication_title_label       ,
    pc.accounting_year_month                                        AS equinox_accounting_year_month            ,
    cal_prest.libelle_mois                                          AS service_month_label                      ,
    cal_fact.libelle_mois                                           AS billing_month_label                      ,
    cal_compt.libelle_mois                                          AS accounting_month_label                   ,
	CAST(SUBSTR(f.invoice_generation_date,1,4) AS INT)              AS invoice_generation_part_yyyy

FROM ${database_safe}.${table_galion_ligneremise} lr

JOIN ${database_safe}.${table_galion_facture} f ON lr.invoice_id = f.invoice_id

LEFT JOIN ${database_safe}.${table_galion_client} c ON c.customer_id = f.customer_id and c.customer_id_extension_code = f.customer_id_extension_code

LEFT JOIN ( SELECT *, CASE WHEN SUBSTR(specific_header1, 1, 6)='Publi=' THEN SUBSTR(specific_header1, LENGTH(specific_header1)-INSTR(reverse(specific_header1), ';') + 2) END AS specific_header
            FROM ${database_safe}.${table_galion_bondecommande}
            ) bdc ON lr.billing_order_number = bdc.billing_order_number AND lr.billing_order_origin_code = bdc.billing_order_origin_code

LEFT JOIN ${database_safe}.${table_equinox_periodecomptable} pc ON CAST(invoice_number AS INT) = lr.invoice_id AND pc.operating_system_code='GA'

LEFT JOIN ${database_safe_rcom}.${table_refpublipresse_publication} n_rpp ON n_rpp.s_numero = bdc.specific_header

LEFT JOIN ${database_safe_rcom}.${table_refpmclient_client} rpc ON rpc.id = f.customer_id

LEFT JOIN ${database_safe}.${table_galion_lignearticle} la ON lr.attached_invoice_line_number = la.invoice_detail_line_number AND lr.attached_invoice_id = la.invoice_id AND lr.discount_type_code <> '02'

LEFT JOIN ( SELECT code_remise, code_type_remise, libelle_ver_remise, indic_particip_calcul_ca, code_art_pilotage
            FROM ${database_safe_rcom}.${table_safe_cabestan_remise}
            ) cvr ON lr.discount_code = cvr.code_remise

LEFT JOIN (SELECT DISTINCT code_article, libelle_article, code_ss_pdt, NVL(libelle_ss_pdt, libelle_produit) AS libelle_ss_pdt, code_produit, libelle_produit, indic_pac
           FROM ${database_safe_rcom}.${table_safe_cabestan_catalogue}) cabestan on cabestan.code_article = NVL(la.article_code, cvr.code_art_pilotage)

LEFT JOIN (SELECT DISTINCT mois, libelle_mois
     FROM ${database_safe_div}.${table_safe_calendrier}
     WHERE annee = YEAR(CURRENT_DATE())) cal_prest ON SUBSTR(bdc.service_start_date,6,2) = cal_prest.mois

LEFT JOIN (SELECT DISTINCT mois, libelle_mois
     FROM ${database_safe_div}.${table_safe_calendrier}
     WHERE annee = YEAR(CURRENT_DATE())) cal_fact ON SUBSTR(f.invoice_generation_date,6,2) = cal_fact.mois

LEFT JOIN (SELECT DISTINCT mois, libelle_mois
     FROM ${database_safe_div}.${table_safe_calendrier}
     WHERE annee = YEAR(CURRENT_DATE())) cal_compt ON SUBSTR(pc.accounting_year_month,7,2) = cal_compt.mois

WHERE SUBSTR(f.invoice_generation_date,1,4) > YEAR(CURRENT_DATE()) - ${nb_annee}

;
