require 'fileutils'

module ManageIQ
module ApplianceConsole
  class DatabaseMaintenance
    include ManageIQ::ApplianceConsole::Logging

    attr_accessor :hourly, :executed_hourly_action, :requested_hourly_action
    attr_accessor :periodic, :executed_periodic_action, :requested_periodic_action

    def initialize
      self.hourly   = ManageIQ::ApplianceConsole::DatabaseMaintenanceHourly.new
      self.periodic = ManageIQ::ApplianceConsole::DatabaseMaintenancePeriodic.new
      self.requested_hourly_action = false
      self.requested_periodic_action = false
      self.executed_hourly_action = false
      self.executed_periodic_action = false
    end

    def ask_questions
      clear_screen
      self.requested_hourly_action = hourly.confirm
      self.requested_periodic_action = periodic.confirm
      requested_hourly_action || requested_periodic_action
    end

    def activate
      say("Configuring Database Maintenance...")
      self.executed_hourly_action = hourly.activate
      self.executed_periodic_action = periodic.activate
      executed_hourly_action || executed_periodic_action
    end
  end # class DatabaseMaintenance < DatabaseConfiguration
end # module ApplianceConsole
end
