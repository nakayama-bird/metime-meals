class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.human_attribute_enum_value(attr_name, value) # クラスメソッド
    return if value.blank?
    human_attribute_name("#{attr_name}.#{value}")
  end

  def human_attribute_enum(attr_name) # インスタンスメソッド。カラム名を引数として受け取る。
    self.class.human_attribute_enum_value(attr_name, self.send("#{attr_name}"))
    # 任意のクラスでhuman_attribute_enum_valueメソッドを呼び出す。
  end
end
