part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistActionState extends WishlistState {}

final class WishlistLoadingState extends WishlistState {}

final class WishlistLoadedSuccessState extends WishlistState {
  final List<ProductModel> wishlist;

  WishlistLoadedSuccessState({required this.wishlist});
}

final class WishlistLoadedErrorState extends WishlistState {
  final String error;

  WishlistLoadedErrorState({required this.error});
}
