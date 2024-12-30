curl -X POST \
     -H "Content-Type: application/sparql-query" \
     -H "Accept: text/turtle" \
     --data-binary @query.sparql \
     https://linked-data.goelff.be/sparql.anything > facilities.ttl
