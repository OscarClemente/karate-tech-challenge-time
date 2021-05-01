Feature: Test graphql query
	
Scenario: delete timer that doesn't exist

	Given url 'http://localhost:8080/query'
	Given text query =
	"""
	mutation {
		deleteTimer(id: "10")
	}
	"""
	And request {query: '#(query)' }
	When method POST
	Then status 200
	Then match response.data == null
	Then match response.errors[0].message == "Could not find a timer to delete."
	
Scenario: update timer

	Given url 'http://localhost:8080/query'
	Given text query =
	"""
	mutation {
		updateTimer(input: {id: "4", title: "UpdatedTimer", timeElapsed: 20}) {
			id,
			title,
			timeElapsed,
		}
	}
	"""
	And request {query: '#(query)' }
	When method POST
	Then status 200
	Then match response.data.updateTimer.id == "4"
	Then match response.data.updateTimer.title == "UpdatedTimer"
	Then match response.data.updateTimer.timeElapsed == 20
	
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
	
Scenario: query timers

	Given url 'http://localhost:8080/query'
	Given text query =
	"""
	query {
		timers {
			id,
			title,
		}
	}
	"""
	And request {query: '#(query)' }
	When method POST
	Then status 200
	Then match response == "#object"
	Then match response.data.timers[0].id == "1"
	Then match response.data.timers[0].title == "Today's session"
	Then match response.data.timers[1].id == "2"
	Then match response.data.timers[1].title == "Yesterday's session"
	Then match response.data.timers[2].id == "3"
	Then match response.data.timers[2].title == "May 1st session"
	Then match response.data.timers[3].id == "4"
	Then match response.data.timers[3].title == "UpdatedTimer"
	Then match response.data.timers[4].id == "5"
	Then match response.data.timers[4].title == "NewTimer"
