xquery version "1.0-ml";

(: Site Landing Page :)

import module namespace style="http://danmccreary.com/style" at "/modules/style.xqy";
declare option xdmp:output "method=html";

let $title := 'MarkLogic NIEM Tools'

let $content := 
<div class="content">
      <h4>Welcome to the {$title}</h4>
      
      <p>This application is a a training tool to demonstrate the power of
      using MarkLogic to list and search the NIEM Metadata Registry.</p>
       
      <a href="/views/index.xqy">List Views</a> - Read-only tabular reports and listings.<br/>
      <a href="/search/index.xqy">List Search Services</a> - Search services.<br/>
      <a href="/services/index.xqy">List REST Data Services</a> - List REST data services.<br/>
      <a href="/scripts/index.xqy">List Scripts</a> - Scripts that modify the data.<br/>
      <a href="/unit-tests/index.xqy">Unit Tests</a> - Manual unit tests to verify low-level functions.<br/>
      
      Please contact Dan McCreary for questions on the demo.
</div>

return style:assemble-page($title, $content)
