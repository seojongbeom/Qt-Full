(:*******************************************************:)
(: Test: K-SeqExprCast-740                               :)
(: Written by: Frans Englich                             :)
(: Date: 2007-11-22T11:31:22+01:00                       :)
(: Purpose: 'castable as' involving xs:yearMonthDuration as sourceType and xs:NOTATION should fail due to it involving xs:NOTATION. :)
(:*******************************************************:)
not(xs:yearMonthDuration("P1Y12M") castable as xs:NOTATION)