require './lib/bank_account.rb'
require 'pry'
class Transfer
    attr_accessor :status, :sender, :receiver, :amount
    
    def initialize(sender, receiver, amount)
        @sender = sender 
        @receiver = receiver
        @status = 'pending'
        @amount = amount 
    end 

    def valid?
        self.sender.valid? && self.receiver.valid? && self.amount <= self.sender.balance
    end 

    def execute_transaction
        # binding.pry
        if self.status == 'pending' && self.valid?
            self.sender.balance -= amount 
            self.receiver.balance += amount 
            self.status = 'complete'
            # binding.pry
        else 
            self.status = 'rejected'
            "Transaction rejected. Please check your account balance."   
        end
    end 

    def reverse_transfer 
        if self.status == 'complete'
            self.sender.balance += amount 
            self.receiver.balance -= amount
            self.status = 'reversed'
        end 
    end 
end

# avi = BankAccount.new("Avi") 
# amanda = BankAccount.new("Amanda") 
# transfer = Transfer.new(amanda, avi, 50) 
# bad_transfer = Transfer.new(amanda, avi, 4000) 

# puts transfer.execute_transaction

# puts bad_transfer.execute_transaction
# puts avi.balance
# puts amanda.balance