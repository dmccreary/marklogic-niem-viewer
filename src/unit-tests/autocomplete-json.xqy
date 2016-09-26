xquery version "1.0-ml";

(: this service returns a JSON document with all the labels in it :)
declare namespace skos="http://www.w3.org/2004/02/skos/core#";

declare option xdmp:output "method=html";
let $content-type := xdmp:set-response-content-type('application/json')
let $q := xdmp:get-request-field('q', 'birth')

(: do a simple word query :)
let $search-results := cts:search(/, cts:word-query($q), 'unfiltered')

let $sorted-preferred-lables :=
  for $label in $search-results/skos:Concept/skos:prefLabel
  order by $label
  return $label

let $labels-in-quotes :=
   for $label in $sorted-preferred-lables/text()
     return concat('"', $label, '"')
     
let $internal-string := string-join($labels-in-quotes, ', ')

return concat('source: [', $internal-string, ']')
