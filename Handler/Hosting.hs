module Handler.Hosting where

import Data.Conduit
import Data.Conduit.Binary
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
            filebytes <- runResourceT $ fileSource fi $$ sinkLbs
            addFile app $ StoredFile (fileName fi) (fileContentType fi) filebytes
        _ -> return ()
    redirect HostingR

uploadForm = renderDivs $ fileAFormReq "file"
