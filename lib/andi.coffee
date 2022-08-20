andiView = require './andi-view'
{CompositeDisposable} = require 'atom'

module.exports = andi =
  andiView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @andiView = new andiView(state.andiViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @andiView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'andi:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @andiView.destroy()

  serialize: ->
    andiViewState: @andiView.serialize()

  toggle: ->
    console.log 'andi was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
