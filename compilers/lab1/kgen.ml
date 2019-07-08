(* lab1/kgen.ml *)
(* Copyright (c) 2017 J. M. Spivey *)

open Tree
open Keiko

let optflag = ref false

(* |gen_expr| -- generate code for an expression *)
let rec gen_expr =
  function
      Constant x ->
        CONST x
    | Variable x ->
        SEQ [LINE x.x_line; LDGW x.x_lab]
    | Monop (w, e1) ->
        SEQ [gen_expr e1; MONOP w]
    | Binop (w, e1, e2) ->
        SEQ [gen_expr e1; gen_expr e2; BINOP w]

(* |gen_cond| -- generate code for short-circuit condition *)
let rec gen_cond e tlab flab =
  (* Jump to |tlab| if |e| is true and |flab| if it is false *)
  match e with
      Constant x ->
        if x <> 0 then JUMP tlab else JUMP flab
    | Binop ((Eq|Neq|Lt|Gt|Leq|Geq) as w, e1, e2) ->
        SEQ [gen_expr e1; gen_expr e2; JUMPC (w, tlab); JUMP flab]
    | Monop (Not, e1) ->
        gen_cond e1 flab tlab
    | Binop (And, e1, e2) ->
        let lab1 = label () in
        SEQ [gen_cond e1 lab1 flab; LABEL lab1; gen_cond e2 tlab flab]
    | Binop (Or, e1, e2) ->
        let lab1 = label () in
        SEQ [gen_cond e1 tlab lab1; LABEL lab1; gen_cond e2 tlab flab]
    | _ ->
        SEQ [gen_expr e; CONST 0; JUMPC (Neq, tlab); JUMP flab]

(* |gen_stmt| -- generate code for a statement *)
let rec gen_stmt s exit_label =
  match s with
      Skip -> NOP
    | Seq stmts -> SEQ (List.map (fun n->gen_stmt n exit_label) stmts)
    | Assign (v, e) ->
        SEQ [LINE v.x_line; gen_expr e; STGW v.x_lab]
    | Print e ->
        SEQ [gen_expr e; CONST 0; GLOBAL "lib.print"; PCALL 1]
    | Newline ->
        SEQ [CONST 0; GLOBAL "lib.newline"; PCALL 0]
    | IfStmt (test, thenpt, elsept) ->
        let lab1 = label () and lab2 = label () and lab3 = label () in
        SEQ [gen_cond test lab1 lab2;
          LABEL lab1; gen_stmt thenpt exit_label; JUMP lab3;
          LABEL lab2; gen_stmt elsept exit_label; LABEL lab3]
    | WhileStmt (test, body) ->
        let lab1 = label () and lab2 = label () and lab3 = label () in
        SEQ [JUMP lab2; LABEL lab1; gen_stmt body exit_label;
          LABEL lab2; gen_cond test lab1 lab3; LABEL lab3]
    | RepeatStmt (test, body) ->
        let lab1 = label () and lab2 = label () in
        SEQ [LABEL lab1; gen_stmt body exit_label;
           gen_cond test lab2 lab1; LABEL lab2]
    | ExitStmt ->
        SEQ [JUMP exit_label]
    | LoopStmt (body) ->
        let lab1 = label () and exit_lab = label () in
        SEQ [LABEL lab1; gen_stmt body exit_lab;
           JUMP lab1; LABEL exit_lab]

(* |start_stmt| -- give the code generator a label for the end of the function *)
let start_stmt s =
    let lab1 = label () in
    SEQ [gen_stmt s lab1; LABEL lab1]

(* |translate| -- generate code for the whole program *)
let translate (Program ss) =
  let code = start_stmt ss in
  Keiko.output (if !optflag then Peepopt.optimise code else code)
