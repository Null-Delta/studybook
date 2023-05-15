class Score < ApplicationRecord
    def to_s
        "student #{student}, lab #{lab}, score: #{score}"
    end
end
