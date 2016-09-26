xquery version "1.0-ml";

module namespace xsu = "http://marklogic.com/xml-schema-utilities";
(:
import module namespace xsu = "http://marklogic.com/xml-schema-utilities" at "/modules/xml-schema-utils.xqy"; 
:)

declare variable $xsu:representation-terms := ('Address', 'Amount', 'Amt', 'Code', 'Count', 'Date', 'Fraction', 'Id', 'Identifier', 'Ind', 'Indicator', 'Level', 'Nbr', 'Measure', 'Name', 'Number', 'Range', 'Time', 'Uri', 'Value', 'Year');

(: taken from http://www.xqueryfunctions.com/xq/functx_camel-case-to-words.html 
xsu:camel-case-to-words('IndividualPersonCode', ',') -> Individual,Person,Code
:)
 declare function xsu:camel-case-to-sequence($arg as xs:string?)  as xs:string* {
   (: put in dashes before each uppercase letter :)
   let $replace := replace($arg,'(\p{Lu})', '-$1')
   let $first-char := substring($replace, 1, 1)
   return
     if ($first-char = '-')
       then tokenize(substring($replace, 2), '-') 
       else tokenize($replace, '-')
 };
 
 (: given an input like fooBarBla this will return "Bla" :)
  declare function xsu:last-camel-case-word($arg as xs:string?)  as xs:string {
   (: put in dashes before each uppercase letter :)
   let $replace := replace($arg,'(\p{Lu})', '-$1')
   let $first-char := substring($replace, 1, 1)
   return
     if ($first-char = '-')
       then tokenize(substring($replace, 2), '-')[last()]
       else tokenize($replace, '-')[last()]
 };


declare function xsu:name-score($name as xs:string) {
  let $has-upper :=
    if (matches($name, '.*[A-Z]'))
      then 'U'
      else ()
  let $has-lower := 

     if (matches($name, '.*[a-z]'))
         then 'l'
      else ()
        return concat($has-upper, '-', $has-lower)
};
