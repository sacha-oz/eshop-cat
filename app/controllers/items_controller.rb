class ItemsController < ApplicationController

    def show
        @item = Item.find(params[:id])
    end

    def index
        @items  = Item.all
    end

    def new
    end

    def create
    end

end
