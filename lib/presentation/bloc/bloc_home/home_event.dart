part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeInitialEvent extends HomeEvent {}

final class WishListButtonClickEvent extends HomeEvent {
  final ProductModel product;

  WishListButtonClickEvent({required this.product});
}

final class CartButtonClickEvent extends HomeEvent {
  final ProductModel product;

  CartButtonClickEvent({required this.product});
}

final class WishListNavigateEvent extends HomeEvent {}

final class CartNavigateEvent extends HomeEvent {}
