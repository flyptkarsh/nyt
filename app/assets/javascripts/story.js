angular.module('storyApp', []).controller('ngStoryController', function($scope, $http) {

  $scope.get_articles = function (language, more) {
    console.log(language, more);
    $http({
      method: 'GET',
      url: '/story',
      params: { lang: language, more: more}
    }).then(function successCallback(response) {
        $scope.spanABTop = response.data[0];
        $scope.aColumn = response.data[1];
        $scope.bColumn = response.data[2];
        $scope.cColumn =  response.data[3];
        $scope.lang = language;
      }, function errorCallback(response) {
        $scope.story = response;

      });
  }

  $scope.get_more_articles = function (language, more) {
    $scope.get_articles(language, more)
  }

  $scope.get_articles("English", false);


});
