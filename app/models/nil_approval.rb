class NilApproval

  def nil?
    true
  end

  def persisted
    false
  end

  def user
    NilUser.new
  end
end
