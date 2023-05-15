class StudentsController < ApplicationController    
    protect_from_forgery with: :null_session, only: [:delete]

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
        puts self.selected_page
        @pages_count = pages_count
        @selected_page = selected_page
        @students = Student.limit(self.students_per_page_count).offset(self.selected_page * self.students_per_page_count).to_a
    end

    def show
        puts self.selected_page
        @pages_count = pages_count
        @selected_page = selected_page
        @students = Student.limit(self.students_per_page_count).offset(self.selected_page * self.students_per_page_count).to_a
        render 'index'
    end

    def create
        if params[:commit].eql?("Готово") 
            new_student = Student.new(post_params)
            new_student.save()
        end

        redirect_to '/students'
    end

    def edit
        @student = Student.find(params[:id])

        if params[:editing_type] == 'fio' 
            @editing_strategy = StudentsHelper::StudentFIOEditingStrategy.new()
        elsif params[:editing_type] == 'git'
            @editing_strategy = StudentsHelper::StudentGitEditingStrategy.new()
        else
            @editing_strategy = StudentsHelper::StudentContactsEditingStrategy.new()
        end
    end

    def update
        if params[:commit].eql?("Готово") 
            Student.find(params[:id]).update(post_params)
        end

        redirect_to '/students'
    end

    def destroy
        Student.find(params[:id]).destroy
    end

    def change_page
        self.selected_page += params[:page_offset].to_i
        puts(self.selected_page)
        redirect_to '/students'
    end

    def post_params
        params.require(:students).permit(
            :id,
            :firstname,
            :lastname,
            :patronymic,
            :git,
            :phone,
            :email,
            :telegram
        )
    end

end
