xquery version "1.0-ml";

let $q := xdmp:get-request-field('q', 'person')

let $search-results := cts:search(/, cts:word-query($q), 'unfiltered')

return
<results q="{$q}">
   {for $result in $search-results
   return <uri>{xdmp:node-uri($result)}</uri>
   }
</results>