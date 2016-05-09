angular.module('storyApp', []).controller('ngStoryController', function($scope, $http) {

  $http({
    method: 'GET',
    url: '/story'
  }).then(function successCallback(response) {
      $scope.spanABTop = response.data.page.content[1].collections[0].assets
      $scope.aColumn = response.data.page.content[1].collections[1].assets
      $scope.bColumn = response.data.page.content[1].collections[2].assets
      $scope.cColumn = response.data.page.content[1].collections[3].assets
      $scope.liveMobileResults = response.data.page.content.length
    }, function errorCallback(response) {
      console.log(response);
      $scope.story = response;

    });
});
