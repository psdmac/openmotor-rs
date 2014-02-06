myApp.factory "Data", [ ->
  date: ->
    date = new Date()
    date
  pages: []
  total_pages: []
  feeds: []
  api: (route) ->
    'https://openmotor.firebaseio.com'+ route
]

myApp.factory "Get", ['Auth','Data','$http', (Auth, Data, $http) ->
  feed: (page, since, current) ->
    $http(
      url: 'https://graph.facebook.com/'+page+
              '/feed?since='+since+'&until='+current+
              '&date_format=U&access_token='+Auth.user().accessToken+'',
      method: "get"
      cache: true
    ).then (res) ->
      # console.log res
      if res.status is 200 
        res.data.data
  obj: (id) ->
    $http(
      url: 'https://graph.facebook.com/'+id+'?access_token='+Auth.user().accessToken+'',
      method: "get"
      cache: true
    ).then (res) ->
      # console.log res
      if res.status is 200 
        res.data
  likes: (id) ->
    $http(
      url: 'https://graph.facebook.com/'+id+'/likes?summary=1&access_token='+Auth.user().accessToken+'',
      method: "get"
      cache: true
    ).then (res) ->
      # console.log res
      if res.status is 200 
        res.data
  comments: (id) ->
    $http(
      url: 'https://graph.facebook.com/'+id+'/comments?summary=1&access_token='+Auth.user().accessToken+'',
      method: "get"
      cache: true
    ).then (res) ->
      # console.log res
      if res.status is 200 
        res.data
  picture: (id) ->
    $http(
      url: 'https://graph.facebook.com/'+id+'/picture?redirect=0&height=200&type=normal&width=200&access_token='+Auth.user().accessToken+'',
      method: "get"
      cache: true
    ).then (res) ->
      # console.log res
      if res.status is 200 
        res.data
]

myApp.factory "APIs", ["FirebaseRoot", (FirebaseRoot) ->
  id: (userid) ->
    root = FirebaseRoot
    user = root.child 'Users/'+userid
  pages: ->
    root = FirebaseRoot
    pages = root.child 'Pages'
]