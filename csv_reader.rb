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

# class CSVReader includes method for processing lines in the zip code file
class CSVReader

  attr_accessor :fname, :headers, :fileobj

  def initialize(filename)
    @fname = filename
    @fileobj = File.new(filename,'r')
  end

  # parse a delimited header line into an array of symbols
  def headers=(header_str)
    # convert to an array, remove the quotes & newline, then convert to symbols
    @headers = header_str.split(',')
    @headers.map! do |h|
      
      # remove quotes & leading/trailing whitespace
      h.gsub!('"','')
      h.strip!
      
      # do more formatting and convert to symbols
      h.underscore.to_sym
    end
    @headers
  end

  # parse a comma delimited string & return values in a data hash using @headers
  def line=(line_str)
    array = line_str.split(',')
    data_hash = {}
    @headers.each_with_index do |header, i|
      if (!array[i].nil?)
        data_hash[header] = array[i].strip.gsub('"', '')
      end
    end
    data_hash
  end

  # loop through file, reading lines, and yeilding results to calling block
  def read
    # read the header line and setup the headers hash
    self.headers=(fileobj.readline)

    # read remainder of the file
    while(!fileobj.eof? && next_line = fileobj.readline)
      yield(self.line=(next_line))
    end
  end
end
