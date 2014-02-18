myApp = angular.module 'myApp', ['ui.router','ngSanitize','infinite-scroll','angulartics','angulartics.google.analytics']

myApp.config ['$stateProvider', '$urlRouterProvider', '$analyticsProvider', ($stateProvider, $urlRouterProvider, $analyticsProvider) ->
  $urlRouterProvider.otherwise "/"
  $analyticsProvider.virtualPageviews(false)
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
    .state 'config.welcome',
      url: '/welcome'
      templateUrl: 'views/config.welcome.html'
]