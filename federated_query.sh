curl -X POST \
     -H "Content-Type: application/sparql-query" \
     -H "Accept: text/turtle" \
     --data-binary @federated_query.sparql \
     https://linked-data.goelff.be/sparql.anything > facilities_era.ttl
