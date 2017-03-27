'use strict'

angular.module 'loadfeedsApp'
.controller 'MainCtrl', ($scope) ->

  
  $scope.helpers
    things: () ->
      Things.find {}
      
  $scope.subscribe 'things', () ->
    [
      {}
      $scope.getReactively 'search'
    ]
    
  $scope.save = () ->
    if $scope.form.$valid
      Things.insert $scope.newThing
      $scope.newThing = undefined
      
  $scope.remove = (thing) ->
    Things.remove 
      _id: thing._id
