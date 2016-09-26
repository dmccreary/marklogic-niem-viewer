xquery version "1.0-ml";
import module namespace style = "http://danmccreary.com/style" at "/modules/style.xqy";

declare option xdmp:output "method=html";

let $title := 'Autocomplete Demo for NIEM Name'

let $content-type := xdmp:set-response-content-type('text/html')      

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
         {style:header()}
         <div class="content">
               <h4>{$title}</h4>
               <form action="/search/search-niem-service.xqy">
                  <label for="autocomplete">NIEM data element name: </label>
                  <input id="autocomplete" size="40"/>
               </form>
          </div>
          {style:footer()}
        </div>
        <script>
            $( "#autocomplete" ).autocomplete({{
              source: function(request, response) {{
               jQuery.get('/unit-tests/autocomplete-json.xqy', {{
                  q: request.term
               }}, function(data) {{  
                  response(data);
               }})
              }},
              
              minLength: 3
            }});
          </script>
   </body>
</html>)

return $html