xquery version "1.0-ml";
import module namespace style = "http://danmccreary.com/style" at "/modules/style.xqy";
declare namespace skos="http://www.w3.org/2004/02/skos/core#";
declare option xdmp:output "method=html";

let $title := 'Autocomplete Demo for SKOS Preferred Lables'

let $content-type := xdmp:set-response-content-type('text/html')

(: or we can use cts:search for faster queries :)
let $preferred-lables := //skos:prefLabel

let $labels-in-quotes :=
   for $label in $preferred-lables/text()
     return concat("'", $label, "'")
     
let $internal-string := string-join($labels-in-quotes, ', ')
let $javascript-array :=
   concat('source: [', $internal-string, ']')
      

let $html :=
('<!doctype html>',
<html lang="en">
   <head>
     <title>{$title}</title>
     <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
     <link rel="stylesheet" href="/resources/css/bootstrap.min.css"/>
     <script src="//code.jquery.com/jquery-1.10.2.js"></script>
     <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
   </head>
   <body>
      <div class="container">
         <div class="content">
            {style:header()}
            <h4>{$title}</h4>
            <form action="/search/search-niem-service.xqy">
               <label for="autocomplete">NIEM Name: </label>
               <input id="autocomplete" name="q" size="30"/>
               <p>Hit, enter the letter "a".</p>
            </form>
          </div>  
         {style:footer()}
      </div>
      <script>
          $( "#autocomplete" )
          .autocomplete(
            {{
            source: [ "activity", "address", "aircraft", "angular", "area", "document", "facility", "item", "name", "person" ]
            }});
       </script>
   </body>
</html>)

return $html