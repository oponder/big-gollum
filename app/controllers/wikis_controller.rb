class WikisController < InheritedResources::Base
  def create
    @wiki = Wiki.new(params[:wiki])
    @wiki.add_member(current_user)
    create! do |success, failure|
      success.html {
        WikiInitializer.create_wiki(@wiki)
        flash[:notice] = "Dude! Nice job creating that wiki."
        redirect_to root_url
      }

      failure.html {
        flash[:notice] = "Could not create wiki."
        render :new
      }
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    old_name = @wiki.name
    @wiki.name = params[:wiki][:name]
    @wiki.save

    old_path = Rails.root.join('wikis', old_name)
    new_path = Rails.root.join('wikis', @wiki.name)

    `mv "#{old_path}" "#{new_path}"`

    redirect_to root_url and return
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    `rm -rf "#{Rails.root.to_s + '/wikis/' + @wiki.name}"`
    destroy!(:notice => "Wiki has been destroyed :(") { root_url }
  end
end