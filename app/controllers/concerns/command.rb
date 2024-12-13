module Command
  extend ActiveSupport::Concern
  included do
    def command(action:)
      param_values = permitted_params_for(name: current_model_name, action: action)
      cmd = command_class(name: current_model_name, action: action)
      cmd.new(param_values.to_hash.symbolize_keys)
    end
  end
end
