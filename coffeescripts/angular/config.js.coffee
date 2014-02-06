myApp.controller 'ConfigCtrl',['$scope','$state','$timeout','Data','Auth','APIs', ($scope,$state,$timeout,Data,Auth,APIs) ->
  Pages = APIs.pages()
  $scope.pages = Data.total_pages
  Pages.on 'value', (res) ->
    Data.total_pages.length = 0
    angular.forEach res.val(), (value) ->
      Data.total_pages.push value
    $scope.$apply()
  $scope.togglePage = (id) ->
    user = APIs.id(Auth.user().id)
    user_pages = user.child('pages')
    user_page = user_pages.child(id)
    user_page.once 'value', (res) ->
      if res.val() is null
        user_page.set id: id
      else 
        user_page.remove()
]