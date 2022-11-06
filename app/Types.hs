module Types where

data Difficulty = Easy | Medium | Hard deriving (Eq)

diffToStr :: Difficulty -> String
diffToStr diff | diff == Easy = "easy"
            | diff == Medium = "medium"
            | otherwise = "hard"