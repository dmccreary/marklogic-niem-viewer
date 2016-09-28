xquery version "1.0-ml";
import module namespace refmod="http://westacademic.com/modules/reference" at "/modules/reference.xqy";
import module namespace style="http://westacademic.com/styles" at "/modules/style.xqy";

declare namespace r="http://westacademic.com/reference";
declare option xdmp:output "method=html";

let $title := 'Autocomplete Demo for Series Name'

let $content-type := xdmp:set-response-content-type('application/json')
let $q := lower-case(xdmp:get-request-field('q'))
let $debug := xs:boolean(xdmp:get-request-field('debug', 'false'))

let $series-names := refmod:items('series-code')/r:item/r:label/text()

let $filtered-names :=
  for $name in $series-names
  return
     if (fn:contains(lower-case($name), $q))
        then $name
        else ()
        
let $items-in-quotes :=
   for $label in $filtered-names
     return concat('"', $label, '"')

(: only an array of strings with double :)
let $internal-string := string-join($items-in-quotes, ', ')

let $javascript-array :=
   concat('[', $internal-string, ']')
   
return
   if ($debug)
      then
         ('Q', $q, 'NAMES', $series-names, 'FILTERED', $filtered-names)
      else $javascript-array