require 'pry'
class Transfer
  
  attr_reader :sender, :receiver
  attr_accessor :status, :amount
  @@transfer = []
  
  def initialize(sender, receiver, new_money)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = new_money
    
    
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end
  
  
  def execute_transaction
    if self.status != "complete" && self.sender.balance > self.amount && self.valid?
        self.sender.balance -= self.amount
        self.receiver.balance += self.amount
        self.status = "complete"
    else
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  
            
       
  end
            
          
  def reverse_transfer
    if self.status == "complete" 
      self.receiver.balance -= self.amount
      self.sender.balance += self.amount
      self.status = "reversed"
    end
  end


      
  








end
