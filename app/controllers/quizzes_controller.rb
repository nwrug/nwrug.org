class QuizzesController < ApplicationController
  before_filter :find_quiz, only: [:show, :edit, :update]
  before_filter :authorise, except: [:show]

  def show
    @quiz = Quiz.find_by!(slug: params[:id])
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      redirect_to @quiz
    else
      render :new
    end
  end

  def update
    if @quiz.update_attributes(quiz_params)
      redirect_to @quiz
    else
      render :edit
    end
  end

private

  def find_quiz
    @quiz = Quiz.find_by!(slug: params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:title, :description, :slug)
  end
end
