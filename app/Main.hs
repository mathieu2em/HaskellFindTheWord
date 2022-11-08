module Main where

import Actions (askDifficultyLevel, findTheWordGame, getRandomWordFromListOfWords)
import Types (diffToStr, Difficulty(Easy, Medium, Hard))
import Data.List.Split

main :: IO ()
main = do

    difficulty <- askDifficultyLevel
    putStrLn ("difficulty = " ++ diffToStr difficulty)
    putStrLn "Loading words..."
    
    -- get the words from the dictionary file
    wordsFile <- readFile "words.txt"
    let wordsList = splitOn "\n" wordsFile 
    let easyFilterFunc x = length x < 5 
    let mediumFilterFunc x = length x >= 5 && length x < 10
    let hardFilterFunc x = length x >= 10 
    
    -- randomly select a number from the right category
    let filterWords diff | diff == Easy = easyFilterFunc 
                         | diff == Medium = mediumFilterFunc 
                         | otherwise = hardFilterFunc
    
    wordToFind <- getRandomWordFromListOfWords (filter (filterWords difficulty) wordsList)

    putStrLn "A Word has been chosen for you! Lets Play!"

    findTheWordGame wordToFind

    -- Add colors 
    -- add state handling instead of arguments