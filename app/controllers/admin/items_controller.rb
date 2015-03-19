class Admin::ItemsController < AdminController

  def index
    if current_user.nil? || current_user.user?
      redirect_to root_path, alert: "Sensei says: 'Not quite yet young grasshopper'"
    else
      @items = Item.all
    end
  end

  def edit
    if current_user.nil? || current_user.user?
      redirect_to root_path, alert: "Sensei says: 'Not quite yet young grasshopper'"
    else
      render :edit
    end
  end

  def new
    if current_user.nil? || current_user.user?
      redirect_to root_path, alert: "Sensei says: 'Not quite yet young grasshopper'"
    else
      @item = Item.new
      @categories = Category.all
    end
  end

  def create
    if current_user.nil? || current_user.user?
      redirect_to root_path, alert: "Sensei says: 'Not quite yet young grasshopper'"
    else
      @item = Item.new(item_params)

      @categories = params.select{ |k,v| k.include?("ItemsCategory") }.values[0].select{ |k,v| v == "1" }.keys

      if @item.save
        @categories.each do |category|
          @item.items_categories.create(category_id: Category.find_by(title: category).id)
        end
        redirect_to admin_items_path
      else
        render :new
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :picture)
  end

end