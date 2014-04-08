timeKeeperApp.controller('membersController', ['$scope', '$http', function ($scope, $http){
    // Form values object
    $scope.formData = {
        user: {}
    };
    // Sending the form values to the rails controller
    $scope.processForm = function(isValid) {
        if (isValid) {
            $http.post('/members.json', $scope.formData)
            .success(function(data) {
                console.log(data);
            });
        }
    };

    // All members
    $http.get('/members.json').success(function(data) {
        $scope.members = data;
    });
}]);