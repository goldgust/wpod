(* lab1/gcd.p *)

begin
  n := 200000000;
  b := 0; t := n;
  while (t - b) > 1 do
    avg := (t + b) div 2;
    print b; print t; print avg; newline;

    if avg > 46340 then
      avg := 46340;
    end;
    if avg * avg > n then
      t := avg
    else
      b := avg
    end;

  end;
  print b; newline
end.

(*<<
 5
>>*)
