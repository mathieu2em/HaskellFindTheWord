module Actions where

-- Additional IO Actions functions are gonna be here.
-- verify if the letter is part of the word
askDifficultyLevel :: IO String
askDifficultyLevel = askDifficultyLevel' False
    
-- ask the level of difficulty to the user
askDifficultyLevel' :: Bool -> IO String
askDifficultyLevel' b = do
        
        let errorMessage = "Invalid Option. valid options are 1, 2 or 3.\n"
        let message = "Choose the difficulty level : \n write 1 for easy, 2 for medium, 3 for hard."
        
        if b then do
            putStrLn (errorMessage ++ message)
        else do
            putStrLn message
        
        diffLevel <- getLine
        if length diffLevel == 1 then
            if diffLevel == "1" then do return "easy"
            else if diffLevel == "2" then do return "medium"
            else if diffLevel == "3" then do return "hard"
            else do
                askDifficultyLevel' True
        else do
            askDifficultyLevel' True

guessLetter :: IO Char
guessLetter = do 
    putStrLn "Enter a letter to guess the word"
    head <$> getLine
    -- TODO validate length and ask again as long as needed

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
        findTheWordGame' newFoundLetters completeWord (letter:alreadyUsedLetters)
    else 
        findTheWordGame' foundLetters completeWord (letter:alreadyUsedLetters)

createPartialWord :: String -> String -> Char -> Int -> Char -> Char
createPartialWord completeWord oldPartialWord guessedLetter index letter =
    if getCharFromString index completeWord == guessedLetter 
        then letter 
    else getCharFromString index oldPartialWord

-- Allow us to get the char at index n of a string
getCharFromString :: Int -> String -> Char
getCharFromString n word = last (take n word)