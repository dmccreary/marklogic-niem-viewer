xquery version "1.0-ml";
import module namespace style = "http://danmccreary.com/style" at "/modules/style.xqy";
declare namespace skos="http://www.w3.org/2004/02/skos/core#";
declare namespace w="http://niem.gov/niem/wantlist/2.2";
declare option xdmp:output "method=html";
declare option xdmp:transaction-mode "update";

(: add selected item to a wantlist file 
XML Schema file: https://reference.niem.gov/niem/resource/wantlist/2.2/wantlist-2.2-annotated.xsd

<WantList xmlns="http://niem.gov/niem/wantlist/2.2">
    <Element w:name="qName" w:qualifier="qualifier" w:isReference="false" w:nillable="false"/>
</WantList>
:)


let $title := 'Add to Wantlist'

let $uri := xdmp:get-request-field('uri')

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

let $user := xdmp:get-current-user()
let $wantlist-uri := '/users/' || $user || '/current-wantlist.xml'
let $new-element := <w:Element w:name="{$prefLabel}" w:isReference="false" w:nillable="false"/>

let $create-or-append :=
  if (doc-available($wantlist-uri))
     then
        let $element := doc()/w:WantList/w:Element
        let $insert-after-last := xdmp:node-insert-after($element, $new-element)
        let $commit := xdmp:commit()
        return 'appended'
     else
        let $template :=
         <WantList xmlns="http://niem.gov/niem/wantlist/2.2">
             {$new-element}
         </WantList>
        let $insert-document := xdmp:document-insert($wantlist-uri, $template)
        let $commit := xdmp:commit()
        return 'created'

let $content := 
    <div class="content">
       <h4>{$title}</h4>
       Your wantlist document at {$wantlist-uri} has been {$create-or-append}.<br/>
       Element Added: {$prefLabel}<br/>
       <a href="/views/view-xml.xqy?uri={$wantlist-uri}">View WantList</a>
    </div>                                           

return style:assemble-page($title, $content)