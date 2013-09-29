# Array of area instances with info from the zip code file
# @options is a hash array of menu options
require_relative 'area'

class String
   def currency_format()
      while self.sub!(/(\d+)(\d\d\d)/,'\1,\2'); end
      self
   end
end

class Analytics

  attr_accessor :options, :areas, :exitid

  def initialize(areas)
    @areas = areas
    set_options
  end

  def set_options
    @options = []
    @options << { :menu_id => 1, :menu_title => 'Areas count', :method => :how_many }
    @options << { :menu_id => 2, :menu_title => 'Smallest Population (non 0)', :method => :smallest_pop }
    @options << { :menu_id => 3, :menu_title => 'Largest Population', :method => :largest_pop }
    @options << { :menu_id => 4, :menu_title => 'Highest Wages', :method => :highest_wages }
    @options << { :menu_id => 5, :menu_title => 'Lowest Wages', :method => :lowest_wages }
    @options << { :menu_id => 6, :menu_title => 'How many zips in California?', :method => :california_zips }
    @options << { :menu_id => 7, :menu_title => 'Information for a given zip', :method => :zip_info }
    @options << { :menu_id => 8, :menu_title => 'Exit', :method => :exit }
    @exitid = @options.last[:menu_id]
  end

  def run(choice)
    opt = @options.select { |o| o[:menu_id] == choice }.first
    if (opt.nil?)
      p "Invalid choice: #{choice}"
    elsif (choice != @exitid)
      self.send opt[:method]
    else
      opt[:method]
    end
  end

  def how_many
    p "There are #{@areas.length} areas in the zip code file"
  end

  def smallest_pop
    sorted = @areas.sort { |x,y| x.estimated_population <=> y.estimated_population }
    # find the first, none-zero population
    smallest = sorted.drop_while { |i| i.estimated_population == 0 }.first
    p "#{smallest.city}, #{smallest.state} #{smallest.zipcode} has the smallest estimated population of: #{smallest.estimated_population}"
  end

  def largest_pop
    sorted = @areas.sort { |x,y| y.estimated_population <=> x.estimated_population }
    largest = sorted.first
    p "#{largest.city}, #{largest.state} #{largest.zipcode} has the largest estimated population of: #{largest.estimated_population}"
  end

  def lowest_wages
    sorted = @areas.sort { |x,y| x.total_wages <=> y.total_wages }
    smallest = sorted.drop_while { |i| i.total_wages == 0 }.first
    wages = smallest.total_wages.to_s.currency_format
    p "#{smallest.city}, #{smallest.state} #{smallest.zipcode} has the lowest total wages of: $ #{wages}"
  end

  def highest_wages
    sorted = @areas.sort { |x,y| y.total_wages <=> x.total_wages }
    largest = sorted.first
    wages = largest.total_wages.to_s.currency_format
    p "#{largest.city}, #{largest.state} #{largest.zipcode} has the highest total wages of: $ #{wages}"
  end

  def california_zips
    c = @areas.count { |a| a.state == "CA"}
    p "California has a total of: #{c} zip codes"
  end

  def zip_info
    print "Enter a zip code: "
    zip = gets.strip.to_i
    ziplist = @areas.select { |a| a.zipcode == zip }
    unless ziplist.empty?
      p ""
      ziplist.each { |z| p z }
    else
      p "Zip code: #{zip} not found"
    end
  end
end