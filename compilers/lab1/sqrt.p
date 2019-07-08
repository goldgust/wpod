(* lab1/gcd.p *)

begin
  n := 5;
  b := 0; t := n;
  while (t - b) > 1 do
    avg := (t + b) div 2;
    if avg * avg > n then
      t := avg
    else
      b := avg
    end
  end;
  print b; newline
end.

(*<<
 5
>>*)
