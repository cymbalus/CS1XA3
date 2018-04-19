{-# LANGUAGE DeriveGeneric #-}
module ExprType where

import Generic.Random.Generic
import GHC.Generics

{- Datatype for Nmerical Expressions
 - -----------------------------------
 - Supports the following operations
 -   Add - binary addition
 -   Mult - binary multiplication
 -   Const - wraps a constant value
 -   Var - wraps a variable identifier
 -}
data Expr a = Add (Expr a) (Expr a)
            | Mult (Expr a) (Expr a)
            | Cos (Expr a)
            | Sin (Expr a)
            | Ln (Expr a)
            | Log a (Expr a)
            | Exp (Expr a)
            | Pow (Expr a) (Expr a)
            | Inv (Expr a)
            | Const a
            | Var String
  deriving (Eq, Show, Generic)

getVars :: Expr a -> [String]
getVars (Add e1 e2) = getVars e1 ++ getVars e2
getVars (Mult e1 e2) = getVars e1 ++ getVars e2
getVars (Const _) = []
getVars (Var x) = [x]
