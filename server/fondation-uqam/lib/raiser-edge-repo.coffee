async = require 'async'
Iconv  = require('iconv').Iconv
Buffer = require('buffer').Buffer

settings = {};
oracle = require("strong-oracle")(settings);

connectData = {"hostname": "jupiter.si.uqam.ca:1521/OMNID", "user": process.env.DB_USER_NAME, "password": process.env.DB_PASSWORD};

random = (low, high) ->
  return Math.random() * (high - low) + low;

exports.getCoordonnees = (callback) ->
  t = oracle.connect connectData,
    (err, connection) ->
      connection.execute "SELECT * FROM FOND_MAJ_WEB", [],
        (err, results) ->
          connection.close()
          if (err)
            callback err, null
          else
            callback null, results

exports.ajouterCoordonnees = (coordonnees, callback) ->
  oracle.connect connectData,
    (err, connection) ->
      connection.execute "INSERT INTO FOND_MAJ_WEB (NOM, PRENOM, CODE_PERMANENT, DATE_NAISSANCE, SEXE, CARTE_PRIVILEGE, NO_CIVIQUE_RES, RUE_RES, APPARTEMENT_RES, VILLE_RES, CODE_POSTAL_RES, CASE_POSTAL_RES, CODE_PROVINCE_RES, CODE_PAYS_RES, TELEPHONE_RES, COURRIEL_RES, COMPAGNIE, TITRE_FONCTION_CIE, NO_CIVIQUE_CIE, RUE_CIE, VILLE_CIE, CODE_POSTAL_CIE, CASE_POSTAL_CIE, CODE_PROVINCE_CIE, CODE_PAYS_CIE, TELEPHONE_CIE, POSTE_CIE, COURRIEL_CIE, SITE_WEB_CIE, MAJ_WEB_SEQUENCE) VALUES(:NOM, :PRENOM, :CODE_PERMANENT, TO_DATE ( SUBSTR ( :DATE_NAISSANCE, 0, 10), 'DD-MM-YYYY'), :SEXE, :CARTE_PRIVILEGE, :NO_CIVIQUE_RES, :APPARTEMENT_RES, :RUE_RES, :VILLE_RES, :CODE_POSTAL_RES, :CASE_POSTAL_RES, :CODE_PROVINCE_RES, :CODE_PAYS_RES, :TELEPHONE_RES, :COURRIEL_RES, :COMPAGNIE, :TITRE_FONCTION_CIE, :NO_CIVIQUE_CIE, :RUE_CIE, :VILLE_CIE, :CODE_POSTAL_CIE, : CASE_POSTAL_CIE, :CODE_PROVINCE_CIE, :CODE_PAYS_CIE, :TELEPHONE_CIE, :POSTE_CIE, :COURRIEL_CIE, :SITE_WEB_CIE, FOND_MAJ_WEB_SEQUENCE_SEQ.NEXTVAL)",
        [
          coordonnees.nom,
          coordonnees.prenom,
          coordonnees.codePermanent,
          coordonnees.dateNaissance,
          coordonnees.sexe,
          coordonnees.cartePrivilege,
          coordonnees.residence.no,
          coordonnees.residence.rue,
          coordonnees.residence.appartement,
          coordonnees.residence.ville,
          coordonnees.residence.codePostal,
          coordonnees.residence.casePostale,
          coordonnees.residence.province,
          coordonnees.residence.pays,
          coordonnees.residence.telephone,
          coordonnees.residence.courriel,
          coordonnees.travail.nom,
          coordonnees.travail.titre,
          coordonnees.travail.no,
          coordonnees.travail.rue,
          coordonnees.travail.ville,
          coordonnees.travail.codePostal,
          coordonnees.travail.casePostale,
          coordonnees.travail.province,
          coordonnees.travail.pays,
          coordonnees.travail.telephone,
          coordonnees.travail.poste,
          coordonnees.travail.courriel,
          coordonnees.travail.siteWeb
        ],
        {isAutoCommit: true},
        (err, results) ->
          connection.close()
          if (err)
            callback err, err.message
          else
            callback null, results


exports.supprimerCoordonnee = (id, callback) ->
  oracle.connect connectData,
    (err, connection) ->
      connection.execute "DELETE FROM FOND_MAJ_WEB WHERE MAJ_WEB_SEQUENCE=:id",
        [id],
        {isAutoCommit: true},
        (err, results) ->
          connection.close()
          if (err)
            callback err, err.message
          else
            callback null, results