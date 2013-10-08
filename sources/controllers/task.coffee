class TaskCtrl extends Monocle.Controller

  elements:
    "input[name=name]"          : "name"
    "textarea[name=description]": "description"
    "input[name=list]"          : "list"
    "select[name=when]"         : "when"
    "input[name=important]"     : "important"

  events:
    "click [data-action=save]"  : "onSave"

  constructor: ->
    super
    @new = @_new
    @show = @_show


  # Events
  onSave: (event) -> 
    if @current
      @current.name = @name.val()
      @current.description = @description.val()
     
      #NO GRABA NI EL LIST NI EL WHEN
      @current.list = @list.val()
      @current.when = @when.val()
      
      @current.important = @important[0].checked
      @current.save()
      Lungo.Router.back()
    else
      # New task
      Lungo.Notification.show()
      #NO GRABA NI EL LIST NI EL WHEN

      __Model.Task.create
        name        : @name.val()
        description : @description.val()
        list        : @list.val()
        when        : @when.val()
        important   : @important[0].checked
        done        : false

  # Private Methods
  _new: (@current=null) ->
    @name.val ""
    @description.val ""

    #NO INICIALIZA NI LIST NI WHEN
    #@list.val = "empty"
    #@when.val = ""

    @important[0].checked = false
    Lungo.Router.section "task"

  _show: (@current) ->
    @name.val @current.name
    @description.val @current.description

    #NO CARGA NI LIST, WHEN NI IMPORTANT
    #@list.val @current.list
    #@when.val @current.when


    @important.val @current.important

    console.log @current.important
    console.log @important[0].checked

    Lungo.Router.section "task"

#condicion para saber si quojs está levantado
$$ ->
  __Controller.Task = new TaskCtrl "section#task"
