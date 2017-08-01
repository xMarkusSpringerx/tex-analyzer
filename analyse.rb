files = []


class FileReader


  def initialize(filepath)
    @filepath = filepath
    @words = Hash.new
    @format_constants = ['enquote', 'texttt', 'textbf', 'section', 'subsection']

  end

  def readFile

    begin
      file = File.new(@filepath, "r")

      matches = file.read.scan(/\\\w+{\w+}/)

      matches.each do |match|

        text = match.scan(/\w*}/).first.chop

        format = match.scan(/\w*{/).first.chop


        originalText = text

        text = formatValue(text)


        if @format_constants.include? format
          puts text + ": " + format
          if (@words[text])
            # Already exists --> check, how it's written

            if addToHash(text, originalText)
              @words[text][originalText] += 1
            else
              @words[text][originalText] = 1
            end

          else
            @words[text] = {}
            @words[text][originalText] = 1

          end

        end


      end

      file.close
    rescue => err
      puts "Exception: #{err}"
      err
    end

  end

  def addToHash text, originalText
    @words[text].each do |spelling, key|
      if spelling == originalText
        result = false
        return result
      end
    end

    return true
  end

  def formatValue text
    text = text.downcase
    text = text.strip
    return text
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

