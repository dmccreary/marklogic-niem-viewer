xquery version "1.0-ml";
import module namespace style = "http://danmccreary.com/style" at "/modules/style.xqy";
declare namespace skos="http://www.w3.org/2004/02/skos/core#";
declare option xdmp:output "method=html";

let $uri := xdmp:get-request-field('uri')

let $concept := doc($uri)/skos:Concept
let $prefLabel := $concept/skos:prefLabel/text()

let $title := 'View NIEM Concept' || $prefLabel


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
  let $about := $concept/@about/string()
  let $object-class := contains($about, '/complex-type/')
  let $prefLabel := $concept/skos:prefLabel/text()
  let $altLabels := $concept/skos:altLabel/text()
  let $definition := $concept/skos:definition/text()
  let $broader := $concept/skos:broader/text()

let $content := 
    <div class="content">
    <div class="row">
       <h4>{$title}</h4>
       <table class="table table-striped table-bordered table-hover table-condensed">
          <thead>
             <tr>
             </tr>
          </thead>
          <tbody>
            <tr>
               <td class="right col-md-3">
                 <span class="field-label">ObjectClass or Property: </span> 
               </td>
               <td>
                 {if ($object-class)
                    then 'Object Class'
                    else 'Property'
                 }
               </td>
            </tr>
            <tr>
               <td class="right col-md-3">
                 <span class="field-label">Name (Preferred Label): </span> 
               </td>
               <td>
                 {$prefLabel}
               </td>
            </tr>
            <tr>
               <td class="right">
                <span class="field-label">Definition: </span>
              </td>
              <td>
                {$definition}
              </td>
            </tr>
            <tr>
               <td class="right">
                <span class="field-label">Broader: </span>
              </td>
              <td>
                <a href="/views/view-skos-concept.xqy?name={$broader}">{$broader}</a>
              </td>
            </tr>
            {for $alt-label in $altLabels
            return
              <tr>
                 <td class="right">
                  <span class="field-label">Alternate Label: </span>
                </td>
                <td>
                  {$alt-label}
                </td>
              </tr>
            }
          </tbody>
       </table>
       
       <a href="/views/view-xml.xqy?uri={$uri}">view XML</a>
       </div>
    </div>                                           

return style:assemble-page($title, $content)