xquery version "1.0-ml";
import module namespace style = "http://danmccreary.com/style" at "/modules/style.xqy";
declare namespace skos="http://www.w3.org/2004/02/skos/core#";

let $uri := xdmp:get-request-field('uri')

let $concept := doc($uri)/skos:Concept
let $prefLabel := $concept/skos:prefLabel/text()

let $title := 'View SKOS Concept' || $prefLabel


return
  if (not($uri))
     then
        <error>
          <message>uri is a required parameter.</message>
        </error> (: continue :)
        
   else if (not(doc-available($uri)))
      then 
      <error code="404">
         <message>{$uri} not found.</message>
      </error> else

  let $concept := doc($uri)/skos:Concept
  let $prefLabel := $concept/skos:prefLabel/text()
  let $altLabels := $concept/skos:altLabel/text()
  let $definition := $concept/skos:definition/text()
  let $broader := $concept/skos:broader/text()

let $content := 
    <div class="content">
       <h4>{$title}</h4>
       <table>
          <tr>
             <td>
               <span class="field-label">Name (Preferred Label): </span> 
             </td>
             <td>
               {$prefLabel}
             </td>
          </tr>
          <tr>
             <td>
              <span class="field-label">Definition: </span>
            </td>
            <td>
              {$definition}
            </td>
          </tr>
          <tr>
             <td>
              <span class="field-label">Broader: </span>
            </td>
            <td>
              {$broader}
            </td>
          </tr>
       </table>
    </div>                                           

return style:assemble-page($title, $content)