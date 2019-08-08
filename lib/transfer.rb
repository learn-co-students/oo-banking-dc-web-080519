class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end


  def valid?
    self.sender.valid? && self.receiver.valid? && self.sender.balance >= self.amount
  end

  def execute_transaction
    if !self.valid?
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    elsif self.status == "pending"
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      self.status = "complete"
    end
  end

  def reverse_transfer
    # ensure status is complete
    if self.status == "complete"
      # if so, exchange balance
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount
      # change status to reversed
      self.status = "reversed"
    end
  end
end
