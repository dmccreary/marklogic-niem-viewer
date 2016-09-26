xquery version "1.0-ml";

import module namespace xsu = "http://marklogic.com/xml-schema-utilities" at "/modules/xml-schema-utils.xqy";

let $element1 :=
  <xs:element name="AcquaintanceAssociation" type="nc:PersonAssociationType" nillable="true">
    <xs:annotation>
      <xs:documentation>An association between people who recognize each other but do not know each other very well.</xs:documentation>
    </xs:annotation>
  </xs:element>
  
let $element2 :=
  <xs:element name="AddressRecipientName" type="nc:TextType" nillable="true">
    <xs:annotation>
      <xs:documentation>A name of a person, organization, or other recipient to whom physical mail may be sent.</xs:documentation>
    </xs:annotation>
  </xs:element>
  
let $expected1 :=
<Concept about="http://release.niem.gov/niem/niem-core/3.0/complex-type/AcquaintanceAssociation" xmlns="http://www.w3.org/2004/02/skos/core#">
   <prefLabel>AcquaintanceAssociation</prefLabel>
   <definition>An association between people who recognize each other but do not know each other very well.</definition>
   <broader>nc:PersonAssociationType</broader>
   <altLabel>Acquaintance</altLabel>
   <altLabel>Association</altLabel>
</Concept>

let $expected2 :=
<Concept about="http://release.niem.gov/niem/niem-core/3.0/complex-type/AddressRecipientName" xmlns="http://www.w3.org/2004/02/skos/core#">
   <prefLabel>AddressRecipientName</prefLabel>
   <definition>A name of a person, organization, or other recipient to whom physical mail may be sent.</definition>
   <broader>nc:TextType</broader>
   <altLabel>Address</altLabel>
   <altLabel>Recipient</altLabel>
   <altLabel>Name</altLabel>
   <member>Name</member>
</Concept>

 return
 <results>
   {xsu:element-to-skos($element1)}
   {xsu:element-to-skos($element2)}
 </results>
