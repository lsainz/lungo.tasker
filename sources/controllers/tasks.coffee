class __Controller.TasksCtrl extends Monocle.Controller

    events:
      "click [data-action=new]"    :   "onNew"

    elements:
      "#pending"    :   "pending"
      "#important"  :   "important"
      "input"       :   "name"
      ".important span.count" :   "counter"   
      ".normal span.count"    :   "counterN"     

    constructor: ->
      super
      __Model.Task.bind "create", @bindTaskCreated
      __Model.Task.bind "update", @bindTaskUpdate
      __Model.Task.bind "destroy", @bindTaskDelete

    onNew: (event) ->
      __Controller.Task.new()

    bindTaskCreated: (task) =>
      context = if task.important is true then "high" else "normal"
      #En article##{context} el primer # hace referencia al id y el segundo al binding de la variable context
      new __View.Task model: task, container: "article##{context} ul"
      Lungo.Router.back()
      Lungo.Notification.hide()
      @showCounter()
     
    bindTaskUpdate: (task) =>
      @showCounter()

    bindTaskDelete: (task) =>
      @showCounter()

    showCounter: ->
      @counter.html __Model.Task.important().length
      @counterN.html __Model.Task.normal().length
    

$$ ->
  Lungo.init({})
  Tasks = new __Controller.TasksCtrl "section#tasks"
