class RolesController < ApplicationController
  has_scope :page, default: 1
  has_scope :per, default: 10

  def index
    @roles = apply_scopes(Role.includes(:author).ordered)

    authorize @roles
  end

  def new
    @role = Role.new
    @role.author = current_user

    authorize @role

    @role.build_permissions!
  end

  def create
    @role = Role.new(role_params)
    @role.author = current_user

    authorize @role

    if @role.save
      respond_with @role, location: roles_path
    else
      render :new
    end
  end

  def edit
    @role = Role.find(params[:id])

    authorize @role

    @role.build_permissions!
  end

  def update
    @role = Role.find(params[:id])

    authorize @role

    if @role.update(role_params)
      respond_with @role, location: roles_path
    else
      render :edit
    end
  end

  def destroy
    @role = Role.find(params[:id])

    authorize @role

    @role.destroy

    respond_with @role, location: roles_path
  end

  def history
    @role = Role.find params[:id]

    authorize @role

    respond_with @role
  end

  private

  def role_params
    params.require(:role).permit(
      :name, :kind, :access_level, :permissions_attributes => [:id, :feature, :permission],
      :user_roles_attributes => [
        :id, :user_id, :unity_id, :_destroy
      ]
    )
  end
end
