(:*******************************************************:)
(:Test: fn-timezone-from-dateTime-3                      :)
(:Written By: Carmelo Montanez                           :)
(:Date: June 27, 2005                                    :)
(:Purpose: Evaluates The "timezone-from-dateTime" function  :)
(:As per example 3 (for this function) of the F&O  specs.:)
(:Use the fn:count function to avoid empty file.         :)
(:*******************************************************:)
fn:count(fn:timezone-from-dateTime(xs:dateTime("2004-08-27T00:00:00")))