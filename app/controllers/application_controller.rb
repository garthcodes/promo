class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # This method is necessary to show validation errors on forms
  def render_with_turbolinks(*options, &block)
    html = render_to_string(*options, &block)

    script = <<-SCRIPT
      (function(){
        Turbolinks.clearCache();
        var doc = document.implementation.createHTMLDocument('response');
        doc.documentElement.innerHTML = "#{ActionController::Base.helpers.j(html)}";
        document.documentElement.replaceChild(doc.body, document.body);
        Turbolinks.dispatch('turbolinks:load');
        window.scroll(0, 0);
      })();
    SCRIPT

    self.status = 200
    self.response_body = script
    response.content_type = 'text/javascript'
  end
end
