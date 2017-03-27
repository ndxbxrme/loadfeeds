angular.module 'loadfeedsApp', [
  'angular-meteor'
  'ui.router'
]

onReady = () ->
  angular.bootstrap document, ['loadfeedsApp']
  
if Meteor.isCordova
  angular.element(document).on 'deviceready', onReady
else
  angular.element(document).ready onReady