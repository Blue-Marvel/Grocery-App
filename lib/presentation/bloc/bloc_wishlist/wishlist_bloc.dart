import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/data/wish_list_data.dart';
import 'package:bloc_tutorial/models/home_product_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitial);
    on<RemoveWishlistEvent>(removeWisList);
  }

  FutureOr<void> wishlistInitial(
      WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    try {
      emit(WishlistLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      emit(WishlistLoadedSuccessState(wishlist: WishListData.wishListItems));
    } catch (e) {
      emit(WishlistLoadedErrorState(error: e.toString()));
    }
  }

  FutureOr<void> removeWisList(
      RemoveWishlistEvent event, Emitter<WishlistState> emit) {
    WishListData.wishListItems.remove(event.product);
    emit(WishlistLoadedSuccessState(wishlist: WishListData.wishListItems));
  }
}
