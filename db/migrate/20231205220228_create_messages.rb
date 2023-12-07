class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|

      t.string :body
      t.string :key   #que sea tipo string permite el uso de métodos como "key.length"
      t.boolean :encrypted, default: false
    end
  end
end
