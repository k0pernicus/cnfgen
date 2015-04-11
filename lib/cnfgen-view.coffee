module.exports =
class CnfgenView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('cnfgen')

    joke = document.createElement('div')
    joke.classList.add('joke')
    @element.appendChild(joke)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  getNewJoke: (message) ->
    @element.children[0].textContent = message
