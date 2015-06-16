#require de node
path = require 'path'
uqamValidator = require 'uqam-validator'
raiserEdgeRepo = require './raiser-edge-repo'


exports.modifierFicheDiplome = (ficheDiplome, callback) ->
  #On a un object ficheDiplome, on peut commencer à appliquer les règle
  erreurs = {}

  #valider les informations personnelles
  if not uqamValidator.isLength ficheDiplome.nom, 1, 40
    erreurs.nom = 'Le nom doit contenir de 1 à 40 caractères'

  if not uqamValidator.isLength ficheDiplome.prenom, 1, 40
    erreurs.prenom = 'Le prénom doit contenir de 1 à 40 caractères'

  if ficheDiplome.sexe isnt 'F' and ficheDiplome.sexe isnt 'M'
    erreurs.sexe = 'Le sexe doit être F ou M'

  if ficheDiplome.codePermanent and not uqamValidator.isCodePermanent ficheDiplome.codePermanent
    erreurs.codePermanent = 'Code permanent invalide. Ex.: ABCD12345678'
  else if ficheDiplome.dateNaissance and ficheDiplome.sexe and uqamValidator.isCodePermanent ficheDiplome.codePermanent
    #valider le code permanent selon les règles
    cp = ficheDiplome.codePermanent.toUpperCase()

    cpNom = cp.substr 0, 3
    cpPrenom = cp.substr 3, 1
    cpJour = parseInt cp.substr 4, 2
    cpMois = parseInt cp.substr 6, 2
    cpAnnee = parseInt cp.substr 8, 2

    nom = ficheDiplome.nom.toUpperCase().substr 0, 3
    prenom = ficheDiplome.prenom.toUpperCase().substr 0, 1
    date = ficheDiplome.dateNaissance.split '-'

    jour = parseInt date[0]
    mois = parseInt date[1]
    annee = parseInt date[2]
    anneeLastDigit = parseInt annee.toString().substr 2, 2

    #le jour de naissance ou, si l'élève est né après 1999, le nombre résultant de l'addition du nombre 62 au jour de naissance;
    if annee > 1999
      jour += 62
    #le chiffre correspondant au mois de naissance, ou le nombre résultant de l'addition de 50 à ce chiffre si l'élève est de sexe féminin;
    if ficheDiplome.sexe == 'F'
      mois += 50

    if jour isnt cpJour or mois isnt cpMois or anneeLastDigit isnt cpAnnee or nom isnt cpNom or prenom isnt cpPrenom
      erreurs.codePermanentInvalide = 'Votre code permanent ne semble pas valide. Il ne correspond pas aux critères du ministère.'
    console.log jour, mois, anneeLastDigit, nom, prenom
    console.log cpJour, cpMois, cpAnnee, cpNom, cpPrenom


  #Information de résidence
  if ficheDiplome.residence
    if not uqamValidator.isLength ficheDiplome.residence.no, 0, 6
      erreurs.noResidence = 'Le numéro de résidence doit contenir au plus 6 caractères'

    if not uqamValidator.isLength ficheDiplome.residence.rue, 0, 30
      erreurs.rueResidence = 'Le numéro de résidence doit contenir au plus 30 caractères'

    if not uqamValidator.isLength ficheDiplome.residence.appartement, 0, 4
      erreurs.appartementResidence = 'Le numéro de résidence doit contenir au plus 4 caractères'

    if not uqamValidator.isLength ficheDiplome.residence.ville, 0, 45
      erreurs.villeResidence = 'Le nom de la ville doit contenir au plus 45 caractères'

    if ficheDiplome.residence.pays is 'CA' and ficheDiplome.residence.codePostal
      ficheDiplome.residence.codePostal = ficheDiplome.residence.codePostal.toUpperCase()
      if not uqamValidator.isCodePostalCanadien ficheDiplome.residence.codePostal
        erreurs.codePostalResidence = 'Le code postal est invalide'

    if not uqamValidator.isLength ficheDiplome.residence.casePostal, 0, 10
      erreurs.casePostalResidence = 'Le code de la case postale est invalide'

    if not uqamValidator.isLength ficheDiplome.residence.province, 0, 2
      erreurs.provinceResidence = 'Le code de la province est invalide'

    if not uqamValidator.isLength ficheDiplome.residence.pays, 0, 30
      erreurs.paysResidence = 'Le pays est invalide'

    if ficheDiplome.residence.telephone and ficheDiplome.residence.pays is 'CA' and not uqamValidator.isTelephoneNordAmericain ficheDiplome.residence.telephone
      erreurs.telephoneResidence = 'Le numéro de téléphone est invalide'

    if ficheDiplome.residence.courriel and not uqamValidator.isEmail ficheDiplome.residence.courriel
      erreurs.courrielResidence = 'Courriel personnel invalide'

  #Information de travail
  if ficheDiplome.travail

    if not uqamValidator.isLength ficheDiplome.travail.nom, 0, 40
      erreurs.nomTravail = 'Le nom du lieu de travail doit contenir au plus 40 caractères'

    if not uqamValidator.isLength ficheDiplome.travail.no, 0, 6
      erreurs.noTravail = 'Le numéro du lieu de travail doit contenir au plus 6 caractères'

    if not uqamValidator.isLength ficheDiplome.travail.rue, 0, 30
      erreurs.rueTravail = 'Le nom de la rue du lieu de travail doit contenir au plus 30 caractères'

    if not uqamValidator.isLength ficheDiplome.travail.ville, 0, 45
      erreurs.villeTravail = 'La ville du lieu de travail doit contenir au plus 45 caractères'

    if ficheDiplome.travail.pays is 'CA' and ficheDiplome.travail.codePostal
      ficheDiplome.travail.codePostal = ficheDiplome.travail.codePostal.toUpperCase()
      if not uqamValidator.isCodePostalCanadien ficheDiplome.travail.codePostal
        erreurs.codePostalTravail = 'Le code postal du lieu de travail est invalide'

    if not uqamValidator.isLength ficheDiplome.travail.casePostale, 0, 10
      erreurs.casePostaleTravail = 'Le code de la case postale du lieu de travail est invalide'

    if not uqamValidator.isLength ficheDiplome.travail.province, 0, 2
      erreurs.provinceTravail = 'Le code de la province du lieu de travail est invalide'

    if not uqamValidator.isLength ficheDiplome.travail.pays, 0, 30
      erreurs.paysTravail = 'Le pays du lieu de travail est invalide'

    if ficheDiplome.travail.telephone and ficheDiplome.travail.pays is 'CA' and not uqamValidator.isTelephoneNordAmericain ficheDiplome.travail.telephone
      erreurs.telephoneTravail = 'Le numéro de téléphone du lieu de travail est invalide'

    if not uqamValidator.isLength ficheDiplome.travail.poste, 0, 10
      erreurs.posteTravail = 'Le numéro de poste du lieu de travail est invalide'

    if ficheDiplome.travail.courriel and not uqamValidator.isEmail ficheDiplome.travail.courriel
      erreurs.courrieTravail = 'Courriel du lieu de travail est invalide'

    if not uqamValidator.isLength ficheDiplome.travail.compagnie, 0, 40
      erreurs.compagnieTravail = 'Le nom de la compagnie doit contenir au plus 40 caractères'

  if Object.keys(erreurs).length > 0
    callback {regleInvalidees: erreurs}
  else
    raiserEdgeRepo.ajouterCoordonnees ficheDiplome, (err, data)->
      if(!err)
        callback null, data

exports.getFicheDiplomes = (callback) ->
  raiserEdgeRepo.getCoordonnees (err, data)->
    if(!err)
      callback null, data


exports.supprimerFicheDiplome = (id, callback) ->
  raiserEdgeRepo.supprimerCoordonnee id,
    (err, data)->
      if(!err)
        callback null, 'Supprimé'