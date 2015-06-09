baseApp = angular.module "baseApp"

baseApp.config(['$routeProvider', '$httpProvider',
  ($routeProvider, $httpProvider) ->
    $routeProvider.
    otherwise({
        templateUrl: 'app/404/index.html'
      });
]);