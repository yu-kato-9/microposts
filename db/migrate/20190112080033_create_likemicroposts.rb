class CreateLikemicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :likemicroposts do |t|
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true

      t.timestamps
    end
  end
end
