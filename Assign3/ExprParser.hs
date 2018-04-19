module ExprParser (parseExprDouble) where

import Text.Parsec
import Text.Parsec.String
import ExprType
import ExprEval

parseExprDouble :: String -> Expr Double
parseExprDouble ss =
  case parse exprD "" ss of
    Left err  -> error $ "Parse Error: " ++ show err
    Right val -> val

exprD :: Parser (Expr Double)
exprD = let
   base = parens exprD <|> parseUnary exprD <|> parseBase
   factor = base `chainl1` expop
   term = factor `chainl1` mulop
  in term `chainl1` addop

parseBase :: Parser (Expr Double)
parseBase = try (do { c <- parseConst; vrs <- parseVars; return (c !* vrs) })
            <|> do { c <- parseConst; return c }
            <|> do { vrs <- parseVars; return vrs }

parseConst :: Parser (Expr Double)
parseConst = do
  d <- double
  return (Const d)

parseVars :: Parser (Expr Double)
parseVars = let
  toExpr (x:[])   = var [x]
  toExpr (x:y:[]) = var [x] !* var [y]
  toExpr (x:vrs) = var [x] !* (toExpr vrs)
  in do
    vrs <- many1 alphaNum
    return $ toExpr vrs

parseUnary :: Parser (Expr Double) -> Parser (Expr Double)
parseUnary p = unary "-" (Const (-1) !*) p
               <|> unary "cos" cosine p
               <|> unary "sin" sine p
               <|> unary "ln" ln p
               <|> unary "inv" inv p
               <|> unary "exp" ex p

mulop :: Parser (Expr Double -> Expr Double -> Expr Double)
mulop = do { symbol "*"; return (!*) }
        <|> do { symbol "/"; return (\x y -> x !* (Inv y)) }

expop :: Parser (Expr Double -> Expr Double -> Expr Double)
expop = do { symbol "^"; return (!^) }

addop :: Parser (Expr Double -> Expr Double -> Expr Double)
addop = do { symbol "+"; return (!+) }
        <|> do { symbol "-"; return (\x y -> x !+ ((Const (-1)) !* y)) }

unary :: String -> (Expr a -> Expr a) -> Parser (Expr a) -> Parser (Expr a)
unary s f p = do symbol s
                 parse <- p
                 return $ f parse


{- ------------------------------------------------------------------------------------------------------------
 - Utility Combinators
 - ------------------------------------------------------------------------------------------------------------
 -}
parens :: Parser a -> Parser a
parens p = do { char '(';
                cs <- p;
                char ')';
                return cs }

symbol :: String -> Parser String
symbol ss = let
  symbol' :: Parser String
  symbol' = do { spaces;
                 ss' <- string ss;
                 spaces;
                 return ss' }
  in try symbol'

digits :: Parser String
digits = many1 digit

negDigits :: Parser String
negDigits = do { neg <- symbol "-" ;
                 dig <- digits ;
                 return (neg ++ dig) }


integer :: Parser Integer
integer = fmap read $ try negDigits <|> digits

double :: Parser Double
double = fmap read $ do
  whole <- try negDigits <|> digits
  dot <- (symbol ".") <|> string ""
  frac <- if dot == "." then digits else string ""
  return $ whole ++ dot ++ frac
