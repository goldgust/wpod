
module Main1
where

{-here's a multiline comment-}

data Exp = Elem Int | Binop Exp Exp deriving Show


eval (Elem a) = a
eval (Binop b c) = (eval b) + (eval c)

--end goal: be able to have any depth of nested expressions (just adding two exps togeter for now) and evaluate them