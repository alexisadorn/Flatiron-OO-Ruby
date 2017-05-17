require 'pry'
describe 'Transfer' do

  let(:avi) { BankAccount.new("Avi") }
  let(:amanda) { BankAccount.new("Amanda") }
  let(:transfer) { Transfer.new(amanda, avi, 50) }
  let(:bad_transfer) { Transfer.new(amanda, avi, 4000) }

  describe 'Transfer' do
    describe 'initialize' do
      it "can initialize a Transfer" do
        expect(transfer).to be_a(Transfer)
      end

      it "initializes with a sender" do
        expect(transfer.sender).to eq(amanda)
      end

      it "initializes with a receiver" do
        expect(transfer.receiver).to eq(avi)
      end

      it "always initializes with a status of 'pending'" do
        expect(transfer.status).to eq("pending")
      end

      it "initializes with a transfer amount" do
        expect(transfer.amount).to eq(50)
      end
    end

    describe '#valid?' do
      it "can check that both accounts are valid" do
        expect(avi.valid?).to eq (true)
        expect(amanda.valid?).to eq(true)
        expect(transfer.valid?).to eq(true)
      end

      it "calls on the sender and reciever's #valid? methods" do
        transfer_class = File.read("lib/transfer.rb")

        expect(amanda).to receive(:valid?).and_return(true)
        expect(avi).to receive(:valid?).and_return(true)

        transfer.valid?
      end
    end

    describe '#execute_transaction' do
      it "can execute a successful transaction between two accounts" do
        transfer.execute_transaction
        expect(amanda.balance).to eq(950)
        expect(avi.balance).to eq(1050)
        expect(transfer.status).to eq("complete")
      end

      it "each transfer can only happen once" do
        transfer.execute_transaction
        expect(amanda.balance).to eq(950)
        expect(avi.balance).to eq(1050)
        expect(transfer.status).to eq("complete")
        transfer.execute_transaction
        expect(amanda.balance).to eq(950)
        expect(avi.balance).to eq(1050)
      end

      it "rejects a transfer if the sender doesn't have a valid account" do
        expect(bad_transfer.execute_transaction).to eq("Transaction rejected. Please check your account balance.")
        expect(bad_transfer.status).to eq("rejected")
      end
    end

    describe '#reverse_transfer' do
      it "can reverse a transfer between two accounts" do
        transfer.execute_transaction
        expect(amanda.balance).to eq(950)
        expect(avi.balance).to eq(1050)
        transfer.reverse_transfer
        expect(avi.balance).to eq(1000)
        expect(amanda.balance).to eq(1000)
        expect(transfer.status).to eq("reversed")
      end

      it "it can only reverse executed transfers" do
        transfer.reverse_transfer
        expect(amanda.balance).to eq(1000)
        expect(avi.balance).to eq(1000)
      end
    end
  end
end
