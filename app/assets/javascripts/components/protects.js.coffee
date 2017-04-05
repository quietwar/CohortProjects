@Projects = React.createClass
  getInitialState: ->
    projects: @props.data
  getDefaultProps: ->
    projects: []
  addProjects: (project) ->
    projects = @state.projects.slice()
    projects.push project
    @setState projects: projects
  deleteproject: (project) ->
    projects = @state.projects.slice()
    index = projects.indexOf project
    projects.splice index, 1
    @replaceState projects: projects
  updateproject: (project, data) ->
    index = @state.projects.indexOf project
    projects = React.addons.update(@state.projects, { $splice: [[index, 1, data]] })
    @replaceState projects: projects
  render: ->
    React.DOM.div
      className: 'projects'
      React.DOM.h1
        className: 'title'
        'projects'
       React.createElement projectForm, handleNewproject: @addproject
       React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Date'
            React.DOM.th null, 'project Name'
            React.DOM.th null, 'language'
            React.DOM.th null, 'Reps Performed'
            React.DOM.th null, '1 RM'
            React.DOM.th null, 'Metric?'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
         for project in @state.projects
          React.createElement project, key: project.id, project: project, handleDeleteproject: @deleteproject, handleEditproject: @updateproject
