Feature: Pokemon API Test

    Background:
        * url 'https://pokeapi.co/api/v2'

    Scenario: Get 200 service Pokemon
        Given path 'pokemon/pikachu'
        When method Get
        Then status 200
        Then match response.name == 'pikachu'

    Scenario: Get 404 notFound Pokemon
        Given path 'pokemon/prueba404'
        When method Get
        Then status 404

    @bubble-sort
  Scenario: Get Pokemon moves and sort them using bubble sort
    Given path 'pokemon/pikachu'
    When method get
    Then status 200
    And match response.name == 'pikachu'
    * def moves = response.moves
    * def moveNames = []
    * karate.forEach(moves, function(move){ moveNames.push(move.move.name) })
    * def bubbleSort = 
    """
    function(arr) {
        var len = arr.length;
        for (var i = 0; i < len; i++) {
            for (var j = 0; j < len - i - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    // Intercambiar elementos
                    var temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
        return arr;
    }
    """
    * def sortedMoves = bubbleSort(moveNames)
    * print '=== Sorted Pokemon Moves (Bubble Sort) ==='
    * karate.forEach(sortedMoves, function(name){ karate.log(name) })