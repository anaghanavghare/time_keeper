var timeKeeperApp = angular.module('timeKeeperApp', ['ngRoute']);

timeKeeperApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/members', {
        templateUrl: '/assets/partials/add-members.html',
        controller: 'membersController'
      });
  }]);