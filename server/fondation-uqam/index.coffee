#Require de npm
uqamValidator = require 'uqam-validator'

#Require de la lib
gestionFinissant = require './lib/gestion-finissant'

module.exports.modifierFicheDiplome = (body, callback) ->
  if !body.ficheDiplome
    callback {argumentManquant: 'La propriété ficheDiplome est requise.'}, null

  if !body.ficheDiplome.residence
    callback {argumentManquant: 'La propriété ficheDiplome.residence est requise.'}, null

  if !body.ficheDiplome.travail
    callback {argumentManquant: 'La propriété ficheDiplome.travail est requise.'}, null

  gestionFinissant.modifierFicheDiplome body.ficheDiplome,
    (err, data) ->
      if(err)
        callback err, err
      else
        callback null, data


module.exports.getFicheDiplomes = (callback) ->
  gestionFinissant.getFicheDiplomes (err, data) ->
    if(err)
      callback err, err
    else
      callback null, data

module.exports.supprimerFicheDiplome = (id, callback) ->
  gestionFinissant.supprimerFicheDiplome id, (err, data) ->
    if(err)
      callback err, err
    else
      callback null, data