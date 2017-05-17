require "spec_helper"

describe "Appointment" do
  
  describe "#new" do 
    it "initializes with a date and a doctor" do 
      doctor_who = Doctor.new("The Doctor")
      expect{Appointment.new("Thursday, October 31st", doctor_who)}.to_not raise_error
    end
  end

  describe "#patient" do
    it "belongs to a patient" do 
      doctor_who = Doctor.new("The Doctor")
      appointment = Appointment.new("Friday, January 32nd", doctor_who)
      martin = Patient.new("Martin Jones")
      appointment.patient = martin
      expect(appointment.patient).to eq(martin)
    end 
  end

  describe "#doctor" do 
    it "belongs to a doctor" do 
      doctor_who = Doctor.new("The Doctor")
      appointment = Appointment.new("Friday, January 32nd", doctor_who)
      expect(appointment.doctor).to eq(doctor_who)
      expect(doctor_who.appointments).to include(appointment)
    end
  end
end