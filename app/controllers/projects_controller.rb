class ProjectsController < ApplicationController
  
    def new
      @project = Project.new
    end
  
    def create
       @project = Project.create(project_params)
    if @project.save
      flash[:notice] = "Project was created successfully"
        redirect_to project_path(@project)
    else
        render 'new'
    end    
end 
   
    def show

    end


  

private

    def project_params
      params.require(:project).permit(:genius, :projectname, :completed, :description, :comments)
    end
end


