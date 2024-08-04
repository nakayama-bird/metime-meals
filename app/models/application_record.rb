class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # クラスメソッド
  def self.human_attribute_enum_value(attr_name, value)
    return if value.blank?

    human_attribute_name("#{attr_name}.#{value}")
  end

  # インスタンスメソッド。カラム名を引数として受け取る。
  def human_attribute_enum(attr_name)
    self.class.human_attribute_enum_value(attr_name, send(attr_name.to_s))
    # 任意のクラスでhuman_attribute_enum_valueメソッドを呼び出す。
  end

  # 入力時プルダウンで表示する際の設定
  def self.enum_options_for_select(attr_name)
    send(attr_name.to_s.pluralize).map { |k, _| [human_attribute_enum_value(attr_name, k), k] }.to_h
  end
end
