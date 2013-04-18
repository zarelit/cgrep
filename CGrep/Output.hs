{-# LANGUAGE ExistentialQuantification #-} 

module CGrep.Output where

import CGrep.Options
import CGrep.StringLike

data Output = forall a. (StringLike a) => Output FilePath Int a [String]


showOutput :: Options -> Output -> String
showOutput Options { no_filename = False, no_linenumber = False } (Output f n l _) = f ++ ":" ++ show n ++ ":" ++ slToString l
showOutput Options { no_filename = False, no_linenumber = True  } (Output f _ l _) = f ++ ":" ++ slToString l
showOutput Options { no_filename = True , no_linenumber = False } (Output _ n l _) = show n ++ ":" ++ slToString l
showOutput Options { no_filename = True , no_linenumber = True  } (Output _ _ l _) = slToString l

