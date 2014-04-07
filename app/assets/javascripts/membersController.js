timeKeeperApp.controller('membersController', ['$scope', '$http', function ($scope, $http){
    $scope.formData = {
        user: {}
    };
    $scope.processForm = function() {
        $http.post('/members.json', angular.toJson($scope.formData))
        .success(function(data) {
            console.log(data);
        });
    };
}]);