{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant if" #-}
module Actions where

import Types (Difficulty(Easy, Medium, Hard))
import System.Random
import Data.List.Split

-- Additional IO Actions functions are gonna be here.
-- verify if the letter is part of the word
askDifficultyLevel :: IO Difficulty
askDifficultyLevel = askDifficultyLevel' False
    
-- ask the level of difficulty to the user
askDifficultyLevel' :: Bool -> IO Difficulty
askDifficultyLevel' b = do
    let errorMessage = "Invalid Option. valid options are 1, 2 or 3.\n"
    let message = "Choose the difficulty level : \n write 1 for easy, 2 for medium, 3 for hard."
    
    let errorHandling x = if x then errorMessage ++ message else message
    putStrLn (errorHandling b)
    
    diffLevel <- getLine

    case diffLevel of
        "1" -> return Easy
        "2" -> return Medium
        "3" -> return Hard
        _ -> askDifficultyLevel' True
        

guessLetter :: IO Char
guessLetter = do 
    putStrLn "Enter a letter to guess the word"
    head <$> getLine

findTheWordGame :: String -> IO ()
findTheWordGame wordToFind = findTheWordGame' (map (const '-') wordToFind) wordToFind []

findTheWordGame' :: String -> String -> [Char] -> IO () 
findTheWordGame' foundLetters completeWord alreadyUsedLetters = do
    putStrLn foundLetters
    putStrLn ("already used letters : " ++ alreadyUsedLetters)
    -- validation checkers (length etc.)
    -- TODO
    -- check if letter is in the word
    letter <- guessLetter
    -- setup the function to create the partial word from the context and guessed letter
    let createPartialWordWithContext = createPartialWord completeWord foundLetters letter
    if letter `elem` completeWord then do
        putStrLn ("The letter \"" ++ [letter] ++"\" is in the word!")
        -- reveal the letters by modifying the foundLetters word
        let newFoundLetters = zipWith createPartialWordWithContext [1..] completeWord
        if verifyWin newFoundLetters then do
            print $ "Congratulations !! You found the word " ++ 
                    newFoundLetters ++ 
                    " in " ++ 
                    show (length alreadyUsedLetters) ++ 
                    " turns!"
        else do
            findTheWordGame' newFoundLetters completeWord (letter:alreadyUsedLetters)
    else 
        findTheWordGame' foundLetters completeWord (letter:alreadyUsedLetters)

createPartialWord :: String -> String -> Char -> Int -> Char -> Char
createPartialWord completeWord oldPartialWord guessedLetter index letter =
    if getCharFromString index completeWord == guessedLetter
        then letter
    else getCharFromString index oldPartialWord

verifyWin :: String -> Bool
verifyWin word = '-' `notElem` word

-- following a certain list of words, create a random number and use it as index for selecting a number in the list
getRandomWordFromListOfWords :: [String] -> IO String
getRandomWordFromListOfWords listOfWords = do 
    randomNumber <- randomRIO (1, length (head listOfWords))
    return $ getWordFromStringList randomNumber listOfWords

-- Allow us to get the char at index n of a string
getCharFromString :: Int -> String -> Char
getCharFromString n word = last (take n word)

getWordFromStringList :: Int -> [String] -> String
getWordFromStringList n wordsList = last (take n wordsList)

-- get the filter func -- Choosing the words based on the difficulty level
getFilterFuncFromDiff :: Difficulty -> String -> Bool
getFilterFuncFromDiff Easy = \x -> length x < 5 
getFilterFuncFromDiff Medium = \x -> length x >= 5 && length x < 10
getFilterFuncFromDiff Hard = \x -> length x >= 10 

filterWordsFromDiff :: String -> Difficulty -> IO String
filterWordsFromDiff wordsPath diff = do
    wordsFile <- readFile wordsPath
    getRandomWordFromListOfWords (filter (getFilterFuncFromDiff diff) (splitOn "\n" wordsFile) )