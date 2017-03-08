class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create] #dont want it on the create method

	# After we create a todoitem under a todolist 
	# want to redirect to the todo_list path 
	def create 
		@todo_item = @todo_list.todo_items.create(todo_item_params)
		redirect_to @todo_list
	end

	def destroy
		if @todo_item.destroy
			flash[:success] = "Todo List item was deleted"
		else
			flash[:error] = "Todo List item could not be deleted"
		end
		# After we hit delete, want it to route back to the /todo_lists page
		redirect_to @todo_list
	end

	def complete 
		@todo_item.update_attribute(:completed_at, Time.now)
		redirect_to @todo_list, notice: "Todo item completed"
	end

	# create private method. TodoList references the model 
	private 

	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])
	end 

	def set_todo_item
		@todo_item = @todo_list.todo_items.find(params[:id])
	end

	def todo_item_params
		params[:todo_item].permit(:content)
	end

end
