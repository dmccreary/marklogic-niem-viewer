 xquery version "1.0-ml";
 declare namespace skos="http://www.w3.org/2004/02/skos/core#";

let $results := cts:search(/,
   cts:and-query(
      (cts:directory-query('/niem-concepts/', "infinity"),
      cts:element-value-query(xs:QName('skos:prefLabel'), 'person')
      )
     ), "unfiltered"
   )

let $expected :=
<Concept about="http://release.niem.gov/niem/niem-core/3.0/complex-type/Person" xmlns="http://www.w3.org/2004/02/skos/core#">
    <prefLabel>Person</prefLabel>
   <definition>A human being.</definition>
   <broader>nc:PersonType</broader>
   <altLabel>Person</altLabel>
</Concept>

return $results