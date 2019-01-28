module EnumHelper
  def enum(e)
    if e == 'unavailable'
      'Indisponível'
    elsif e == 'available'
      'Disponível'
    else
      'erro'
    end
  end
end
