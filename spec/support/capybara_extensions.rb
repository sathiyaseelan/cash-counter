module CapybaraExtensions
  def expect_redirect_to(url)
    expect(current_path).to eq url
  end
end
