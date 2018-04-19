{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
module ExprTest where

import Data.Map as Map

import ExprType
import ExprEval
import ExprDiff

import Test.QuickCheck
import Generic.Random.Generic
import GHC.Generics

instance Arbitrary (Expr Double) where
  arbitrary = genericArbitraryRec uniform `withBaseCase` return (Const 1)

{-
Simplify is idempotent
simplify e == simplify (simplify e)
-}
simplifyProp1 :: Expr Double -> Bool
simplifyProp1 e = simplify vrs e == simplify vrs (simplify vrs e)
  where vrs = Map.fromList []

{-
e(x1,x2,...,xn) == (simplify e)(x1,x2,...,xn)
-}
simplifyProp2 :: (Expr Double, [Double]) -> Bool
simplifyProp2 (e, xs) = let
  varStrs = vars e
  vrs = Map.fromList $ zip varStrs (formatList xs (length varStrs))
  formatList xs len = if length xs < len
                        then formatList (xs ++ [0]) len
                        else xs
  s = simplify (Map.fromList []) e
  inTol x y = abs (x - y) <= abs (x / 1000)
  eql r1 r2 = case (r1, r2) of
    (Result x, Result y) -> inTol x y
    (EvalError _, EvalError _) -> True
    _                          -> False
  in eql (eval vrs e) (eval vrs s)
