var app = angular.module('ipserviceApp');
app.controller('userController', function($scope, $firebaseArray)
{
    var ref = new Firebase("https://projectipcservice.firebaseio.com/");
    var authData = ref.getAuth();

    $scope.reset = function()
    {
      $scope.serviceType = "";
      $scope.costPerMinutes= 0;
      $scope.software_numberOfMinutes = 0;
      $scope.hardware_numberOfMinutes = 0;
      $scope.software_instructions = "";
      $scope.hardware_instructions = "";
      $scope.$apply();
    }
    $scope.changeSoftware = function()
    {
        $scope.software_numberOfMinutes = this.software_numberOfMinutes;
        $scope.software_instructions = this.software_instructions;
    };

    $scope.changeHardware = function()
    {
        $scope.hardware_numberOfMinutes = this.hardware_numberOfMinutes;
        $scope.hardware_instructions = this.hardware_instructions;
    };
        //get the data for our pending service requests
    var service_requests = ref.child("service_requests");
    $scope.service_request_data = $firebaseArray(service_requests.orderByChild("user").equalTo(authData.uid));

    $scope.newServiceRequest = function(type, numberOfMinutes, instructions, cost)
    {
      console.log("type: " + type);
      console.log("cost: " + cost);
      console.log("numberOfMinutes: " + numberOfMinutes);
        //save the new service request to firebase
        service_requests.push({user: authData.uid, name: type, type: type, instructions: instructions, cost: cost, numberOfMinutes: numberOfMinutes, provider: "n/a", completed: false});
    }
    $scope.softwareButtonOnClick = function()
    {
        this.serviceType = "software";
        this.costPerMinutes = 10;
        this.software_numberOfMinutes = 0;
        this.software_instructions = "";
    }
    $scope.hardwareButtonOnClick = function()
    {
        this.serviceType = "hardware";
        this.costPerMinutes = 8;
        this.hardware_numberOfMinutes = 0;
        this.hardware_instructions = "";
    }


});
