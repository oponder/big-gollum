class WikiMounter
  Gollum::GIT_ADAPTER = "rugged"
  require 'rubygems'
  require 'gollum/app'

  def self.call(env)
    wikis_root = "wikis/"
    wiki_name = env["action_dispatch.request.path_parameters"][:wiki]
    wiki_path = wikis_root + wiki_name
    mount_path = "/wiki/" + wiki_name

    gollums ||= {}
    gollums[:wiki_name] ||= MapGollum.new(wiki_path, mount_path)
    gollums[:wiki_name].call(env)
  end

end


class MapGollum
  def initialize(base_path, mount_path)
    @mg = Rack::Builder.new do

      gollum_path = File.expand_path(base_path)
      wiki_options = { universal_toc: false,
                       live_preview: false,
                       template_dir: './lib/wiki_mounter/templates/'
                     }
      Precious::App.set(:gollum_path, gollum_path)
      Precious::App.set(:default_markup, :markdown)
      Precious::App.set(:wiki_options, wiki_options)

      map '/' do
        run Proc.new { [302, { 'Location' => "http://localhost:3000#{mount_path}" }, []] }
        # run Precious::App
      end

      map mount_path do
        run Precious::App
      end
    end
  end

  def call(env)
    @mg.call(env)
  end
end

class Precious::App
  before do
    session['gollum.author'] = {
      :name => "%s %s" % [env['warden'].user.first_name, env['warden'].user.last_name],
      :email => "%s" % env['warden'].user.email,
    }
  end
end


# wikis_root = "wikis/"
# wiki_name = env["action_dispatch.request.path_parameters"][:wiki]
# wiki_path = wikis_root + wiki_name

# @@mount_point = "/wiki/" + wiki_name
# load Rails.root + 'lib/gollum/lib/gollum/frontend/app.rb'
# Precious::App.set(:gollum_path, wiki_path)
# Precious::App.set(:wiki_options, {})
# if env['warden'].user && env['warden'].user.wikis.include?(Wiki.find_by_name(wiki_name))
#   Precious::App.call(env)
# else
#   [404, {}, []]
# end
