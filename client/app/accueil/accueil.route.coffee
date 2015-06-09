configuration =
  ($routeProvider) ->
    $routeProvider
    .when('/modifier/coordonnees', {
        templateUrl: 'app/accueil/index.html',
        controller: 'AccueilController'
      })

configuration.$inject = ['$routeProvider']

(angular.module 'baseApp').config(configuration)