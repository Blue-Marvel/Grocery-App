import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/data/cart_data.dart';
import 'package:bloc_tutorial/models/home_product_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(initialEvent);
    on<RemoveFromCartEvent>(removeFromCartEvent);
  }

  FutureOr<void> initialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      emit(
        CartLoadedSuccessState(products: CartData.cartItems),
      );
    } catch (e) {
      emit(CartLoadedErrorState(e.toString()));
    }
  }

  FutureOr<void> removeFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    CartData.cartItems.remove(event.product);
    emit(CartLoadedSuccessState(products: CartData.cartItems));
  }
}
