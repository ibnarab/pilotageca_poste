WITH

refpm AS        (
                SELECT
                      so.custsubaccnumber
                    , so.custaccnumber
                    , client.compname
                    , client.brandname
                    , client.custtypecode
                    , IF(client.custtypecode ='0', "privé","public") AS custtypelabel
                FROM    (
                        SELECT
                              custaccnumber
                            , custsubaccnumber
                            , subsidiaryname
                            , ROW_NUMBER() OVER(PARTITION BY custsubaccnumber ORDER BY importdatetime DESC) rang
                        FROM ${database_safe_rcom}.${table_refpmclient_client_lien_so}
                        WHERE subsidiaryname = 'TL'
                        ) so
                LEFT JOIN ${database_safe_rcom}.${table_refpmclient_client}  AS client              ON so.custaccnumber = client.id
                WHERE so.rang = 1
                )


, cabestan AS   (
                SELECT
                    code_pdt_filiale,
                    code_produit,
                    libelle_produit,
                    code_ss_pdt,
                    libelle_ss_pdt,
                    indic_pac
                FROM ${database_safe_rcom}.${table_safe_cabestan_catalogue}
                WHERE code_type_filiale = '90'
                )


, calendrier AS (
      SELECT DISTINCT mois, libelle_mois
      FROM ${database_safe_div}.${table_safe_calendrier}
  )

-- ASPHERIA


INSERT  INTO ${database_safe_xcom}.${table_ca_mensuel_docaposte}

SELECT

        A_FACTU.subsidiary_id
    ,    CONCAT("A",A_FACTU.account_number) AS account_number
    ,    A_FACTU.reference_year
    ,    A_FACTU.reference_month
    ,    A_FACTU.product_code
    ,    A_FACTU.revenue_amount
    ,    A_FACTU.providor_seller_sector_code
    ,    A_CLIENT.company_name
    ,    A_CLIENT.siren_code
    ,    A_CLIENT.nic_code
    ,    A_CLIENT.address_l2
    ,    A_CLIENT.address_l3
    ,    A_CLIENT.address_l4
    ,    A_CLIENT.address_l5
    ,    A_CLIENT.zip_code
    ,    A_CLIENT.town
    ,    A_CLIENT.country
    ,    A_CLIENT.department_code
    ,    A_CLIENT.framework_agreement_code
    ,    A_CLIENT.creation_date
    ,    A_CLIENT.termination_date
    ,    A_PRODUIT.product_label
    ,    A_PRODUIT.family_code
    ,    A_FAMILLE.family_label
    ,    A_ACCCADRE.framework_agreement_label
    ,    A_FACTU.date_import
    ,    cabestan.code_produit
    ,    cabestan.libelle_produit
    ,    cabestan.code_ss_pdt
    ,    CASE
        WHEN cabestan.libelle_ss_pdt IS NOT NULL THEN cabestan.libelle_ss_pdt
        ELSE cabestan.libelle_produit
        END
    ,    cabestan.indic_pac                                                            AS cabestan_indicateur_cap
    ,    refpm.custaccnumber
    ,     refpm.compname
    ,   refpm.brandname                                                                AS refpm_brand_name
    ,   refpm.custtypecode                                                             AS refpm_customer_type_code
    ,   refpm.custtypelabel                                                            AS refpm_customer_type_label
    ,   calendrier.libelle_mois                                                        AS reference_month_label



FROM

    ${database_safe_xcom}.${table_docaposte_aspheria_facture} AS A_FACTU
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_aspheria_client} AS A_CLIENT          ON A_FACTU.account_number = A_CLIENT.account_number and A_FACTU.providor_seller_sector_code = A_CLIENT.providor_seller_sector_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_aspheria_produit} AS A_PRODUIT        ON A_FACTU.product_code = A_PRODUIT.product_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_aspheria_famille} AS A_FAMILLE        ON A_FAMILLE.family_code = A_PRODUIT.family_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_aspheria_accordcadre} AS A_ACCCADRE   ON A_CLIENT.framework_agreement_code = A_ACCCADRE.framework_agreement_code
    LEFT JOIN
    cabestan                                                                         ON A_FACTU.product_code = cabestan.code_pdt_filiale
    LEFT JOIN
    refpm                                                                             ON CONCAT("A",A_FACTU.account_number)  = refpm.custsubaccnumber
    LEFT JOIN
    calendrier                                                                     ON CAST(A_FACTU.reference_month AS INT) = calendrier.mois




