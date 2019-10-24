
class Journey
PENALTY_FARE = 6

  def complete?
    @complete
  end

  def fare
    PENALTY_FARE
  end

  def finish(station)
    self
  end
  
end
