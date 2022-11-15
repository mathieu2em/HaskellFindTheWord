module Main where

import Actions (askDifficultyLevel, findTheWordGame, filterWordsFromDiff)
import Types (diffToStr)

main :: IO ()
main = do

    difficulty <- askDifficultyLevel
    putStrLn ("difficulty = " ++ diffToStr difficulty)
    putStrLn "Loading words..."
    
    -- get the words from the dictionary file then randomly choose one depending on difficulty level
    wordToFind <- filterWordsFromDiff "words.txt" difficulty

    putStrLn "A Word has been chosen for you! Lets Play!"

    findTheWordGame wordToFind

    -- Add colors 
    -- add state handling instead of arguments