class SearchPostsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  # フォームと関連付けするための属性。ActiveModel::Attributesがあるから設定できる。
  attribute :address_or_body, :string

  def search
    scope = Post.distinct
    scope = scope.address_contain(address_or_body).or(scope.body_contain(address_or_body)) if address_or_body.present?
    scope
  end
end
