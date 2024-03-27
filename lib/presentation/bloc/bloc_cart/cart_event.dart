part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class CartInitialEvent extends CartEvent {}

final class RemoveFromCartEvent extends CartEvent {
  final ProductModel product;

  RemoveFromCartEvent(this.product);
}
