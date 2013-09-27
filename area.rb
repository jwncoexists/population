# Setup a hash to keep track of the important data from the zip code file to be analyzed later
class Area

  attr_accessor :zipcode, :city, :state, :estimated_population, :total_wages, :tax_returns_filed
  attr_accessor :latitude, :longitude

  def initialize(hash)
    @zip_code = hash[:zipcode].to_i || 0
    @city = hash[:city] || "n/a"
    @state = hash[:state] || "n/a"
    @estimated_population = hash[:estimated_population].to_i || 0
    @total_wages = hash[:total_wages].to_i || 0
    @tax_returns_filed = hash[:tax_returns_filed].to_i || 0
    @latitude = hash[:lat].to_f || 0.0
    @longtude = hash[:long].to_f || 0.0
  end

  def to_s
    "#{self.city}, #{self.state} #{self.zipcode} has #{self.estimated_population} people who collectively earn $#{self.total_wages}."
  end
end