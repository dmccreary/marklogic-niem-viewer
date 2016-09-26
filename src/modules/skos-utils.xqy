xquery version "1.0-ml";

module namespace skos-util = "http://marklogic.com/skos-utilities";
(:
import module namespace skos-util = "http://marklogic.com/skos-utilities" at "/modules/skos-utils.xqy"; 
:)
declare namespace skos="http://www.w3.org/2004/02/skos/core#";

declare function skos-util:concept-to-html($concept as element()) {
let $uri := xdmp:node-uri($concept)
return
<div class="skos-concept">
    <span class="field-label">Name:</span> <b>{$concept/skos:prefLabel/text()}</b><br/>  
    <span class="field-label">Definition:</span> {$concept/skos:definition/text()}<br/>
    <span class="field-label">Broader:</span> {$concept/skos:broader/text()}<br/>
    {for $alt-label in $concept/skos:altLabel
       return
          <div>
             <span class="field-label">Alt Label:</span> {$alt-label/text()}<br/>
          </div>
    }
    <span class="field-label">Member:</span> {$concept/skos:member/text()}<br/>
     <div class="green-url"><a href="/views/view-xml.xqy?uri={$uri}">{$uri}</a></div>
       <div class="button-actions">
         <span class="field-label">Actions:</span>
         <a class="btn btn-info" role="button" href="/views/view-skos-concept.xqy?uri={$uri}">View Details</a>
         <a class="btn btn-info" role="button" href="/views/view-xml.xqy?uri={$uri}">View XML</a>
         <a class="btn btn-info" role="button" href="/scripts/add-to-wantlist-list.xqy?uri={$uri}">Add to Wantlist</a>
      </div>
</div>
};