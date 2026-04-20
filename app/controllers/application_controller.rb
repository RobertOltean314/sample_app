class ApplicationController < ActionController::Base
  def hello
    render html: 'Hello Lume'
  end
end
