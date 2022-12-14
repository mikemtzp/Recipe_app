require 'rails_helper'

RSpec.describe 'recipes/show', type: :view do
  before(:each) do
    @recipe = assign(:recipe, Recipe.create!(
                                name: 'Name',
                                preparatrion_time: 2,
                                cooking_time: 3,
                                description: 'Description',
                                public: false,
                                user: nil
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
