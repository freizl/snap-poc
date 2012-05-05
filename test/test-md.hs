module Main where

import Text.Pandoc
import Text.Pandoc.Shared (tabFilter)

main = print $ writeDoc . readDoc $ tabFilter4 content2

readDoc :: String -> Pandoc
readDoc = readMarkdown $ defaultParserState

writeDoc :: Pandoc -> String
writeDoc = writeHtmlString defaultWriterOptions

content :: String
content = "##test abc da  \n\n- one\n- two\n\n"

content2 = "#eee\r\n\r\n - aa\r\n - bb"

tabFilter4 = tabFilter 4
