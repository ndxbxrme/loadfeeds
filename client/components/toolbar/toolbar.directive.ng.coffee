'use strict'

angular.module 'loadfeedsApp'
.directive 'toolbar', ->
  restrict: 'AE'
  templateUrl: 'client/components/toolbar/toolbar.view.html'
  replace: true