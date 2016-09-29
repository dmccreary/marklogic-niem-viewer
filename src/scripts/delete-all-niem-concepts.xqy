xquery version "1.0-ml";
import module namespace style = "http://danmccreary.com/style" at "/modules/style.xqy";
declare option xdmp:output "method=html";

declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare namespace skos="http://www.w3.org/2004/02/skos/core#";


let $title := 'Split NIEM into Documents For Better Search Relevency'

let $uris := cts:uri-match('/niem-concepts/*.xml')

let $do-deletes :=
   for $uri in $uris
   let $delete := xdmp:document-delete($uri)
   return $uri

let $content := 
    <div class="content">
       <h4>{$title}</h4>
       Results:<br/>
       Number of URIs deleted: {count($uris)}
    </div>                                           

return style:assemble-page($title, $content)