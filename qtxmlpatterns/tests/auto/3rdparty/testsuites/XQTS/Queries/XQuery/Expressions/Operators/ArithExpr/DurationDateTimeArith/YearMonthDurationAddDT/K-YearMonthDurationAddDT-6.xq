(:*******************************************************:)
(: Test: K-YearMonthDurationAddDT-6                      :)
(: Written by: Frans Englich                             :)
(: Date: 2007-11-22T11:31:21+01:00                       :)
(: Purpose: The '+' operator is not available between xs:time and xs:date. :)
(:*******************************************************:)
xs:time("08:12:12") + xs:date("1999-10-12")