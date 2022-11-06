module Actions where
-- Additional IO Actions functions are gonna be here.
-- verify if the letter is part of the word
askDifficultyLevel :: IO String
askDifficultyLevel = askDifficultyLevel' False
    

askDifficultyLevel' :: Bool -> IO String
askDifficultyLevel' b = do
        
        let errorMessage = "Invalid Option. valid options are 1, 2 or 3.\n"
        let message = "Choose the difficulty level : \n write 1 for easy, 2 for medium, 3 for hard."
        
        if b == True then do
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