module Alert
  attr_accessor :text, :date

  def sent?
    @sent
  end

  def mark_sent
    @sent = true
  end
end
