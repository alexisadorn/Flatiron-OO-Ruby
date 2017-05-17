require "spec_helper"

describe "Patient" do
  let!(:martin) { Patient.new("Martin Jones") } 
  let!(:doctor_who) { Doctor.new("The Doctor") }
  let!(:appointment) { Appointment.new("Friday, January 32nd", doctor_who) }

  describe "#new" do 
    it "initializes with a name" do 
      expect{Patient.new("Sophie")}.to_not raise_error
    end
  end

  describe "#add_appointment" do
    it "takes in an argument of an apppointment and adds that appointment to it's list of appointments and tells that appointment it belongs to the patient" do 
      martin.add_appointment(appointment)
      expect(martin.appointments).to include(appointment)
      expect(appointment.patient).to eq(martin)
    end 
  end

  describe "#doctors" do 
    it "has many doctors through appointments" do 
      martin.add_appointment(appointment)
      expect(martin.doctors).to include(doctor_who)
    end
  end
end