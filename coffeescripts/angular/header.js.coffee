myApp.controller 'HeaderCtrl',['$scope','$state','Auth','Users', ($scope,$state,Auth,Users)->
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
    user = Users.id(Auth.user().id)
    user.once 'value', (res) ->
      # get user data, if res.val() is null, add user to Users
      if res.val() is null
        user.child('name').set(Auth.user().name)
        user.child('accessToken').set(Auth.user().accessToken)
        user.child('data').set(Auth.user().thirdPartyUserData)
      else if (new Date() - new Date(res.val().data.updated_time)) > 86400000
        user.child('name').set(Auth.user().name)
        user.child('accessToken').set(Auth.user().accessToken)
        user.child('data').set(Auth.user().thirdPartyUserData)
    # Users = user.parent()
    # Users.once 'value', (res) ->
    #   console.log res.val()
]