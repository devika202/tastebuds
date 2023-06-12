require 'rails_helper'

RSpec.describe 'layouts/_footer.html.erb', type: :view do
  it 'displays the footer' do
    render

    expect(rendered).to have_selector('footer#sticky-footer')
    expect(rendered).to have_selector('footer.flex-shrink-0.py-4.bg-dark.text-light')

    within('footer.container.text-center') do
      expect(rendered).to have_selector('small', text: 'Copyright &copy; Taste Buds')
    end
  end
end
