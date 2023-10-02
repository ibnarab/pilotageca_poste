USE ${database};

DROP TABLE IF EXISTS ${table};

CREATE EXTERNAL TABLE ${table}
(
    code_dom_fact                       STRING      COMMENT "Code domaine facturier"                ,
    code_appli_source                   STRING      COMMENT "Code application source"               ,
    code_pdt_dom_fact                   STRING      COMMENT "Code produit domaine facturier"        ,
    code_art_cabestan                   STRING      COMMENT "Code article Cabestan"                 ,
    libelle_art_cabestan                STRING      COMMENT "Libellé article Cabestan"              ,
    code_ss_pdt_cabestan                STRING      COMMENT "Code Sous-produit Cabestan"            ,
    libelle_ss_pdt_cabestan             STRING      COMMENT "Libellé Sous-produit Cabestan"         ,
    code_pdt_ser_cabestan               STRING      COMMENT "Code Produit / Service Cabestan"       ,
    libelle_pdt_ser_cabestan            STRING      COMMENT "Libellé Produit / Service Cabestan"    ,
    indicateur_cap                      STRING      COMMENT "Indicateur CAP"                        ,
    code_offre_ops                      STRING      COMMENT "Code de l'offre OPS"                   ,
    libelle_offre_ops                   STRING      COMMENT "Libellé de l'offre OPS"                ,
    code_remise_dom_fact                STRING      COMMENT "Code remise domaine facturier"         ,
    code_remise_cabestan                STRING      COMMENT "Code remise Cabestan"                  ,
    libelle_remise_cabestan             STRING      COMMENT "Libellé remise Cabestan"               ,
    code_type_remise_cabestan           STRING      COMMENT "Code type remise Cabestan"             ,
    type_remise_cabestan                STRING      COMMENT "Type remise Cabestan"                  ,
    code_cli_dom_fact                   STRING      COMMENT "Code client domaine facturier"         ,
    code_cli_courrier                   STRING      COMMENT "Code client Courrier"                  ,
    raison_soc_cli_courrier             STRING      COMMENT "Raison sociale Client Courrier"        ,
    enseigne_cli                        STRING      COMMENT "Enseigne du client"                    ,
    code_type_cli                       STRING      COMMENT "Code type client"                      ,
    libelle_type_cli                    STRING      COMMENT "Libellé Type Client"                   ,
    num_bon_de_commande                 STRING      COMMENT "Numéro bon de commande"                ,
    num_contrat                         STRING      COMMENT "Numéro contrat"                        ,
    num_contrat_chapeau                 STRING      COMMENT "Numéro contrat chapeau"                ,
    num_machine_affranchir              STRING      COMMENT "Numéro machine à affranchir"           ,
    num_titre_publication               STRING      COMMENT "Numéro titre publication"              ,
    titre_publication                   STRING      COMMENT "Titre publication"                     ,
    num_parution                        STRING      COMMENT "Numéro parution"                       ,
    type_parution                       STRING      COMMENT "Type parution"                         ,
    num_facture                         STRING      COMMENT "Numéro de facture"                     ,
    code_mode_affranchissement          STRING      COMMENT "Code mode d'affranchissement"          ,
    periode_prestation                  STRING      COMMENT "Période prestation Format AAAA-MM"     ,
    annee_prestation                    STRING      COMMENT "Année prestation Format AAAA"          ,
    mois_prestation                     STRING      COMMENT "Mois prestation Format MM"             ,
    libelle_mois_prestation             STRING      COMMENT "Libellé du mois de prestation"         ,
    periode_facturation                 STRING      COMMENT "Période facturation Format AAAA-MM"    ,
    annee_facturation                   STRING      COMMENT "Année facturation Format AAAA"         ,
    mois_facturation                    STRING      COMMENT "Mois facturation Format MM"            ,
    libelle_mois_facturation            STRING      COMMENT "Libellé du mois de facturation"        ,
    periode_comptable                   STRING      COMMENT "Période comptable Format AAAA-MM"      ,
    annee_comptable                     STRING      COMMENT "Année comptable Format AAAA"           ,
    mois_comptable                      STRING      COMMENT "Mois comptable Format MM"              ,
    libelle_mois_comptable              STRING      COMMENT "Libellé du mois comptable"             ,
    quantite                            DEC(18,5)   COMMENT "Quantité"                              ,
    montant_ca_brut_ht                  DEC(18,5)   COMMENT "Montant CA brut HT"                    ,
    montant_ca_net_ht                   DEC(18,5)   COMMENT "Montant CA net HT"                     ,
    montant_remise_ht                   DEC(18,5)   COMMENT "Montant remise HT"
)
PARTITIONED BY (facturation_part_yyyy INT)
STORED AS PARQUET
LOCATION '${hdfs_path}'
;

--ALTER TABLE ${table}
--ADD CONSTRAINT pk_${table} PRIMARY KEY ()
--disable novalidate
--;
-- todo : mettre la clé technique