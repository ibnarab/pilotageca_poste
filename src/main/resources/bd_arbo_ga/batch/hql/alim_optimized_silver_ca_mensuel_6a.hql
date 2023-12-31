-- TRUNCATE TABLE fait dans le lanceur

INSERT OVERWRITE TABLE ${database_optimized}.${table_ca_mensuel_6a}

SELECT

    code_dom_fact                                   ,
    code_appli_source                               ,
    code_pdt_dom_fact                               ,
    code_art_cabestan                               ,
    libelle_art_cabestan                            ,
    code_ss_pdt_cabestan                            ,
    libelle_ss_pdt_cabestan                         ,
    code_pdt_ser_cabestan                           ,
    libelle_pdt_ser_cabestan                        ,
    indicateur_cap                                  ,
    code_offre_ops                                  ,
    libelle_offre_ops                               ,
    code_remise_dom_fact                            ,
    code_remise_cabestan                            ,
    libelle_remise_cabestan                         ,
    code_type_remise_cabestan                       ,
    type_remise_cabestan                            ,
    code_cli_dom_fact                               ,
    code_cli_courrier                               ,
    raison_soc_cli_courrier                         ,
    enseigne_cli                                    ,
    code_type_cli                                   ,
    libelle_type_cli                                ,
    num_bon_de_commande                             ,
    num_contrat                                     ,
    num_contrat_chapeau                             ,
    num_machine_affranchir                          ,
    num_titre_publication                           ,
    titre_publication                               ,
    num_parution                                    ,
    type_parution                                   ,
    num_facture                                     ,
    code_mode_affranchissement                      ,
    periode_prestation                              ,
    annee_prestation                                ,
    mois_prestation                                 ,
    libelle_mois_prestation                         ,
    periode_facturation                             ,
    annee_facturation                               ,
    mois_facturation                                ,
    libelle_mois_facturation                        ,
    periode_comptable                               ,
    annee_comptable                                 ,
    mois_comptable                                  ,
    libelle_mois_comptable                          ,
    SUM(quantite)           AS quantite             ,
    SUM(montant_ca_brut_ht) AS montant_ca_brut_ht   ,
    SUM(montant_ca_net_ht)  AS montant_ca_net_ht    ,
    SUM(montant_remise_ht)  AS montant_remise_ht    ,
    facturation_part_yyyy   AS facturation_part_yyyy

FROM ${database_safe}.${table_ca_mensuel_consolide}
WHERE facturation_part_yyyy > YEAR(CURRENT_DATE()) - ${nb_annee}
GROUP BY

    code_dom_fact               ,
    code_appli_source           ,
    code_pdt_dom_fact           ,
    code_art_cabestan           ,
    libelle_art_cabestan        ,
    code_ss_pdt_cabestan        ,
    libelle_ss_pdt_cabestan     ,
    code_pdt_ser_cabestan       ,
    libelle_pdt_ser_cabestan    ,
    indicateur_cap              ,
    code_offre_ops              ,
    libelle_offre_ops           ,
    code_remise_dom_fact        ,
    code_remise_cabestan        ,
    libelle_remise_cabestan     ,
    code_type_remise_cabestan   ,
    type_remise_cabestan        ,
    code_cli_dom_fact           ,
    code_cli_courrier           ,
    raison_soc_cli_courrier     ,
    enseigne_cli                ,
    code_type_cli               ,
    libelle_type_cli            ,
    num_bon_de_commande         ,
    num_contrat                 ,
    num_contrat_chapeau         ,
    num_machine_affranchir      ,
    num_titre_publication       ,
    titre_publication           ,
    num_parution                ,
    type_parution               ,
    num_facture                 ,
    code_mode_affranchissement  ,
    periode_prestation          ,
    annee_prestation            ,
    mois_prestation             ,
    libelle_mois_prestation     ,
    periode_facturation         ,
    annee_facturation           ,
    mois_facturation            ,
    libelle_mois_facturation    ,
    periode_comptable           ,
    annee_comptable             ,
    mois_comptable              ,
    libelle_mois_comptable      ,
    facturation_part_yyyy
;
