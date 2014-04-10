var timeKeeperApp = angular.module('timeKeeperApp', ['ngRoute']);

timeKeeperApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/members', {
        templateUrl: '/assets/partials/members.html',
        controller: 'membersController'
      }).
      when('/create_member', {
        templateUrl: '/assets/partials/create-member.html',
        controller: 'membersController'
      }).
      when('/delete_member', {
        templateUrl: '/assets/partials/members.html',
        controller: 'membersController'
      }).
      otherwise({
        redirecTo: '/members'
      });
  }]);