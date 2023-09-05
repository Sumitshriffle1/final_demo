class AppliesController < ApplicationController

  def create
    apply = Apply.new(apply_params)
    if apply.save
      render json: { message: "Apply successfull..",data:apply}
    else
      render json: { errors: apply.errors.full_messages },status: :unprocessable_entity
    end

    private
    def apply_params
      params.permit(:resume)
    end
  end
end
