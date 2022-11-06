module Main where

import Actions (askDifficultyLevel, findTheWordGame)

main :: IO ()
main = do

    difficulty <- askDifficultyLevel
    putStrLn ("difficulty = " ++ difficulty)
    -- ask for a letter
    putStrLn "Write a word to search for."
    wordToFind <- getLine
    putStrLn ("you wrote :" ++ wordToFind)

    findTheWordGame wordToFind