{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module ExprEval where

import Data.Map as Map
import Data.List
import ExprType

data EvalResult a = Result a
                  | EvalError String
  deriving Show

instance Functor EvalResult where
  fmap f (Result x) = Result (f x)
  fmap f (EvalError e) = EvalError e

instance Applicative EvalResult where
  pure x = Result x
  (Result f) <*> x    = fmap f x
  (EvalError e) <*> _ = EvalError e

class EvalExpr a where
  eval :: Map.Map String a -> Expr a -> EvalResult a
  simplify :: Map.Map String a -> Expr a -> Expr a
  vars :: Expr a -> [String]

  {- Default Methods -}
  (!+) :: Expr a -> Expr a -> Expr a
  e1 !+ e2 = simplify (Map.fromList []) (Add e1 e2)
  (!*) :: Expr a -> Expr a -> Expr a
  e1 !* e2 = simplify (Map.fromList []) (Mult e1 e2)
  (!/) :: Expr a -> Expr a -> Expr a
  e1 !/ e2 = simplify (Map.fromList []) (Mult e1 (Inv e2))
  cosine :: Expr a -> Expr a
  cosine = Cos
  sine :: Expr a -> Expr a
  sine = Sin
  ln :: Expr a -> Expr a
  ln = Ln
  logg :: a -> Expr a -> Expr a
  logg b = Log b
  ex :: Expr a -> Expr a
  ex e = simplify (Map.fromList []) (Exp e)
  (!^) :: Expr a -> Expr a -> Expr a
  e1 !^ e2 = simplify (Map.fromList []) (Pow e1 e2)
  inv :: Expr a -> Expr a
  inv = Inv
  val :: a -> Expr a
  val = Const
  var :: String -> Expr a
  var = Var

instance EvalExpr Double where
  eval vrs (Add e1 e2) = (+) <$> (eval vrs e1) <*> (eval vrs e2)
  eval vrs (Mult e1 e2) = (*) <$> (eval vrs e1) <*> (eval vrs e2)
  eval vrs (Cos e) = fmap cos (eval vrs e)
  eval vrs (Sin e) = fmap sin (eval vrs e)
  eval vrs (Ln e) = case eval vrs e of
    Result r -> if r > 0 then Result (log r) else EvalError "Cannot take ln of non-positive numbers"
    EvalError err -> EvalError err
  eval vrs (Log b e) = case eval vrs e of
    Result r -> if r > 0 && b > 0 then Result (logBase b r) else EvalError "Cannot take log of non-positive numbers"
    EvalError err -> EvalError err
  eval vrs (Exp e) = case eval vrs e of
    Result r -> if r <= 706 then Result (exp r) else EvalError "Exp argument too large"
    EvalError err -> EvalError err
  eval vrs (Pow e1 e2) = case (eval vrs e1, eval vrs e2) of
    (Result r1, Result r2) ->
      if isNaN (r1 ** r2) || (r1 ** r2) == exp 1000 then EvalError "Invalid Pow operands"
                                                    else Result (r1 ** r2)
    (EvalError err, _)     -> EvalError err
    (_, EvalError err)     -> EvalError err
  eval vrs (Inv e) = case eval vrs e of
    Result r -> if r /= 0 then Result (1/r) else EvalError "Cannot divide by 0"
    EvalError err -> EvalError err
  eval vrs (Const c) = Result c
  eval vrs (Var v) = case Map.lookup v vrs of
   Just val -> pure val
   Nothing -> EvalError $ "Missing variable " ++ v

  simplify vrs (Var v) = case Map.lookup v vrs of
    Just val -> Const val
    Nothing  -> Var v
  simplify vrs (Mult e (Add e1 e2)) = simplify vrs (Add (simplify vrs (Mult e e1)) (simplify vrs (Mult e e2)))
  simplify vrs (Mult (Add e1 e2) e) = simplify vrs (Mult e (Add e1 e2))
  simplify vrs (Add e1 e2) = let
    s1 = simplify vrs e1
    s2 = simplify vrs e2
    in case (s1, s2) of
      (Const x, Const y)            -> Const (x+y)
      (Const x, (Add (Const y) e')) -> simplify vrs (Add (Const (x+y)) e')
      (Const x, e')                 -> if x == 0 then e'
                                                 else Add (Const x) e'
      (e', Const x)                 -> simplify vrs (Add (Const x) e')
      (Mult (Const x) e1', Mult (Const y) e2') ->
        if e1' == e2' then simplify vrs (Mult (Const (x+y)) e1')
                      else Add (Mult (Const x) e1') (Mult (Const y) e2')
      (Mult (Const x) e1', e2')     ->
        if e1' == e2' then simplify vrs (Mult (Const (x+1)) e1')
                      else Add (Mult (Const x) e1') e2'
      (e1', Mult (Const y) e2')     ->
        if e1' == e2' then simplify vrs (Mult (Const (y+1)) e1')
                      else Add e1' (Mult (Const y) e2')
      (e1', e2')                    ->
        if e1' == e2' then simplify vrs (Mult (Const 2) e1')
                      else Add e1' e2'

  simplify vrs (Mult e1 e2) = let
    s1 = simplify vrs e1
    s2 = simplify vrs e2
    in case (s1, s2) of
      (Const x, Const y)             -> Const (x*y)
      (Const x, (Mult (Const y) e')) -> simplify vrs (Mult (Const (x*y)) e')
      (Const x, e')                  -> if x == 0 then e'
                                                  else if x == 0 then Const 0
                                                  else Mult (Const x) e'
      (e', Const x)                  -> simplify vrs (Mult (Const x) e')
      (Pow e1' e2', Pow e3' e4')     ->
        if e1' == e3' then simplify vrs (Pow e1' (simplify vrs (Add e2' e4')))
                      else Mult s1 s2
      (e1', Inv e2')                 ->
        if e1' == e2' then Const 1
                      else Mult e1' (Inv e2')
      (Inv e1', e2')                 ->
        if e1' == e2' then Const 1
                      else simplify vrs (Mult e2' (Inv e1'))
      (Mult (Const x) e1', Mult (Const y) e2') ->
        if e1' == e2' then simplify vrs (Mult (Const (x*y)) e1')
                      else Mult e1' e2'
      (Mult (Const x) e1', e2')      -> simplify vrs (Mult (Const x) (Mult e1' e2'))
      (e1', Mult (Const x) e2')      -> simplify vrs (Mult (Const x) (Mult e1' e2'))
      (e1', e2')                     -> Mult e1' e2'

  simplify vrs (Cos e) = let
    s = simplify vrs e
    in case s of
      (Const x) -> Const (cos x)
      e'        -> Cos e'
  simplify vrs (Sin e) = let
    s = simplify vrs e
    in case s of
      (Const x) -> Const (sin x)
      e'        -> Sin e
  simplify vrs (Ln e) = let
    s = simplify vrs e
    in case s of
      (Const x) -> case eval vrs (Ln s) of
        Result r -> Const r
        EvalError err -> Ln s
      e'        -> Ln e'
  simplify vrs (Log a e) = let
    s = simplify vrs e
    in case s of
      (Const x) -> case eval vrs (Log a s) of
        Result r -> Const r
        EvalError err -> Log a s
      e'        -> Log a e'
  simplify vrs (Exp e) = let
    s = simplify vrs e
    in case s of
      (Const x)                -> case eval vrs (Exp s) of
        Result r -> Const r
        EvalError err -> Exp s
      (Mult (Const x) (Ln e')) -> simplify vrs (Pow e' (Const x))
      e'                       -> Exp e'
  simplify vrs (Pow e1 e2) = let
    s1 = simplify vrs e1
    s2 = simplify vrs e2
    in case (s1, s2) of
      (Const x, Const y)  ->
        if isNaN (x ** y) then Pow s1 s2
                          else Const (x**y)
      (Mult e1' e2', e3') -> simplify vrs (Mult (Pow e1' e3') (Pow e2' e3'))
      (e1', e2')          -> Pow e1' e2'
  simplify vrs (Inv e) = let
    s = simplify vrs e
    in case s of
      (Inv e')  -> e'
      (Const x) -> case eval vrs (Inv s) of
        Result r -> Const r
        EvalError err -> Inv s
      e'        -> Inv e'
  simplify vrs (Const a) = Const a

  vars expr = let
    cvars vrs (Add e1 e2)  = cvars vrs e1 ++ cvars vrs e2
    cvars vrs (Mult e1 e2) = cvars vrs e1 ++ cvars vrs e2
    cvars vrs (Cos e)      = cvars vrs e
    cvars vrs (Sin e)      = cvars vrs e
    cvars vrs (Ln e)       = cvars vrs e
    cvars vrs (Log _ e)    = cvars vrs e
    cvars vrs (Exp e)      = cvars vrs e
    cvars vrs (Pow e1 e2)  = cvars vrs e1 ++ cvars vrs e2
    cvars vrs (Inv e)      = cvars vrs e
    cvars vrs (Const _)    = []
    cvars vrs (Var s)      = [s]
    in nub $ cvars [] expr
