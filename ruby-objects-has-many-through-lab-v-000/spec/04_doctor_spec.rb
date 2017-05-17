require "spec_helper"

describe "Doctor" do 

  describe "#new" do 
    it "initializes with a name and an empty collection of appointments" do
      doctor_smith = Doctor.new("John Smith")
      expect{ Doctor.new("Martha Jones")}.to_not raise_error
      expect(doctor_smith.instance_variable_get(:@appointments)).to eq([])
    end
  end

  describe "#name" do 
    it "has a name" do 
      doctor_who = Doctor.new("The Doctor")
      expect(doctor_who.name).to eq("The Doctor")
    end
  end

  describe "#add_appointment" do 
    it "adds a new appointment to the doctor's @appointments array and tells that appointment that it belongs to the doctor" do 
      doctor_who = Doctor.new("The Doctor")
      appointment = Appointment.new("Friday, January 32nd", doctor_who)
      doctor_who.add_appointment(appointment)

      expect(doctor_who.instance_variable_get(:@appointments)).to include(appointment)
      expect(appointment.doctor).to eq(doctor_who)
    end
  end

  describe "#appointments" do 
    it "has many appointments" do
      doctor_who = Doctor.new("The Doctor")
      appointment = Appointment.new("Friday, January 32nd", doctor_who)
      doctor_who.add_appointment(appointment)

      expect(doctor_who.appointments).to include(appointment)
    end
  end

  describe "#patients" do 
    it "has many patients, through appointments" do
      doctor_who = Doctor.new("The Doctor")
      appointment = Appointment.new("Friday, January 32nd", doctor_who)
      martin = Patient.new("Martin Jones")
      martin.add_appointment(appointment)
      
      doctor_who.add_appointment(appointment)
      expect(doctor_who.patients).to include(martin)
    end
  end
end
