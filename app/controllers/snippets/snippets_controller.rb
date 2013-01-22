require_dependency "snippets/application_controller"

module Snippets
  class SnippetsController < ApplicationController
    before_filter :load_snippet

    def edit
    end

    def update
      if @snippet.update_attributes(params[:snippet])
        redirect_to edit_snippet_url(@snippet), :notice => 'Snippet updated.'
      else
        render :action => 'edit'
      end
    end

    private
    def load_snippet
      snippet = Snippet.find(params[:id])

      if params[:version]
        @snippet = snippet.versions[params[:version].to_i].reify
      else
        @snippet = snippet
      end
    end
  end
end
