class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  # GET /foods
  def index
    @foods = Food.includes(image_attachment: [:blob]).all.order('created_at DESC')
  end

  # GET /foods/1
  def show
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
  end

  # POST /foods
  def create
    @food = Food.new(food_params)
    if @food.save
      # redirect_to @food, notice: 'Food was successfully created.'
      response = RestClient.post("https://owl4glwns4.execute-api.us-west-2.amazonaws.com/api/train", {
        data: Base64.encode64(@food.image.download),
        topk: 3
      }.to_json, {
        content_type: :json
      })
      @food.meta = {}
      json_response = JSON.parse(response.body)
      results = json_response['response'].gsub(/[\[\]\"\']/, '').scan(/\(.+?\)/)
      results.each do |result|
        category_pair = result.gsub(/[\(\)]/, '').split(',')
        @food.meta[category_pair[0]] = category_pair[1].strip.to_f
      end
      @food.save
      redirect_to action: 'index'
    else
      render :new
    end
  end

  # PATCH/PUT /foods/1
  def update
    if @food.update(food_params)
      redirect_to @food, notice: 'Food was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /foods/1
  def destroy
    @food.destroy
    redirect_to foods_url, notice: 'Food was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def food_params
      params.require(:food).permit(:image)
    end
end
