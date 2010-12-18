module Imp

  module HelperMethods

    module ApplicationHelper

      def show_routes
        (Rails::Engine::Railties.engines + [Wc::Application]).map do |app|
          show_route_entries(app)
        end.join("<br/>".html_safe).html_safe
      end

      ## convenience helper, prints a clickable routing table 
      def show_route_entries(owner)
        klass = owner.class.to_s rescue nil
        klass = "Wc::Application" if !klass || klass == "Class"
        r = ["<pre>"]
        r << "<b>#{klass} Routes</b>"
        owner.routes.routes.sort{|a,b| a.path <=> b.path}.each do |route|
          next if route.path =~ %r{/rails/info/properties}
          trg = route.path.to_s.gsub(/\(.*\)/, "")
          if !klass.nil? && klass != "Wc::Application"
            trg = File.join('/', klass.split("::").first.downcase, trg)
          end
          to = (route.requirements.blank?)?"{:to => '#{route.name.capitalize}'}":(route.requirements.inspect)
          r << ":path => #{link_to(trg.ljust(25), trg)} :defaults => #{to} "
        end unless owner.routes.routes.blank?
        r << "</pre>"
        r
      end

    end

  end
  
end