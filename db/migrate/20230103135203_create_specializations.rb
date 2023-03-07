# frozen_string_literal: true

class CreateSpecializations < ActiveRecord::Migration[7.0]
  def change
    create_table :specializations do |t|
      t.belongs_to :doctor
      t.belongs_to :category

      t.timestamps
    end
  end
end
