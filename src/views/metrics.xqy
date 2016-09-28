xquery version "1.0-ml";
import module namespace style = "http://danmccreary.com/style" at "/modules/style.xqy";

(:
This XQuery Script Transforms NIEM Core Elements from input XML Schema file into
an HTML file.
	     
    Author:Dan McCreary
    Copyright: 2016 Kelly-McCreary & Associates, All Rights Reserved
    License: Apache 2.0
    Version History:
		
:)
declare namespace s="http://niem.gov/niem/structures/2.0";
declare namespace nc="http://niem.gov/niem/niem-core/2.0";
declare namespace niem-xsd="http://niem.gov/niem/proxy/xsd/2.0";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare namespace j="http://niem.gov/niem/domains/jxdm/4.0";
declare namespace i="http://niem.gov/niem/appinfo/2.0";
declare option xdmp:output "method=html";

let $title := 'NIEM Viewer Metrics'

let $content := 
    <div class="content">
    <div class="row">
      <div class="col-md-3">
       <h4>{$title}</h4>
       <table class="table table-striped table-bordered table-hover table-condensed ">
          <thead>
             <tr>
                <tr>
                   <th class="col-md-2">Metric</th>
                   <th class="col-md-1">Value</th>
                </tr>
             </tr>
          </thead>
          <tbody>
            <tr>
               <td class="right col-md-3">
                 <span class="field-label">Total Document Count: </span> 
               </td>
               <td>
                 {format-number(xdmp:estimate(/), '#,###')}
               </td>
            </tr>
            <tr>
               <td class="right col-md-3">
                 <span class="field-label">Object-Classs: </span> 
               </td>
               <td>
                 {count(cts:uri-match('/niem-concepts/complex-types/*.xml'))}
               </td>
            </tr>
            <tr>
               <td class="right">
                <span class="field-label">Properties: </span>
              </td>
              <td>
                {format-number(count(cts:uri-match('/niem-concepts/elements/*.xml')), '#,###')}
              </td>
            </tr>
            <tr>
               <td class="right">
                <span class="field-label">Input XML Schemas: </span>
              </td>
              <td>
                {count(cts:uri-match('*.xsd'))}
              </td>
            </tr>
            <tr>
               <td class="right">
                <span class="field-label">Saved want lists: </span>
              </td>
              <td>
                {count(cts:uri-match('/users/*/*wantlist.xml'))}
              </td>
            </tr>
          </tbody>
       </table>
       </div>
       </div>
    </div>                                           

return style:assemble-page($title, $content)