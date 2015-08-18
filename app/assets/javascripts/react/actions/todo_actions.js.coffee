class TodoActions
  constructor: ->
    @generateActions(
      'submitTodo',
      'deleteTodo',
      'initData'
    )

window.TodoActions = alt.createActions(TodoActions)
