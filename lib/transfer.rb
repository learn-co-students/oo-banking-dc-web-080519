require 'pry'

class Transfer
  attr_reader :sender, :receiver 
  attr_accessor :amount, :status
  @@last_transaction = []
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.valid? && !@@last_transaction.include?(self)
      if self.sender.balance > self.amount
        self.sender.balance -= self.amount
        self.receiver.balance += self.amount
        self.status = "complete"
        @@last_transaction << self 
      else
        self.status = "rejected"
      "Transaction rejected. Please check your account balance." 
      end
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance." 
    end
  end

  def reverse_transfer
    reverse_recipient = @@last_transaction.last.sender 
    reverse_sender = @@last_transaction.last.receiver
    reverse_amount = @@last_transaction.last.amount
    reverse_recipient.balance += reverse_amount
    reverse_sender.balance -= reverse_amount
    @@last_transaction.last.status = "reversed"
  end

end
