# karate-tech-challenge-time
Integration tests for PentoHQ/tech-challenge-time
Built using karate BDD tests.

## Execute
Maven must be installed for these tests to be able to run. Also the backend-tech-challenge-time and the database must be running without modifications to the databse, check the integration_tests/ folder in tech-challenge-time.
Refer to [tech-challenge-time](https://github.com/OscarClemente/tech-challenge-time/tree/main) to execute the full app.

To run the tests execute the following command in the root of the repository
```sh
mvn test
```

## Test example
Test that creates a new timer using the GraphQL api that is provided by the dockerized application and checks that the returned values are correct.
```cucumber
Scenario: create timer

	Given url 'http://localhost:8080/query'
	Given text query =
	"""
	mutation {
		createTimer(title: "NewTimer") {
			id,
			title,
			timeElapsed,
		}
	}
	"""
	And request {query: '#(query)' }
	When method POST
	Then status 200
	Then match response.data.createTimer.id == "5"
	Then match response.data.createTimer.title == "NewTimer"
	Then match response.data.createTimer.timeElapsed == 0
```
