class ProjectMailer < ActionMailer::Base
  default from: 'notifications@idyllic-software.com'
 
  def project_email(project, user_email)
    @project = project
    @url  = request.domain
    @user_email  = user_email
    mail(to: user_email, subject: 'New project added')
  end
end
