class TodoStore
  @displayName: 'TodoStore'

  constructor: ->
    @bindActions(TodoActions)
    @todos = []

    @exportPublicMethods(
      { 
        getTodos: @getTodos
      }
    )

  onInitData: (props)->
    @setState(props)

  onSubmitTodo: (data) ->
    console.log data
    $.ajax
      type: 'POST'
      url: Routes.todos_path()
      data:
        todo: data
      success: (response)=>
        console.log response
        @todos.push(response)
        @emitChange()
      error: (response)=>
        console.log 'error'
        console.log response

    return false

  onDeleteTodo: (todo_id)->
    $.ajax
      type: 'DELETE'
      url: Routes.todo_path(todo_id)
      success: (response)=>
        console.log 'DETELED'
        console.log response
        console.log 'DELTED'
        _.find(@todos, { id: response.id} ).deleted = true
        @emitChange()
      error: (response)=>
        console.log 'error'
        console.log response

    return false

  getTodos: ()->
    @getState().todos

window.TodoStore = alt.createStore(TodoStore)
