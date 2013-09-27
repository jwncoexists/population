# add a method 'underscore' to the String class to convert strings to snake case
class String
  # add underscores after +, -, #s.  Then downcoase and convert to symbols
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

# reads in .csv file and includes methods for reading and parsing lines in the zip code data file
class CSVReader

  attr_accessor :fname, :headers, :file_text

  #/ open the data file and load the text into a variable called filetext
  def initialize(filename)
    @fname = filename
    @file_text = File.open(filename).read
    @file_text.gsub!(/\r\n?/, "\n")
  end

  # parse a delimited header line into an array of symbols
  def parse_header(header_str)
    @headers = header_str.split(',')
    @headers.map! do |h|
      h.gsub!('"','')
      h.strip!
      h.underscore.to_sym
    end
    @headers
  end


  # parse a comma delimited string & return string values in a data hash using @headers as the indices
  def parse_data_line(line_str)
    array = line_str.split(',')
    data_hash = {}
    @headers.each_with_index do |header, i|
      if (!array[i].nil?)
        data_hash[header] = array[i].strip.gsub('"', '')
      end
    end
    data_hash
  end

  # loop through text line by line, and yeilding results to calling block
  def read
    self.file_text.each_line do |next_line|
      !self.headers ? parse_header(next_line) : yield(self.parse_data_line(next_line))
    end
  end
end
