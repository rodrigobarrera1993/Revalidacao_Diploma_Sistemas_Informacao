class ApplicationController < ActionController::Base
layout :layout_by_resource

private

#render the correct layout
def layout_by_resource
    if devise_controller? && resource_class == Pilot
        "pilot_devise"
    elsif devise_controller? && resource_class == Operator
        "operator_devise"
    else
        "application"
    end
end

end
