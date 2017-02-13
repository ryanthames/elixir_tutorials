alias WordClouds.WordCounter
alias WordClouds.WordleNetFormatter
alias WordClouds.FileConcatenator

System.argv
|> hd
|> Path.wildcard
|> FileConcatenator.concatenate
|> WordCounter.count
|> WordleNetFormatter.output
|> IO.puts
