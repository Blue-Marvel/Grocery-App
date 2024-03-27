part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

@immutable
sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedSuccessState extends HomeState {
  final List<ProductModel> products;
  HomeLoadedSuccessState({required this.products});
}

final class HomeLoadedErrorState extends HomeState {
  final String errorMsg;
  HomeLoadedErrorState(this.errorMsg);
}

final class HomeNavigateToWishListActionState extends HomeActionState {}

final class HomeNavigateToCartActionState extends HomeActionState {}

final class HomeClickedAddToCartActionState extends HomeActionState {}

final class HomeClickedAddToWishActionState extends HomeActionState {}
