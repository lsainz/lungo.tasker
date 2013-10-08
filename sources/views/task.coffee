class __View.Task extends Monocle.View

  template  : """
    <li>
      <div class="on-right">{{list}}</div>
      <strong>{{name}}</strong>
      <small>{{description}}</small>
      <small>Done:{{done}}</small>
    </li>
  """

  constructor: ->
    super
    __Model.Task.bind "update", @bindTaskUpdated
    @append @model

  events:
    "swipeLeft li"  :  "onDelete"
    "hold li"       :  "onDone"
    "singleTap li"  :  "onView"

  elements:
    "input.toggle"             : "toggle"

  onDone: (event) ->
    @model.done = !@model.done
    @model.save()
    #EL toggleClass NO FUNCIONA BIEN Y NO QUITA LA CLASE CUANDO EXISTE
    @el.toggleClass "done"

    #NO ME CREA NI ELIMINA LA CLASE
    #if active then #el.addClass("done") else  #el.removeClass("done")
    

  onDelete: (event) ->
    @remove()
    @model.destroy()
 
  onView: (event) ->
    __Controller.Task.show @model

  bindTaskUpdated: (task) =>
    if task.uid is @model.uid
      @model = task
      @refresh()

      console.log task.important
      console.log @container.selector

      if task.important == true && @container.selector == "article#normal ul" then @container.selector = "article#high ul"

      if task.important == false && @container.selector == "article#high ul" then @container.selector = "article#normal ul" 

      console.log @container.selector
      @refresh()


    