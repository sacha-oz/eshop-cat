class CartsController < ApplicationController

    def new
    end


    def create
        # définir quel user
        @userid_cart = current_user
        # définir items 
        @it = session[:item_id]
        #comme user has_one :cart et si le panier est vide on le crée! :)
        if current_user.cart == nil
            @cart = Cart.create(user_id: @userid_cart)
        else
        #si le panier n'est pas vide, on ne rentre pas dans le premier if et on ajoute simplement au panier existant
        @cart = CartItem.add(@it, @it.price)
        end
        #on sauvegarde le panier puis on redirige / ou message d'erreur 
        if @cart.save
            redirect_to  cart_path(current_user.cart.id)
        else
          flash[:error] = "Please Try again as your cart was not saved ! "
        end
    end


    def show
        @cart = current_user.cart
    end


    def destroy
        #suppression du panier 
        @cart = Cart.find(params[:id])
        @cart.destroy
        redirect_to cart_path
    end


end
