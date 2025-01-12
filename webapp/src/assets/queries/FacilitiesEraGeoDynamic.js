export default function FacilitiesEraGeoDynamic(fields) {
  const selectClause = fields.map((field) => `?${field}`).join(' ');
  const whereClause = fields.map((field) => `  ?op ex:${field} ?${field} .`).join('\n');
  const filters = fields.map((field) => `  FILTER (?${field} != "0")`).join('\n');
  return `PREFIX xyz: <http://sparql.xyz/facade-x/data/>
PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX era:  <http://data.europa.eu/949/>
PREFIX geo:  <http://www.w3.org/2003/01/geo/wgs84_pos#>
PREFIX gsp:  <http://www.opengis.net/ont/geosparql#>
PREFIX ex:   <http://example.org/>

SELECT
  ?canonicalUri ?opName ?tafTapCode ${selectClause} ?geometryWKT
WHERE {
  ?op era:opName ?opName ;
      era:canonicalURI ?canonicalUri ;
      era:tafTAPCode ?tafTapCode .
${whereClause}
  SERVICE <https://prod.virtuoso.ecdp.tech.ec.europa.eu/sparql> {
    ?op gsp:hasGeometry ?geometry .
    ?geometry gsp:asWKT ?geometryWKT .
  }
${filters}
}
ORDER BY ?opName
`;
}
