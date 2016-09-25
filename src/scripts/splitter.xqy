xquery version "1.0-ml";
import module namespace style = "http://danmccreary.com/style" at "/modules/style.xqy";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

declare function local:insert-document($uri as xs:string, $doc as element()) {
 if (doc-available($uri))
  then ()
  else xdmp:document-insert($uri, $doc, xdmp:default-permissions(), ('data-element'))
};

let $title := 'Split NIEM into Documents For Better Search Relevency'

let $uri := xdmp:get-request-field('uri', '/niem-core.xsd')
let $schema := doc($uri)/xs:schema

let $named-complex-types := $schema//xs:complexType[@name]
let $named-elements := $schema//xs:element[@name]

let $named-complex-type-count := count($named-complex-types)
let $element-count := count($named-elements)

let $insert-complex-types :=
   for $complex-type in $named-complex-types
      let $name := $complex-type/@name/string()
      let $uri := '/niem-concepts/complex-types/' || $name || '.xml'
      let $insert := xdmp:spawn-function(function() {local:insert-document($uri, $complex-type)},
              <options xmlns="xdmp:eval">
               <transaction-mode>update-auto-commit</transaction-mode>
             </options>)
           return $uri

let $insert-named-elements :=
   for $element in $named-complex-types
      let $name := $element/@name/string()
      let $uri := '/niem-concepts/elements/' || $name || '.xml'
      let $insert := xdmp:spawn-function(function() {local:insert-document($uri, $element)},
              <options xmlns="xdmp:eval">
               <transaction-mode>update-auto-commit</transaction-mode>
             </options>)
           return $uri
           
let $content := 

    <div class="content">
       <h4>{$title}</h4>
       Results:<br/>
       Complex Types inserted: {$named-complex-type-count} <br/>
       Named Elements inserted.{$element-count} <br/>
       {for $uri in ($insert-complex-types, $insert-complex-types)
        return
           <div>
              <a href="/views/view-xml.xqy?uri={$uri}">{$uri}</a>
           </div>
       }
    </div>                                           

return style:assemble-page($title, $content)