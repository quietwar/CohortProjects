class ProjectsController < ApplicationController
  
    def this
          @project = Project.new
  
    end
  
    def create
          @project = Project.new(project_params)
    if @project.save
          redirect_to project_path(@project)
    else
        render 'new'
    end    
end 
   

  

private

    def project_params
      params.require(:project).permit(:genius, :projectname, :completed, :description, :comments)
    end

end


