var applicationApp = angular.module('applicationApp', []);
applicationApp.controller('applicationCtrl', function ($scope, $http) {

    $scope.application = {};
    $scope.applications = [];
    $scope.selectVals = [{ name: 'New', id: 0 }, { name: 'Accept', id: 1 }, { name: 'Reject', id: 2 }];

    var formatDate = function (list) {
        $.each(list, function (index, value) {
            value.CreatedOn = new Date(parseInt(value.CreatedOn.substr(6)));
            value.ModifiedOn = new Date(parseInt(value.ModifiedOn.substr(6)));
        });
    }

    var setCurrentStatusObj = function (result) {
        $.each($scope.selectVals, function (index, value) {
            if (value.id === result.Status) {
                result.Status = value;
            }
        });
    }

    var setNewStatus = function (application) {
        application.Status = application.Status.id;
    }

    $scope.getApplications = function () {
        $http.post("/Application/GetApplications", {})
        .success(function (result) {
            formatDate(result);
            $scope.applications = result;
        })
        .error(function (result) {
            console.log(result);
        });
    }

    $scope.createApplication = function (application) {
        $http.post("/Application/CreateApplication", { application: application })
        .success(function (result) {
            $scope.application = {};
            alert("Your application was registred!")
        })
        .error(function (result) {
            console.log(result);
        });
    }

    $scope.selectApplication = function (id) {
        $http.post("/Application/GetApplicationByID", { id: id })
        .success(function (result) {
            setCurrentStatusObj(result);
            $scope.application = result;
        })
        .error(function (result) {
            console.log(result);
        });
    }

    $scope.updateApplication = function (application) {
        application.CreatedOn = new Date(parseInt(application.CreatedOn.substr(6)));
        application.ModifiedOn = new Date(parseInt(application.ModifiedOn.substr(6)));
        setNewStatus(application);
        $http.post("/Application/UpdateApplication", { application: application })
        .success(function (result) {
            formatDate(result);
            $scope.application = {};
            $scope.applications = result;
        })
        .error(function (result) {
                console.log(result);
        });
    }

    $scope.deleteApplication = function (id) {
        $http.post("/Application/DeleteApplication", { id: id })
        .success(function (result) {
            formatDate(result);
            $scope.application = {};
            $scope.applications = result;
        })
        .error(function (result) {
            console.log(result);
        });
    }

});