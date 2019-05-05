class WorkspaceBuilder

  def initialize(params)
    @workspace = Workspace.new
    @params = params
    build
  end

  def build
    set_label(self.params[:label])
    set_description(self.params[:description])
    set_context(self.params[:context])
    set_public(self.params[:public])
  end

  attr_reader :workspace, :params

  def workspace
    @workspace
  end

  def set_label(label)
    validate_presence!("Label", label)
    validate_minimum_length!("Label", label)
    @workspace.label = label
  end

  def set_description(description)
    validate_both_length!("Description", description)
    @workspace.description = description
  end

  def set_context(context)
    @workspace.context = context
  end

  def set_public(public)
    validate_boolean_type!("Public", public)
    @workspace.public = public
  end

  def set_default_project(workspace_id)
    Project.new({
      title: "General",
      description: "Default project for this workspace",
      workspace_id: workspace_id
    })
  end

  private

  def validate_presence!(attr_name, attr_value)
    raise ArgumentError, "#{attr_name} is required and can't be blank" if attr_value.nil?
  end

  def validate_minimum_length!(attr_name, attr_value)
    raise ArgumentError, "#{attr_name} is too short. It must have a least 3 characters" unless attr_value.length > 2
  end
  
  def validate_both_length!(attr_name, attr_value)
    return if attr_value.nil?
    raise ArgumentError, "#{attr_name} is too short. It must have a least 15 characters" unless attr_value.length > 14
    raise ArgumentError, "#{attr_name} is too long. It can't have more than 256 characters" unless attr_value.length < 257
  end

  def validate_boolean_type!(attr_name, attr_value)
    raise ArgumentError, "#{attr_name} must be a boolean" unless ["true", "false"].include?(attr_value.to_s)
  end
end
