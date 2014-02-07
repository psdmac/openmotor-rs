myApp.controller 'HeaderCtrl',['$scope','$state','Data','Auth','APIs', ($scope,$state,Data,Auth,APIs)->
  auth = Auth.auth (user) ->
    if user is 'logout'
      $state.go 'login'
    else
      $scope.showAvatar()
  $scope.loginSuccess = ->
    $scope.showAvatar()
  $scope.showAvatar = ->
    $('#avatar').css 'background', 'url(http://graph.facebook.com/'+Auth.user().id+'/picture?type=normal)'
    $('#avatar').css 'background-size', 'cover'
    user = APIs.id(Auth.user().id)
    user_page = user.child('pages')
    user_page.on 'value', (res) ->
      Data.pages.length = 0
      # res.val() is null represent first time login
      if res.val() is null
        $state.go 'config.welcome'
      else
        # push pages data to Data.pages
        angular.forEach res.val(), (value) ->
          Data.pages.push value.id
    user.once 'value', (res) ->
      # get user data, if res.val() is null, add user to Users
      if res.val() is null
        user.child('name').set(Auth.user().name)
        user.child('accessToken').set(Auth.user().accessToken)
        user.child('data').set(Auth.user().thirdPartyUserData)
      else
        user.child('accessToken').set(Auth.user().accessToken)
]