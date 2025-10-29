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
Scenario: Get Pokemon moves sorted A-Z
    Given path 'pokemon/pikachu'
    When method get
    Then status 200

    # Extraer los nombres de los movimientos
    And def moveNames = []
    And eval
    """
    for(var i in response.moves) {
        moveNames.push(response.moves[i].move.name);
    }
    """

    # Crear una copia y ordenar alfabéticamente
    And def sortedMoves = moveNames.slice().sort()

    # Imprimir las listas
    And print 'Lista original:', moveNames
    And print 'Lista ordenada:', sortedMoves

    # Validación simple
    And match sortedMoves == moveNames.slice().sort()