myApp.factory "FirebaseRoot", ->
  new Firebase "https://openmotor.firebaseio.com"

myApp.factory "Auth", ["FirebaseRoot", (FirebaseRoot) ->
  User =
    accessToken: null
    name: null
    id: null
    thirdPartyUserData: null

  user: ->
    User

  auth: (cb) ->
    new FirebaseSimpleLogin FirebaseRoot, (error, user) ->
      return cb 'error' if error

      if user
        User.accessToken = user.accessToken
        User.id = user.id
        User.name = user.name
        User.thirdPartyUserData = user.thirdPartyUserData
        cb user
      else
        # user is logged out
        cb 'logout'
]