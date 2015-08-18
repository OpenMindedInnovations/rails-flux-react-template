class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def destroy
    @todo = Todo.find(params[:id])
    if @todo.update(deleted: true)
      render partial: 'todos/todo', locals: {todo: @todo}
    else
      render json: @todo.errors.to_json
    end
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render partial: 'todos/todo', locals: {todo: @todo} 
    else
      render json: @todo.errors.to_json
    end
  end

  private

    def todo_params
      params.require(:todo).permit(
        :user_id,
        :name,
        :start_date,
        :end_date,
        :max_countries
      )
    end
end