UNION

-- BPO



SELECT

        E_FACTU.subsidiary_id
    ,    CONCAT("E",E_FACTU.account_number) AS account_number
    ,    E_FACTU.reference_year
    ,    E_FACTU.reference_month
    ,    E_FACTU.product_code
    ,    E_FACTU.revenue_amount
    ,    E_FACTU.providor_seller_sector_code
    ,    E_CLIENT.company_name
    ,    E_CLIENT.siren_code
    ,    E_CLIENT.nic_code
    ,    E_CLIENT.address_l2
    ,    E_CLIENT.address_l3
    ,    E_CLIENT.address_l4
    ,    E_CLIENT.address_l5
    ,    E_CLIENT.zip_code
    ,    E_CLIENT.town
    ,    E_CLIENT.country
    ,    E_CLIENT.department_code
    ,    E_CLIENT.framework_agreement_code
    ,    E_CLIENT.creation_date
    ,    E_CLIENT.termination_date
    ,    E_PRODUIT.product_label
    ,     E_PRODUIT.family_code
    ,    E_FAMILLE.family_label
    ,    E_ACCCADRE.framework_agreement_label
    ,    E_FACTU.date_import
    ,    cabestan.code_produit
    ,    cabestan.libelle_produit
    ,    cabestan.code_ss_pdt
    ,    CASE
        WHEN cabestan.libelle_ss_pdt IS NOT NULL THEN cabestan.libelle_ss_pdt
        ELSE cabestan.libelle_produit
        END
    ,   cabestan.indic_pac                                                             AS cabestan_indicateur_cap
    ,    refpm.custaccnumber
    ,     refpm.compname
    ,   refpm.brandname                                                                AS refpm_brand_name
    ,   refpm.custtypecode                                                             AS refpm_customer_type_code
    ,   refpm.custtypelabel                                                            AS refpm_customer_type_label
    ,   calendrier.libelle_mois                                                        AS reference_month_label




FROM

    ${database_safe_xcom}.${table_docaposte_bpo_facture} AS E_FACTU
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_bpo_client} AS E_CLIENT         ON E_FACTU.account_number = E_CLIENT.account_number
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_bpo_produit} AS E_PRODUIT       ON E_FACTU.product_code = E_PRODUIT.product_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_bpo_famille} AS E_FAMILLE       ON E_FAMILLE.family_code = E_PRODUIT.family_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_bpo_accordcadre} AS E_ACCCADRE  ON E_CLIENT.framework_agreement_code = E_ACCCADRE.framework_agreement_code
    LEFT JOIN
    cabestan                                                                   ON E_FACTU.product_code = cabestan.code_pdt_filiale
    LEFT JOIN
    refpm                                                                       ON CONCAT("E",E_FACTU.account_number)  = refpm.custsubaccnumber
    LEFT JOIN
    calendrier                                                                     ON CAST(E_FACTU.reference_month AS INT) = calendrier.mois



UNION

-- BRETAGNE_ROUTAGE



