xquery version "1.0-ml";

import module namespace xsu = "http://marklogic.com/xml-schema-utilities" at "/modules/xml-schema-utils.xqy";

let $complex-type :=
<xs:complexType name="ActivityConveyanceAssociationType">
    <xs:annotation>
      <xs:documentation>A data type for an association between an activity and a conveyance.</xs:documentation>
    </xs:annotation>
    <xs:complexContent>
      <xs:extension base="nc:AssociationType">
        <xs:sequence>
          <xs:element ref="nc:Activity" minOccurs="0" maxOccurs="unbounded"/>
          <xs:element ref="nc:Conveyance" minOccurs="0" maxOccurs="unbounded"/>
          <xs:element ref="nc:ActivityConveyanceAssociationAugmentationPoint" minOccurs="0" maxOccurs="unbounded"/>
        </xs:sequence>
      </xs:extension>
    </xs:complexContent>
  </xs:complexType>
  
let $expected :=
  <Concept about="http://release.niem.gov/niem/niem-core/3.0/complex-type/ActivityConveyanceAssociationType" xmlns="http://www.w3.org/2004/02/skos/core#">
   <prefLabel>ActivityConveyanceAssociationType</prefLabel>
   <definition>A data type for an association between an activity and a conveyance.</definition>
   <broader>nc:AssociationType</broader>
   <altLabel>Activity</altLabel>
   <altLabel>Conveyance</altLabel>
   <altLabel>Association</altLabel>
   <altLabel>Type</altLabel>
</Concept>
  
 return
 <results>
   {xsu:complex-type-to-skos($complex-type)}
 </results>
