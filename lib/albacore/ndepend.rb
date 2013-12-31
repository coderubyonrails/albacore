require "albacore/albacoretask"
require "albacore/config/ndependconfig"

class NDepend
  TaskName = :ndepend

  include Albacore::Task
  include Albacore::RunCommand
  include Configuration::NDepend

  attr_accessor :project_file

  def initialize()
    super()
    update_attributes(ndepend.to_hash)
  end
  
  def execute
    unless @project_file
      fail_with_message("ndepend requires #project_file")
      return
    end
    
    result = run_command(@command, build_parameters)
    fail_with_message("NDepend failed, see the build log for more details.") unless result
  end

  def build_parameters
    p = []
    p << "\"#{File.expand_path(@project_file)}\""
    p
  end
end