SELECT

        B_FACTU.subsidiary_id
    ,    CONCAT("B",B_FACTU.account_number) AS account_number
    ,    B_FACTU.reference_year
    ,    B_FACTU.reference_month
    ,    B_FACTU.product_code
    ,    B_FACTU.revenue_amount
    ,    B_FACTU.providor_seller_sector_code
    ,    B_CLIENT.company_name
    ,    B_CLIENT.siren_code
    ,    B_CLIENT.nic_code
    ,    B_CLIENT.address_l2
    ,    B_CLIENT.address_l3
    ,    B_CLIENT.address_l4
    ,    B_CLIENT.address_l5
    ,    B_CLIENT.zip_code
    ,    B_CLIENT.town
    ,    B_CLIENT.country
    ,    B_CLIENT.department_code
    ,    B_CLIENT.framework_agreement_code
    ,    B_CLIENT.creation_date
    ,    B_CLIENT.termination_date
    ,    B_PRODUIT.product_label
    ,     B_PRODUIT.family_code
    ,    B_FAMILLE.family_label
    ,    B_ACCCADRE.framework_agreement_label
    ,    B_FACTU.date_import
    ,    cabestan.code_produit
    ,    cabestan.libelle_produit
    ,    cabestan.code_ss_pdt
    ,    CASE
        WHEN cabestan.libelle_ss_pdt IS NOT NULL THEN cabestan.libelle_ss_pdt
        ELSE cabestan.libelle_produit
        END
    ,   cabestan.indic_pac                                                             AS cabestan_indicateur_cap
    ,    refpm.custaccnumber
    ,     refpm.compname
    ,   refpm.brandname                                                                AS refpm_brand_name
    ,   refpm.custtypecode                                                             AS refpm_customer_type_code
    ,   refpm.custtypelabel                                                            AS refpm_customer_type_label
    ,   calendrier.libelle_mois                                                        AS reference_month_label



FROM

    ${database_safe_xcom}.${table_docaposte_bretagne_routage_facture} AS B_FACTU
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_bretagne_routage_client} AS B_CLIENT         ON B_FACTU.account_number = B_CLIENT.account_number
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_bretagne_routage_produit} AS B_PRODUIT       ON B_FACTU.product_code = B_PRODUIT.product_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_bretagne_routage_famille} AS B_FAMILLE       ON B_FAMILLE.family_code = B_PRODUIT.family_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_bretagne_routage_accordcadre} AS B_ACCCADRE  ON B_CLIENT.framework_agreement_code = B_ACCCADRE.framework_agreement_code
    LEFT JOIN
    cabestan                                                                                ON B_FACTU.product_code = cabestan.code_pdt_filiale
    LEFT JOIN
    refpm                                                                                    ON CONCAT("B",B_FACTU.account_number)  = refpm.custsubaccnumber
    LEFT JOIN
    calendrier                                                                     ON CAST(B_FACTU.reference_month AS INT) = calendrier.mois





UNION

-- MAILEVA



SELECT

        T_FACTU.subsidiary_id
    ,    CONCAT("T",T_FACTU.account_number) AS account_number
    ,    T_FACTU.reference_year
    ,    T_FACTU.reference_month
    ,    T_FACTU.product_code
    ,    T_FACTU.revenue_amount
    ,    T_FACTU.providor_seller_sector_code
    ,    T_CLIENT.company_name
    ,    T_CLIENT.siren_code
    ,    T_CLIENT.nic_code
    ,    T_CLIENT.address_l2
    ,    T_CLIENT.address_l3
    ,    T_CLIENT.address_l4
    ,    T_CLIENT.address_l5
    ,    T_CLIENT.zip_code
    ,    T_CLIENT.town
    ,    T_CLIENT.country
    ,    T_CLIENT.department_code
    ,    T_CLIENT.framework_agreement_code
    ,    T_CLIENT.creation_date
    ,    T_CLIENT.termination_date
    ,    T_PRODUIT.product_label
    ,     T_PRODUIT.family_code
    ,    T_FAMILLE.family_label
    ,    T_ACCCADRE.framework_agreement_label
    ,    T_FACTU.date_import
    ,    cabestan.code_produit
    ,    cabestan.libelle_produit
    ,    cabestan.code_ss_pdt
    ,    CASE
        WHEN cabestan.libelle_ss_pdt IS NOT NULL THEN cabestan.libelle_ss_pdt
        ELSE cabestan.libelle_produit
        END
    ,   cabestan.indic_pac                                                             AS cabestan_indicateur_cap
    ,    refpm.custaccnumber
    ,     refpm.compname
    ,   refpm.brandname                                                                AS refpm_brand_name
    ,   refpm.custtypecode                                                             AS refpm_customer_type_code
    ,   refpm.custtypelabel                                                            AS refpm_customer_type_label
    ,   calendrier.libelle_mois                                                        AS reference_month_label



