var app = angular.module('home', ["firebase"]);
 var ref = new Firebase("https://projectipcservice.firebaseio.com/");
  var authData = ref.getAuth();
app.controller('loginRedirect', function($scope, $firebaseArray) 
{
   
   if(!authData)
    {
        window.location.href = "index.html";
    }
});