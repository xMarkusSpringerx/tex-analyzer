files = []


class WordObj

  attr_accessor :word, :type

  def initialize(word, format)
    @word = word
    @format   = format
  end


end





class FileReader

  def initialize(filepath)
    @filepath = filepath
    @words = Hash.new
    @format_constants = ['enquote', 'texttt', 'textbf', 'section', 'subsection']
  end

  def readFile

    begin
      file = File.new(@filepath, "r")


      #All words
      wordAry = splitStringInArray(file.read)

      # Clean word array
      wordAry = cleanWords(wordAry)

      wordAry.each do |word|
        puts word
      end

      file.close
    rescue => err
      puts "Exception: #{err}"
      err
    end

  end


  def formatValue text
    text = text.downcase
    text = text.strip
    return text
  end

  def splitStringInArray string
    result = []
    string.strip.split(" ").each do |word|
      result.push(word)
    end
    return result
  end

  def cleanWords wordAry

    wordAry.map! {|word|
      word.tr(',', '').tr('.', '').tr(':', '').tr(';', '')
    }
    return wordAry
  end

end

#Dir.glob('/Users/markusspringer/Hagenberg/Bachelorarbeit/hgb-thesis-neu/**/*.tex') do |item|
#  files.push(item)
#end

Dir.glob('./Analyse.tex') do |item|
  files.push(item)
end
files.each do |filepath|
  #puts filepath
  fr = FileReader.new(filepath)
  fr.readFile
end

