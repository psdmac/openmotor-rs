(function() {
  var myApp;

  myApp = angular.module('myApp', ['ngRoute', 'ngSanitize']);

  myApp.config([
    '$locationProvider', '$routeProvider', function($locationProvider, $routeProvider) {
      $locationProvider.html5Mode(false).hashPrefix('!');
      return $routeProvider.when('/', {
        templateUrl: 'views/home.html',
        controller: 'MainCtrl'
      }).otherwise({
        redirectTo: '/'
      });
    }
  ]);

}).call(this);
