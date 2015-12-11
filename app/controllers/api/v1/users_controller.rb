class API::V1::UsersController < API::V1::BaseController
  respond_to :json
  def index
     respond_with User.all
  end
  def show
    user = User.find(params[:id])
    respond_with API::V1::UserSerializer.new(user).to_json
  end
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201,location: [:api,user]
    else
      render json: {errors: user.errors },status:422
    end
  end

  private
   def user_params
     params.require(:user).permit(:email, :password, :password_confirmation)
   end
end
