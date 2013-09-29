require_relative 'lib/setup'
require_relative 'lib/analytics'

# loads in the zip code file, and instantiates a text menu for displaying statistics about data in the file
class Population
  attr_accessor :analytics

  def initialize
    areas = Setup.new().areas
    @analytics = Analytics.new(areas)
  end

  def show_menu
    p ""
    p "Population Menu"
    p "---------------"
    @analytics.options.each do |opt|
      p "#{opt[:menu_id]}. #{opt[:menu_title]}"
    end
  end

  def run
    choice = nil
    while (choice != @analytics.exitid)
      self.show_menu
      p 'Enter Choice:'
      choice = gets.chomp.to_i
      @analytics.run(choice)
    end
  end
end

p = Population.new
p.run
