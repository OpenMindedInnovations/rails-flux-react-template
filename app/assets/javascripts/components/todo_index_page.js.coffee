{ div, h1, span, a, input, label } = React.DOM

TodoListItem = React.createFactory React.createClass
  deleteTodo: (e)->
    TodoActions.deleteTodo(@props.todo.id)

  render: ->
    console.log @props.todo
    console.log 'LIST ITEM'
    todo_list_item_classes = 'todo-list-item'
    todo_list_item_classes += ' deleted' if @props.todo.deleted
    div className: todo_list_item_classes,
      span {}, @props.todo.name
      unless @props.todo.deleted
        a onClick: @deleteTodo, className: 'btn btn-danger', 'Delete'

TodoList = React.createFactory React.createClass
  render: ->
    div className: 'row',
      _.map @props.todos, (todo)=>
        div className: 'col-xs-12',
          TodoListItem(todo: todo)

TodoForm = React.createFactory React.createClass
  submitTodo: ->
    todo_name = React.findDOMNode(this.refs.name).value
    return if todo_name.length == 0
    TodoActions.submitTodo(name: todo_name)

  render: ->
    div className: 'row',
      div className: 'col-xs-12',
        div className: 'form-group',
          label for: 'todoName', 'Todo Name'
          input ref: 'name', type: 'text', className: 'form-control', id: 'todoName', placeholder: 'Todo Name'

        a onClick: @submitTodo, className: 'btn btn-primary', 'Submit Todo'


window.TodoIndexPage = React.createClass
  getInitialState: ->
    todos: TodoStore.getTodos()

  componentWillMount: ->
    TodoStore.listen(@onChange)
    TodoActions.initData(@props)

  componentWillUnmount: ->
    TodoStore.unlisten(@onChange)

  onChange: (state)->
    @setState(state)

  render: ->
    div {},
      h1 {}, 'Todo List'
      TodoForm()
      TodoList(todos: @state.todos)