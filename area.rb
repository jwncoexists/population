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
    @latitude = hash[:long].to_f || 0.0
  end
end