class UserPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers
  delegate :content_tag, :link_to, to: :helpers

  def new_product_link
    return '' unless admin?

    helpers.content_tag(:li) do
      link_to 'Novo Produto', new_product_path
    end
  end

  private
  def helpers
    ApplicationController.helpers
  end

end