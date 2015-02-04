module Handler.Preview where

import qualified Control.Exception as Ex hiding (Handler)
import qualified Data.ByteString.Lazy as LB
import Data.Default
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.Lazy as LT
import qualified Data.Text.Lazy.Encoding as LT
import Text.Blaze
import Yesod
import Yesod.Default.Util

import Import

getPreviewR :: Int -> Handler Html
getPreviewR ident = do
    StoredFile file _ bytes <- getById ident
    defaultLayout $ do
        setTitle . toMarkup $ "File Processor - " `Text.append` file
        previewBlock <- liftIO $ preview bytes
        $(widgetFileNoReload def "preview")

preview :: LB.ByteString -> IO Widget
preview bytes = do
    eText <- Ex.try . Ex.evaluate $ LT.decodeUtf8 bytes :: IO (Either Ex.SomeException LT.Text)
    return $ case eText of
        Left _ -> errorMessage
        Right text -> [whamlet|<pre>#{text}|]
    where
        errorMessage = [whamlet|<pre>Unable to display file contents.|]
