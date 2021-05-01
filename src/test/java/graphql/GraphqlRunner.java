package graphql;

import com.intuit.karate.junit5.Karate;

class GraphqlRunner {
    
    @Karate.Test
    Karate testGraphql() {
        return Karate.run("graphql").relativeTo(getClass());
    }    

}
