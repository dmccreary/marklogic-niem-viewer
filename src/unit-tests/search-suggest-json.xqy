xquery version "1.0-ml";
import module namespace search = "http://marklogic.com/appservices/search" at "/MarkLogic/appservices/search/search.xqy";


declare option xdmp:output "method=html";
let $content-type := xdmp:set-response-content-type('application/json')
let $q := xdmp:get-request-field('q', 'pers')
(:

<range-element-indexes>
        <range-element-index>
          <scalar-type>string</scalar-type>
          <collation>http://marklogic.com/collation/codepoint</collation>
          <namespace-uri>http://www.w3.org/2004/02/skos/core#</namespace-uri>
          <localname>prefLabel</localname>
          <range-value-positions>false</range-value-positions>
          <invalid-values>reject</invalid-values>
        </range-element-index>
        <range-element-index>
          <scalar-type>string</scalar-type>
          <collation>http://marklogic.com/collation/codepoint</collation>
          <namespace-uri>http://www.w3.org/2004/02/skos/core#</namespace-uri>
          <localname>altLabel</localname>
          <range-value-positions>false</range-value-positions>
          <invalid-values>reject</invalid-values>
        </range-element-index>
      </range-element-indexes>
      
      :)
let $options := 
<search:options xmlns="http://marklogic.com/appservices/search">
 <default-suggestion-source>
   <range collation="http://marklogic.com/collation/codepoint" type="xs:string" facet="true">
      <element ns="http://www.w3.org/2004/02/skos/core#" name="prefLabel"/>
   </range>
 </default-suggestion-source>
</search:options>

let $strings := search:suggest($q, $options)

let $items-in-quotes :=
   for $label in $strings
     return concat('"', $label, '"')

(: only an array of strings with double :)
let $internal-string := string-join($items-in-quotes, ', ')
let $javascript-array :=
   concat('[', $internal-string, ']')
  return $javascript-array