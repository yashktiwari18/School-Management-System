module ActivityLogger
  extend ActiveSupport::Concern

  def log_activity(action:, module_name:, description:)
    ActivityLog.create!(
      admin: current_admin,
      action: action,
      module_name: module_name,
      description: description
    )
  end
end
