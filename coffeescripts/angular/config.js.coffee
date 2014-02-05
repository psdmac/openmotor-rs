myApp.controller 'ConfigCtrl',['$scope','$state','$timeout','Auth','Users', ($scope,$state,$timeout,Auth,Users) ->
  Pages = Users.pages()
  Pages.on 'value', (res) ->
    $scope.pages = res.val()
    $scope.$apply()
    # console.log $scope.pages
]