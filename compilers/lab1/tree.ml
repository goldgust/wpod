(* lab1/tree.ml *)
(* Copyright (c) 2017 J. M. Spivey *)

type ident = string

(* |name| -- type for applied occurrences, with annotations *)
type name =
  { x_name: ident;              (* Name of the reference *)
    x_lab: string;              (* Global label *)
    x_line: int }               (* Line number *)

let make_name x ln = { x_name = x; x_lab = "_" ^ x; x_line = ln }


(* Abstract syntax *)
type program = Program of stmt

and stmt =
    Skip
  | Seq of stmt list
  | Assign of name * expr
  | Print of expr
  | Newline
  | IfStmt of expr * stmt * stmt
  | WhileStmt of expr * stmt
  | RepeatStmt of expr * stmt
  | ExitStmt
  | LoopStmt of stmt

and expr =
    Constant of int
  | Variable of name
  | Monop of Keiko.op * expr
  | Binop of Keiko.op * expr * expr

let seq =
  function
      [] -> Skip                (* Use Skip in place of Seq [] *)
    | [s] -> s                  (* Don't use a Seq node for one element *)
    | ss -> Seq ss


(* Pretty printer *)

open Print

let fTail f xs =
  let g prf = List.iter (fun x -> prf "; $" [f x]) xs in fExt g

let fList f =
  function
      [] -> fStr "[]"
    | x::xs -> fMeta "[$$]" [f x; fTail(f) xs]

let fName x = fStr x.x_name

let rec fExpr =
  function
      Constant n ->
        fMeta "Constant_$" [fNum n]
    | Variable x ->
        fMeta "Variable_\"$\"" [fName x]
    | Monop (w, e1) ->
        fMeta "Monop_($, $)" [fStr (Keiko.op_name w); fExpr e1]
    | Binop (w, e1, e2) ->
        fMeta "Binop_($, $, $)" [fStr (Keiko.op_name w); fExpr e1; fExpr e2]

let rec fStmt =
  function
      Skip ->
        fStr "Skip"
    | Seq ss ->
        fMeta "Seq_$" [fList(fStmt) ss]
    | Assign (x, e) ->
        fMeta "Assign_(\"$\", $)" [fName x; fExpr e]
    | Print e ->
        fMeta "Print_($)" [fExpr e]
    | Newline ->
        fStr "Newline"
    | IfStmt (e, s1, s2) ->
        fMeta "IfStmt_($, $, $)" [fExpr e; fStmt s1; fStmt s2]
    | WhileStmt (e, s) ->
        fMeta "WhileStmt_($, $)" [fExpr e; fStmt s]
    | RepeatStmt (e, s) ->
        fMeta "RepeatStmt_($, $)" [fExpr e; fStmt s]
    | LoopStmt s ->
        fMeta "LoopStmt_($)" [fStmt s]
    | ExitStmt ->
        fStr "ExitStmt"
 (*   | CaseStmt (e, cases, elsept) ->
        let fArm (labs, body) =
          fMeta "($, $)" [fList(fNum) labs; fStmt body] in
        fMeta "CaseStmt_($, $, $)"
          [fExpr e; fList(fArm) cases; fStmt elsept]
*)
    | _ ->
        (* Catch-all for statements added later *)
        fStr "???"

let print_tree fp (Program s) = fgrindf fp "" "$" [fStmt s]

