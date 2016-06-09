app = angular.module("myApp", ['ngResource'])

app.factory "Service", ($resource) ->
	$resource("/services.json")

app.controller "ServiceCtrl", ($scope, Service) ->
	$scope.services = Service.query()
	$scope.formatNumber = (i) ->
		Math.floor(i)