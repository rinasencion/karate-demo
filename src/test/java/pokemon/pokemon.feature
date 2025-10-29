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

  @evolution
  Scenario: Obtener la cadena de Evolución de Bulbasaur
    Given path 'pokemon/bulbasaur'
    When method Get
    Then status 200
    * def pokemonResponses = response

    # 1. Obtener la URL del EndPoint Species
    * def speciesUrl = pokemonResponses.species.url
    * print 'Species URL: ' + speciesUrl

    # 2. Hacer una solicitud GET al EndPoint Species
     Given url speciesUrl
     When method Get
     Then status 200
     * def speciesResponses = response
     * def evolutionCahinUrl = speciesResponses.evolution_chain.url
     * print 'Species URL: ' + evolutionCahinUrl

     # 3. Hacer la solicitud GET al EndPoint Evolution Chain
     Given url evolutionCahinUrl
     When method Get
     Then status 200
     * def evolutionResponses = response

     # 4. Extraer los nombres de las evolcuiones
     * def nameEvoliutionOne =  evolutionResponses.chain.evolves_to[0].species.name
     * print 'Pokemon 1|: ' + nameEvoliutionOne

     * def nameEvoliutionTwo =  evolutionResponses.chain.evolves_to[0].evolves_to[0].species.name
     * print 'Pokemon 2|: ' + nameEvoliutionTwo

     * match nameEvoliutionOne == 'ivysaur'
     * match nameEvoliutionTwo == 'venusaur'
