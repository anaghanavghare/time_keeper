timeKeeperApp.controller('membersController', ['$scope', '$http', '$window', '$location', function ($scope, $http, $window, $location){
    // Form values object
    $scope.formData = {
        user: {}
    };

    // All members
    $http.get('/members.json').success(function(data) {
        $scope.members = data;
    });

    // Sending the form values to the rails controller
    $scope.processForm = function(isValid) {
        if (isValid) {
            $http.post('/members.json', $scope.formData)
            .success(function(addedMember) {
                console.log(addedMember);
                $scope.members.push(addedMember);
            });
        }
    };

    $scope.deleteMember = function(member) {
        var memberId = member.id;
        var memberName = member.first_name;
        $window.confirm('Do you want to delete ' + memberName);
        if ( $window.confirm('Do you want to delete ' + memberName) ) {
            $http.delete('/members/'+ memberId + '.json')
                .success(function(data, status) {
                    console.log(status);
                    $scope.members = data;
                });
        } else {
            return;
        }
    };
}]);