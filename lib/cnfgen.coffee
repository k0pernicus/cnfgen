CnfgenView = require './cnfgen-view'
{CompositeDisposable} = require 'atom'

module.exports = Cnfgen =
  cnfgenView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @cnfgenView = new CnfgenView(state.cnfgenViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @cnfgenView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'cnfgen:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @cnfgenView.destroy()

  serialize: ->
    cnfgenViewState: @cnfgenView.serialize()

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      xmlhttp = new XMLHttpRequest()
      xmlhttp.open( "GET", "http://api.icndb.com/jokes/random", false )
      xmlhttp.send( null )
      joke = JSON.parse(xmlhttp.responseText)
      console.log("joke : "+joke)
      @cnfgenView.getNewJoke(joke.value.joke)
      @modalPanel.show()

  new_joke: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
      @toggle()
