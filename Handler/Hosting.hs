module Handler.Hosting where

import Data.Default
import Yesod
import Yesod.Default.Util
import Import

getHostingR :: Handler Html
getHostingR = do
    files <- getFiles
    defaultLayout $ do
        setTitle "File Processor"
        $(widgetFileNoReload def "hosting")
