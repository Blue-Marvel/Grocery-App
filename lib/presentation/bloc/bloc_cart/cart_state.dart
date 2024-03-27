part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartActionState extends CartState {}

final class CartLoadedSuccessState extends CartState {
  final List<ProductModel> products;
  CartLoadedSuccessState({required this.products});
}

final class CartLoadedErrorState extends CartState {
  final String errorMsg;
  CartLoadedErrorState(this.errorMsg);
}

final class CartRemoveActionState extends CartActionState {}
