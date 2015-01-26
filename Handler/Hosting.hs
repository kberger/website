module Handler.Hosting where

import Data.Default
import Yesod
import Yesod.Default.Util
import Import

getHostingR :: Handler Html
getHostingR = do
    (formWidget, formEncType) <- generateFormPost uploadForm
    files <- getFiles
    defaultLayout $ do
        setTitle "File Processor"
        $(widgetFileNoReload def "hosting")

postHostingR :: Handler Html
postHostingR = do
    ((result, _), _) <- runFormPost uploadForm
    case result of
        FormSuccess fi -> do
            app <- getYesod
            addFile app $ fileName fi
        _ -> return ()
    redirect HostingR

uploadForm = renderDivs $ fileAFormReq "file"
