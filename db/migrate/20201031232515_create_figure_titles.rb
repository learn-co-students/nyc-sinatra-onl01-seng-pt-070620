class CreateFigureTitles < ActiveRecord::Migration
  def change
    create_table :figure_titles do |t|
      t.string :title_id
      t.string :figure_id
    end 
  end
end
