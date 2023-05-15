class ScoresController < ApplicationController

    protect_from_forgery with: :null_session

    def selected_row
        @@selected_row ||= nil
    end

    def selected_row=(value)
        @@selected_row = value
    end


    def selected_page
        @@selected_page ||= 0

        if @@selected_page >= pages_count 
            @@selected_page = pages_count - 1
        end

        return @@selected_page
    end

    def selected_page=(value)
        if value < 0 
            @@selected_page = 0
        elsif value >= pages_count 
            @@selected_page = pages_count - 1
        else
            @@selected_page = value
        end
    end

    def students_per_page_count
        @students_per_page_count ||= 10
        return @students_per_page_count
    end

    def pages_count
        return (Student.all.to_a.count / students_per_page_count.to_f).ceil
    end

    def index
        @students = Student.limit(self.students_per_page_count).offset(self.selected_page * self.students_per_page_count).to_a
        @selected_page = selected_page
        @selected_row = selected_row
        @pages_count = pages_count
        @labs = Lab.all.to_a
        puts "abuba #{selected_row}"
    end

    def change_page
        self.selected_row = nil
        self.selected_page += params[:page_offset].to_i
        puts(self.selected_page)
        redirect_to '/scores'
    end

    def change_selection
        if self.selected_row == params[:index].to_i
            self.selected_row = nil
        else
            self.selected_row = params[:index].to_i
        end
        redirect_to '/scores'
    end

    def new
        @student = Student.find(params[:student])
        @lab = Lab.find_by(number: params[:lab])
        @score = Score.where(student: params[:student], lab: params[:lab]).to_a.sort_by(&:created_at).last
    end

    def create
        if params[:commit].eql?("Готово")
            new_score = Score.new(post_params)
            new_score.save()
        elsif params[:commit].eql?("Обновить")
            new_score = Score.new(post_params)
            new_score.save()
        end

        redirect_to '/scores'
    end

    def post_params
        params.require(:scores).permit(
            :student,
            :lab,
            :score,
            :comment,
            :justification,
            :date
        )
    end
end
