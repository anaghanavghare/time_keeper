var timeKeeperApp = angular.module('timeKeeperApp', ['ngRoute']);

timeKeeperApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/users', {
        templateUrl: '/assets/partials/add-users.html',
        controller: 'usersController'
      });
  }]);