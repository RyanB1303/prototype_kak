class Kak < ApplicationRecord
  belongs_to :program_kegiatan, optional: true
  belongs_to :user
end
