module ApplicationHelper
  def convert_keys_to_symbols(hash)
    hash = hash.reduce({}) do |memo, (k, v)|
      memo.tap { |m| m[k.to_sym] = v }
    end
  end
end
