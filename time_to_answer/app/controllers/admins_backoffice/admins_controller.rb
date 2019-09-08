class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    @admins = Admin.all
  end
  def edit
    @admin = Admin.find(params[:id])
  end
  def update
    @admin = Admin.find(params[:id])
    
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
    
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)
    
    if @admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Administrador atualizado com sucesso"
    else
      render :edit
    end
  end
end
