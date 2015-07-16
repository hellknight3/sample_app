module ActivitiesHelper
    def isProfile?(string)
      string == "Admin" || string == "Doctor" || string == "Patient"
    end
end
