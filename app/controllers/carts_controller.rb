class CartsController < ApplicationController

    def new
    end


    def create
        # définir quel user
        @userid_cart = current_user.id
        # définir items 
        @it = session[:item_id]
        #comme user has_one :cart et si le panier est vide on le crée! :)
        if current_user.cart == nil
            @cart = Cart.create(user_id: @userid_cart)
        end
        #si le panier n'est pas vide, on ne rentre pas dans le premier if et on ajoute simplement au panier existant
        @cart = CartItem.create(cart_id: current_user.cart.id, item_id: @it)
        #on sauvegarde le panier puis on redirige / ou message d'erreur 
        if @cart.save
            redirect_to  cart_path(current_user.cart.id)
        else
          flash[:error] = "Please Try again as your cart was not saved ! "
        end
    end


    def show
        #on vas chercher les paramètres pour définir la variable cart
        @cart = Cart.find(current_user.cart.id)
        # on définir les itmes du paniers
        @cart_it = @carts.items
        myitems = current_user.cart.items
        # initialisation d'un compteur a 0 pour l'addition du prix du panier
        total = 0
        @all = myitems.length
        session[:all] = @all
        #calcul du prix du panier avec les items présents
        myitems.each do |i|
            total += i.price
            @count = total
        end
    end


    def destroy
        #suppression du panier 
        @cart = Cart.find(params[:id])
        @cart.destroy
        redirect_to cart_path
    end


end
