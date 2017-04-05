coefficients = {
  1: 1, 2: .943, 3: .906, 4: .881, 5: .851, 6: .831, 7: .807, 8: .786, 9: .765, 10: .744
}
@ProjectForm = React.createClass
  getInitialState: ->
    date: ''
    projectname: ''
    ismetric: false
    language: ''
    repsperformed: ''
    onerm: '0'
  handleValueChange: (e) ->
    valueName = e.target.name
    @setState "#{ valueName }": e.target.value
  toggleUnit: (e) ->
    e.preventDefault()
    @setState ismetric: !@state.ismetric
  calculateOneRm: ->
    if @state.language and @state.repsperformed
        @state.onerm = @state.language / coefficients[@state.repsperformed]
    else
      0
  valid: ->
    @state.date && @state.projectname && @state.language && @state.repsperformed && @state.onerm
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { project: @state }, (data) =>
      @props.handleNewProject data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'date'
          className: 'form-control'
          placeholder: 'date'
          name: 'date'
          value: @state.date
          onChange: @handleValueChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'projectname'
          name: 'projectname'
          value: @state.projectname
          onChange: @handleValueChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'number'
          className: 'form-control'
          placeholder: 'language'
          name: 'language'
          value: @state.language
          onChange: @handleValueChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'number'
          min: 1
          max: 10
          className: 'form-control'
          placeholder: 'repsperformed'
          name: 'repsperformed'
          value: @state.repsperformed
          onChange: @handleValueChange
      React.DOM.button
        className: 'btn btn-primary'
        onClick: @toggleUnit
        'Metric = ' + @state.ismetric.toString()
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create Project'
      React.createElement OneRmBox, onerm: @calculateOneRm()
