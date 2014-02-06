myApp.controller 'MainCtrl',['$scope','$state','$timeout','Auth','Get','Data', ($scope,$state,$timeout,Auth,Get,Data)->
  current = Math.floor new Date()/1000
  since = current - 86400
  $scope.feeds = Data.feeds
  Data.feeds.length = 0
  $scope.setInterval = ->
    $timeout ->
      if Auth.user().accessToken is null or Data.pages.length is 0
        $scope.setInterval()
      else
        angular.forEach Data.pages, (value) ->
          Get.feed(value, since, current).then (res) ->
            # console.log res
            angular.forEach res, (value) ->
              Data.feeds.push value
              if value.type is 'status'
                console.log value
              # console.log $scope.feeds
    , 100
  $scope.setInterval()
  busy = false
  $scope.ajax = false
  $scope.nextPage = ->
    console.log 'nextPage...'
    if !busy
      busy = !busy
      $scope.ajax = !$scope.ajax
      current = since
      since = current - 86400
      i = 0
      angular.forEach Data.pages, (value) ->
        Get.feed(value, since, current).then (res) ->
          i++
          j = 0
          angular.forEach res, (value) ->
            Data.feeds.push value
            if value.type is 'status'
              console.log value
            j++
            if i is Data.pages.length and j is res.length
              busy = !busy
              $scope.ajax = !$scope.ajax
              console.log Data.feeds
]

myApp.controller 'LoginCtrl',['$scope','$state','$timeout','Auth', ($scope,$state,$timeout,Auth) ->
  auth = Auth.auth (user) ->
    if user is 'logout'

    else if user is 'error'

    else
      $('#header').scope().loginSuccess()
      $state.go 'root'
  $scope.login = ->
    auth.login "facebook",
      rememberMe: true
      scope: "email,publish_actions,read_friendlists"
]