require_relative 'csv_reader'
require_relative 'area'

# read in the zip code file, store data in the @areas array
class Setup

  attr_accessor :areas

  def initialize
    csv = CSVReader.new("./free-zipcode-database.csv")
    @areas = []  
    csv.read do |item|
      areas << Area.new(item) 
    end
  end
end