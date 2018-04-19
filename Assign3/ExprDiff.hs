{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module ExprDiff where

import ExprEval
import Data.Map as Map
import ExprType

class (EvalExpr a) => DiffExpr a where
  partDiff :: String -> Expr a -> Expr a

instance DiffExpr Double where
  partDiff v (Add e1 e2) = let
    e1' = partDiff v e1
    e2' = partDiff v e2
    in Add e1' e2'
  partDiff v (Mult e1 e2) = let
    e1' = partDiff v e1
    e2' = partDiff v e2
    in Add (Mult e1' e2) (Mult e2' e1)
  partDiff v (Cos e) = let
    e' = partDiff v e
    in Mult (Const (-1)) (Mult (Sin e) e')
  partDiff v (Sin e) = let
    e' = partDiff v e
    in Mult (Cos e) e'
  partDiff v (Ln e) = let
    e' = partDiff v e
    in Mult e' (Inv e)
  partDiff v (Log b e) = let
    e' = partDiff v e
    in Mult e' (Inv (Mult e (Ln (Const b))))
  partDiff v (Exp e) = let
    e' = partDiff v e
    in Mult e' (Exp e)
  partDiff v (Pow e1 e2) = partDiff v (Exp (Mult e2 (Ln e1)))
  partDiff v (Inv e) = Mult (Mult (Const (-1)) (partDiff v e)) (Inv (Pow e (Const 2)))
  partDiff v (Const _) = Const 0
  partDiff v (Var x) = if v == x then Const 1 else Const 0
