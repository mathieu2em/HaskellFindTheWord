module Main where

import Actions (askDifficultyLevel)

main :: IO ()
main = do

    difficulty <- askDifficultyLevel
    putStrLn ("difficulty = " ++ difficulty)
    -- ask for a letter
    putStrLn "Write a word to search for."
    wordToFind <- getLine
    putStrLn ("you wrote :" ++ wordToFind)

    -- now ask the user to write a single letter
    putStrLn "Write a letter and the program will let you know if its part of the word"
    letter <- getLine
    putStrLn ("you chose the char " ++ letter )
    if letterIsInWord (head letter) wordToFind
        then putStrLn " the letter was part of the word" 
    else putStrLn " the letter isnt part of the word"
    -- show the letter to the user
        

letterIsInWord :: Char -> String -> Bool
letterIsInWord = elem