class Student < ApplicationRecord
    def isStartEducation
        return self.git == '' && (
            self.phone == '' ||
            self.email == '' ||
            self.telegram == ''
        )
    end

    def short_fio
        return "#{self.lastname} #{self.firstname[0]}.#{self.patronymic[0]}."
    end

    def contact
        if self.phone != '' 
            return self.phone
        elsif self.email != ''
            return self.email
        elsif self.telegram != ''
            return self.telegram
        else
            return ''
        end
    end

    def current_lab
        @scores = Score.where(student: self.id).to_a

        if @scores.count == 0
            return 1
        else
            return @scores.sort_by(&:lab).reverse[0].lab
        end
    end

    def lab_tryes(lab)
        @lab_id = Lab.find_by(number: lab).id
        @tryes = Score.where(student: self.id, lab: lab).to_a.sort_by(&:created_at)

        return @tryes
    end

    def score(lab)
        lab_id = Lab.find_by(number: lab).id
        @tryes = lab_tryes(lab)

        if @tryes.count > 0
            return @tryes.last.score
        else
            return ''
        end
    end
end
