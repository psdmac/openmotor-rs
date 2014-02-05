myApp.directive 'getAvatar', ->
  (scope, el, attrs) ->
    el.css "background", 'url(http://graph.facebook.com/'+attrs.name+'/picture?type=normal)' 
    el.css "background-size", 'cover' 
myApp.directive 'getPhoto', ['Get', (Get) ->
  (scope, el, attrs) ->
    Get.obj(attrs.photo).then (res) ->
      if res.images[3] is undefined
        source = res.source
      else
        source = res.images[3].source
      el.css "background", 'url('+source+')' 
      el.css "background-size", 'cover'
]
myApp.directive 'getVideo', ['Get', (Get) ->
  (scope, el, attrs) ->
    el.css "background", 'url('+attrs.poster+')' 
    el.css "background-size", 'cover'
]
myApp.directive 'getLink', ['Get', (Get) ->
  (scope, el, attrs) ->
    el.css "background", 'url('+attrs.photo+')' 
    el.css "background-size", 'cover'
]
myApp.directive 'getLikes', ['Get', (Get) ->
  (scope, el, attrs) ->
    Get.likes(attrs.obj).then (res) ->
      if res.summary is undefined
        el.html 0
      else
        el.html res.summary.total_count
]
myApp.directive 'getComments', ['Get', (Get) ->
  (scope, el, attrs) ->
    Get.comments(attrs.obj).then (res) ->
      if res.summary is undefined
        el.html 0
      else
        el.html res.summary.total_count
]
myApp.directive 'getPage', ['Get','Data','Users', (Get,Data,Users) ->
  (scope, el, attrs) ->
    date = Math.floor Data.date()/1000
    element = el.context.nextElementSibling.children[0]
    Get.picture(attrs.id).then (res) ->
      el.css "background", 'url('+res.data.url+')' 
      el.css "background-size", 'cover'
    Pages = Users.pages()
    page = Pages.child(attrs.id)
    page.once 'value', (res) ->
      if (date - res.val().update_at) > 604800
        Get.obj(attrs.id).then (res) ->
          page.child('data').set(res)
          page.child('update_at').set(date)
          element.innerText = res.name
      else
        element.innerText = res.val().data.name
]