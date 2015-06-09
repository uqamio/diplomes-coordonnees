baseApp = angular.module 'baseApp'

AccueilController = ($scope, $http) ->
  $scope.ficheDiplome =
    sexe: 'M'
    nom: 'com',
    prenom: 'Gabriel',
    codePermanent: 'COMG03107901',
    dateNaissance: '03-10-1979',
    residence: {}
    travail: {}

  $scope.soumettre = () ->
    post = $http.post '/api/diplomes/coordonnees', {ficheDiplome: $scope.ficheDiplome}
    post.success (result, status, headers, config) ->
      delete $scope.regleInvalidees
      if result.status is 'fail'
        $scope.regleInvalidees = result.data.regleInvalidees
        console.warn result
      else if result.status is 'success'
        alert 'Ajouté'

    post.error (result, status, headers, config) ->
      console.error result

  $scope.getFicheDiplomes = () ->
    get = $http.get '/api/diplomes/coordonnees'
    get.success (result, status, headers, config) ->
      if result.status is 'fail'
        $scope.regleInvalidees = result.data.regleInvalidees
        console.warn 'fail', result
      else if result.status is 'success'
        $scope.ficheDiplomes = result.data
        $scope.showCoords = true


    get.error (result, status, headers, config) ->
      console.error result

  $scope.supprimer =  (id)->
    console.log 'Delete : ', id
    del = $http.delete '/api/diplomes/coordonnees/' + id
    del.success (result, status, headers, config) ->
      if result.status is 'fail'
        $scope.regleInvalidees = result.data.regleInvalidees
      else if result.status is 'success'
        $scope.getFicheDiplomes()
        console.log result.data

    del.error (result, status, headers, config) ->
      console.error result

AccueilController.$inject = ['$scope', '$http']

baseApp.controller('AccueilController', AccueilController)