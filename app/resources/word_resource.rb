# frozen_string_literal: true

class WordResource
  include Alba::Resource

  root_key :word

  attributes :id, :en, :ja, :meaning, :misc
end
