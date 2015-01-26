module Handler.Hosting where

import Data.Default
import Yesod
import Yesod.Default.Util
import Import

getHostingR :: Handler Html
getHostingR = do
    filenames <- getFilenames
    defaultLayout $ do
        setTitle "File Processor"
        $(widgetFileNoReload def "hosting")
