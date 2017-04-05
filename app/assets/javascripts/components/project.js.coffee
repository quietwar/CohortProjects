coefficients = {
  1: 1, 2: .943, 3: .906, 4: .881, 5: .851, 6: .831, 7: .807, 8: .786, 9: .765, 10: .744
}
@Projects = React.createClass
  getInitialState: ->
    edit: false
    onerm: @props.project.onerm
    ismetric: @props.project.ismetric
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/projects/#{ @props.project.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteproject @props.project
  handleEdit: (e) ->
    e.preventDefault()
    data =
      date: ReactDOM.findDOMNode(@refs.date).value
      projectname: ReactDOM.findDOMNode(@refs.projectname).value
      weightprojected: ReactDOM.findDOMNode(@refs.weightprojected).value
      ismetric: @state.ismetric
      repsperformed: ReactDOM.findDOMNode(@refs.repsperformed).value
      onerm: @state.onerm
    $.ajax
      method: 'PUT'
      url: "/projects/#{ @props.project.id }"
      dataType: 'JSON'
      data:
        project: data
      success: (data) =>
        @setState edit: false
        @props.handleEditproject @props.project, data
  reCalculateOneRm: ->
    @setState onerm: @getOneRm( ReactDOM.findDOMNode(@refs.weightprojected).value, ReactDOM.findDOMNode(@refs.repsperformed).value)
  getOneRm: (weight, reps) ->
    if weight and reps > 0 and reps < 11
      weight / coefficients[reps]
    else
      0
  toggleUnit: (e) ->
    e.preventDefault()
    @setState ismetric: !@state.ismetric
  projectRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.project.date
      React.DOM.td null, @props.project.projectname
      React.DOM.td null, @props.project.language
      React.DOM.td null, @props.project.repsperformed
      React.DOM.td null, @props.project.onerm
      React.DOM.td null, @props.project.ismetric.toString()
      React.DOM.td null,
        React.DOM.button
          className: 'btn btn-primary'
          onClick: @handleToggle
          'Edit'
        React.DOM.button
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  projectForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'date'
          defaultValue: @props.project.date
          ref: 'date'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.project.projectname
          ref: 'projectname'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.project.language
          ref: 'weightprojected'
          onChange: @reCalculateOneRm
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          min: '1'
          max: '10'
          defaultValue: @props.project.repsperformed
          ref: 'repsperformed'
          onChange: @reCalculateOneRm
      React.DOM.td null,
        @state.onerm
      React.DOM.td null,
        React.DOM.button
          className: 'btn btn-primary'
          onClick: @toggleUnit
          'Metric = ' + @state.ismetric.toString()
      React.DOM.td null,
        React.DOM.button
          className: 'btn btn-primary'
          onClick: @handleEdit
          'Update'
        React.DOM.button
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'
  render: ->
    if @state.edit
      @projectForm()
    else
      @projectRow()
