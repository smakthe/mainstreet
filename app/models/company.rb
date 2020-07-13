class Company < ApplicationRecord
  has_rich_text :description
  validates_format_of :email, with: /(^.+@getmainstreet\.com$)|(^$)/

end
