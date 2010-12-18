class MetalApplicationController < ActionController::Metal
  ## removes all public methods from :actions
  ## not really needed in this case, but carlhuda advices
  ## it as good habit and he's the man
  abstract!
end
