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
        puts "="*80
        puts params
        puts "="*80
        #on vas chercher les paramètres pour définir la variable cart
        if current_user.cart == nil
            flash[:no_cart] = "Vous n'avez pas de panier en cours! veuillez ajouter des articles!"
            redirect_to root_path
        else
            @cart = Cart.find(current_user.cart_id)
            # on définir les items du paniers
        @mycart = current_user.cart.item
        # initialisation d'un compteur a 0 pour l'addition du prix du panier
        total = 0
        @mycart.map{ |item| total += item.price}
        @count = [@mycart.length, total]
        end
    end


    def destroy
        #suppression du panier 
        @cart = Cart.find(params[:id])
        @cart.destroy
        redirect_to cart_path
    end


end
