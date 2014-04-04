// timeKeeperApp.factory('usersFactory', function($http){
//     var usersData = [] ;
//     $http({method: 'GET', url: '/users.json'}).
//     success(function(data, status) {
//         usersData = angular.toJson(data, true);
//         console.log(data, status);
//     }).
//     error(function(data, status) {
//         data = data || "Request failed";
//         status = status;
//         console.log(data, status);
//     });
//     return usersData;
// });

timeKeeperApp.controller('usersController', ['$scope', '$http', function ($scope, $http){
    $http.get('/users.json').
    success(function(data, status) {
        $scope.usersData = data;
        console.log(data, status);
    }).
    error(function(data, status) {
        data = data || "Request failed";
        status = status;
        console.log(data, status);
    });
}]);