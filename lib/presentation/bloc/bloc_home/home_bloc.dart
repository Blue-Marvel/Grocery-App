import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/data/cart_data.dart';
import 'package:bloc_tutorial/data/grocery_data.dart';
import 'package:bloc_tutorial/data/wish_list_data.dart';
import 'package:bloc_tutorial/models/home_product_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(initialEvent);
    on<WishListNavigateEvent>(navigateToWishList);
    on<CartNavigateEvent>(navigateToCart);
    on<CartButtonClickEvent>(clickedAddToCart);
    on<WishListButtonClickEvent>(clickedAddToWishList);
  }

  FutureOr<void> navigateToWishList(
      WishListNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishListActionState());
  }

  FutureOr<void> clickedAddToCart(
      CartButtonClickEvent event, Emitter<HomeState> emit) {
    if (!CartData.cartItems.contains(event.product)) {
      CartData.cartItems.add(event.product);
      emit(HomeClickedAddToCartActionState());
    }
    emit(HomeClickedAddToCartActionState());
  }

  FutureOr<void> clickedAddToWishList(
      WishListButtonClickEvent event, Emitter<HomeState> emit) {
    if (!WishListData.wishListItems.contains(event.product)) {
      WishListData.wishListItems.add(event.product);
      emit(HomeClickedAddToWishActionState());
    }
    emit(HomeClickedAddToWishActionState());
  }

  FutureOr<void> navigateToCart(
      CartNavigateEvent event, Emitter<HomeState> emit) {
    // print("Navigate to cart");
    emit(HomeNavigateToCartActionState());
  }

  FutureOr<void> initialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      emit(HomeLoadedSuccessState(
          products: GroceryData.groceryList
              .map((e) => ProductModel.fromMap(e))
              .toList()));
    } catch (e) {
      emit(HomeLoadedErrorState(e.toString()));
    }
  }
}
