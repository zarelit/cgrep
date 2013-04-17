module CGrep.Strategy.BoyerMoore (cgrepBoyerMoore) where

import Data.ByteString.Search as C

import qualified Data.ByteString.Char8 as C
import Control.Monad(liftM, when)

import CGrep.Function
import CGrep.Output
import CGrep.Options 


cgrepBoyerMoore :: CgrepFunction
cgrepBoyerMoore opt pats f = do
    content <- liftM (zip [1..] . C.lines) (strictReadFile f)

    when (debug opt) $ print content

    return $ concatMap (simpleBoyerMoore opt f pats) content


simpleBoyerMoore :: Options -> FilePath -> [C.ByteString] -> (Int, C.ByteString) -> [Output]
simpleBoyerMoore opt f ps (n, l) =
    if null pfilt `xor` invert_match opt 
      then []
      else [StrictOutput f n l (map C.unpack pfilt)]
    where pfilt = filter (\p -> not . null $ C.indices p l) ps    