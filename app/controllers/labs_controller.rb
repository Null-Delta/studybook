class LabsController < ApplicationController
    protect_from_forgery with: :null_session, only: [:delete]

    def new
        @last_lab = Lab.last
    end

    def index
        @labs = Lab.all.to_a
    end

    def show
        @labs = Lab.all.to_a
        render 'index'
    end

    def edit
        @last_lab = Lab.find_by(number: params[:id].to_i - 1)
        @next_lab = Lab.find_by(number: params[:id].to_i + 1)
        @lab = Lab.find_by(number: params[:id])

        if params[:mode] == 'view'
            @strategy = LabsHelper::LabNonEditingStrategy.new
        else 
            @strategy = LabsHelper::LabEditingStrategy.new
        end
    end

    def update
        if params[:commit].eql?("Готово") 
            new_lab = Lab.find_by(number: params[:id])
            new_lab.update(post_params)
            puts "antipopa"
        end

        @labs = Lab.all.to_a

        redirect_to '/labs'
    end

    def create
        if params[:commit].eql?("Готово") 
            new_lab = Lab.new(post_params)
            new_lab.save()
            puts "abiba"
        end
        @labs = Lab.all.to_a

        redirect_to '/labs'
    end

    def destroy
        Lab.find_by(number: params[:id]).destroy
    end

    def post_params
        params.require(:labs).permit(
            :number,
            :name,
            :themes,
            :tasks,
            :date
        )
    end
end
