class ApplicationController < ActionController::Base
  include RenderJavascriptResponse
  include HtmlTagHelper
  protect_from_forgery with: :exception
end
