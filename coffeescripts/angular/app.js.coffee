myApp = angular.module 'myApp', ['ui.router','ngSanitize','infinite-scroll']

myApp.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise "/"
  $stateProvider
    .state 'root',
      url: "/"
      templateUrl: "views/home.html"
      controller: 'MainCtrl'
    .state 'login',
      url: '/login'
      templateUrl: 'views/login.html'
      controller: 'LoginCtrl'
    .state 'config',
      url: '/config'
      templateUrl: 'views/config.html'
      controller: 'ConfigCtrl'
]