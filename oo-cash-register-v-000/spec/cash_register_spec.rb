describe 'CashRegister' do
  let(:cash_register) { CashRegister.new }
  let(:cash_register_with_discount) { CashRegister.new(20) }

  describe '::new' do
    it 'sets an instance variable @total on initialization to zero' do
      expect(cash_register.instance_variable_get(:@total)).to eq(0)
    end

    it 'optionally takes an employee discount on initialization' do
      expect(cash_register_with_discount.discount).to eq(20)
    end
  end

  describe '#total' do
    it 'returns the current total' do
      cash_register.total = 100
      expect(cash_register.total).to eq(100)
    end
  end

  describe '#add_item' do
    it 'accepts a title and a price and increases the total' do
      expect{cash_register.add_item("eggs", 0.98)}.to change{cash_register.total}.by(0.98)
    end

    it 'also accepts an optional quantity' do
      expect{cash_register.add_item("book", 5.00, 3)}.to change{cash_register.total}.by(15.00)
    end

    it "doesn't forget about the previous total" do
      cash_register.add_item("Lucky Charms", 4.5)
      expect(cash_register.total).to eq(4.5)
      cash_register.add_item("Ritz Crackers", 5.0)
      expect(cash_register.total).to eq(9.5)
      cash_register.add_item("Justin's Peanut Butter Cups", 2.50, 2)
      expect(cash_register.total).to eq(14.5)
    end
  end

  describe '#apply_discount' do
    context 'the cash register was initialized with an employee discount' do
      it 'applies the discount to the total price' do
        cash_register_with_discount.add_item("macbook air", 1000)
        cash_register_with_discount.apply_discount
        expect(cash_register_with_discount.total).to eq(800)
      end

      it 'returns success message with updated total' do
        cash_register_with_discount.add_item("macbook air", 1000)
        expect(cash_register_with_discount.apply_discount).to eq("After the discount, the total comes to $800.")
      end

      it 'reduces the total' do
        cash_register.total = 0
        cash_register_with_discount.add_item("macbook air", 1000)
        expect{cash_register_with_discount.apply_discount}.to change{cash_register_with_discount.total}.by(-200)
      end
    end

    context 'the cash register was not initialized with an employee discount' do
      it 'returns a string error message that there is no discount to apply' do
        expect(cash_register.apply_discount).to eq("There is no discount to apply.")
      end
    end
  end

  describe '#items' do
    it 'returns an array containing all items that have been added' do
      new_register = CashRegister.new
      new_register.add_item("eggs", 1.99)
      new_register.add_item("tomato", 1.76, 3)
      expect(new_register.items).to eq(["eggs", "tomato", "tomato", "tomato"])
    end
  end

  describe '#void_last_transaction' do
    it 'subtracts the last transaction from the total' do
      cash_register.add_item("tomato", 1.76)
      expect{cash_register.void_last_transaction}.to change{cash_register.total}.from(1.76).to(0.0)
    end
  end
end
