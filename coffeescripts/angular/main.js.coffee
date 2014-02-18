myApp.controller 'MainCtrl',['$scope','$state','$timeout','Auth','Get','Data','$analytics', ($scope,$state,$timeout,Auth,Get,Data,$analytics)->
  $analytics.pageTrack(window.location.hash)
  current = Math.floor new Date()/1000
  since = current - 86400
  $scope.feeds = Data.feeds
  Data.feeds.length = 0
  busy = false
  $scope.ajax = false
  init = false
  $scope.setInterval = ->
    $timeout ->
      if Auth.user().accessToken is null or Data.pages.length is 0
        $scope.setInterval()
      else
        angular.forEach Data.pages, (value) ->
          Get.feed(value, since, current).then (res) ->
            # console.log res
            init = true
            angular.forEach res, (value) ->
              Data.feeds.push value
              # if value.type is 'status'
              #   console.log value
              # console.log $scope.feeds
    , 100
  $scope.setInterval()
  $scope.nextPage = ->
    if !busy and init
      # console.log 'nextPage...'
      busy = !busy
      $scope.ajax = !$scope.ajax
      current = since
      since = current - 86400
      i = 0
      angular.forEach Data.pages, (value) ->
        Get.feed(value, since, current).then (res) ->
          i++
          # prevent last res.length is 0
          if i is Data.pages.length and res.length is 0
            busy = !busy
            $scope.ajax = !$scope.ajax
          j = 0
          angular.forEach res, (value) ->
            Data.feeds.push value
            j++
            # all the res push in Data.pages
            if i is Data.pages.length and j is res.length
              busy = !busy
              $scope.ajax = !$scope.ajax
              # console.log Data.feeds
]

myApp.controller 'LoginCtrl',['$scope','$state','$timeout','Auth','$analytics', ($scope,$state,$timeout,Auth,$analytics) ->
  $analytics.pageTrack(window.location.hash)
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