FROM

    ${database_safe_xcom}.${table_docaposte_maileva_facture} AS T_FACTU
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_maileva_client} AS T_CLIENT         ON T_FACTU.account_number = T_CLIENT.account_number
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_maileva_produit} AS T_PRODUIT       ON T_FACTU.product_code = T_PRODUIT.product_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_maileva_famille} AS T_FAMILLE       ON T_FAMILLE.family_code = T_PRODUIT.family_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_maileva_accordcadre} AS T_ACCCADRE  ON T_CLIENT.framework_agreement_code = T_ACCCADRE.framework_agreement_code
    LEFT JOIN
    cabestan                                                                       ON T_FACTU.product_code = cabestan.code_pdt_filiale
    LEFT JOIN
    refpm                                                                           ON CONCAT("T",T_FACTU.account_number)  = refpm.custsubaccnumber
    LEFT JOIN
    calendrier                                                                     ON CAST(T_FACTU.reference_month AS INT) = calendrier.mois

UNION


-- ORSID



SELECT

        O_FACTU.subsidiary_id
    ,    CONCAT("O",O_FACTU.account_number) AS account_number
    ,    O_FACTU.reference_year
    ,    O_FACTU.reference_month
    ,    O_FACTU.product_code
    ,    O_FACTU.revenue_amount
    ,    O_FACTU.providor_seller_sector_code
    ,    O_CLIENT.company_name
    ,    O_CLIENT.siren_code
    ,    O_CLIENT.nic_code
    ,    O_CLIENT.address_l2
    ,    O_CLIENT.address_l3
    ,    O_CLIENT.address_l4
    ,    O_CLIENT.address_l5
    ,    O_CLIENT.zip_code
    ,    O_CLIENT.town
    ,    O_CLIENT.country
    ,    O_CLIENT.department_code
    ,    O_CLIENT.framework_agreement_code
    ,    O_CLIENT.creation_date
    ,    O_CLIENT.termination_date
    ,    O_PRODUIT.product_label
    ,     O_PRODUIT.family_code
    ,    O_FAMILLE.family_label
    ,    O_ACCCADRE.framework_agreement_label
    ,    O_FACTU.date_import
    ,    cabestan.code_produit
    ,    cabestan.libelle_produit
    ,    cabestan.code_ss_pdt
    ,    CASE
        WHEN cabestan.libelle_ss_pdt IS NOT NULL THEN cabestan.libelle_ss_pdt
        ELSE cabestan.libelle_produit
        END
    ,   cabestan.indic_pac                                                             AS cabestan_indicateur_cap
    ,    refpm.custaccnumber
    ,     refpm.compname
    ,   refpm.brandname                                                                AS refpm_brand_name
    ,   refpm.custtypecode                                                             AS refpm_customer_type_code
    ,   refpm.custtypelabel                                                            AS refpm_customer_type_label
    ,   calendrier.libelle_mois                                                        AS reference_month_label




FROM

    ${database_safe_xcom}.${table_docaposte_orsid_facture} AS O_FACTU
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_orsid_client} AS O_CLIENT         ON O_FACTU.account_number = O_CLIENT.account_number
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_orsid_produit} AS O_PRODUIT       ON O_FACTU.product_code = O_PRODUIT.product_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_orsid_famille} AS O_FAMILLE       ON O_FAMILLE.family_code = O_PRODUIT.family_code
    LEFT JOIN
    ${database_safe_xcom}.${table_docaposte_orsid_accordcadre} AS O_ACCCADRE  ON O_CLIENT.framework_agreement_code = O_ACCCADRE.framework_agreement_code
    LEFT JOIN
    cabestan                                                                      ON O_FACTU.product_code = cabestan.code_pdt_filiale
    LEFT JOIN
    refpm                                                                         ON CONCAT("O",O_FACTU.account_number)  = refpm.custsubaccnumber
    LEFT JOIN
    calendrier                                                                     ON CAST(O_FACTU.reference_month AS INT) = calendrier.mois
;
