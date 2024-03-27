import 'package:bloc_tutorial/presentation/bloc/bloc_wishlist/wishlist_bloc.dart';
import 'package:bloc_tutorial/presentation/ui/project_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    context.read<WishlistBloc>().add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      listener: (context, state) {},
      listenWhen: (previous, current) => current is WishlistActionState,
      buildWhen: (previous, current) => current is! WishlistActionState,
      bloc: BlocProvider.of<WishlistBloc>(context),
      builder: (context, state) {
        switch (state.runtimeType) {
          case WishlistLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          case WishlistLoadedSuccessState:
            final data = state as WishlistLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('WishList'),
              ),
              body: data.wishlist.isEmpty
                  ? const Center(child: Text('No Data Found'))
                  : ListView.builder(
                      itemCount: data.wishlist.length,
                      itemBuilder: (context, index) {
                        return ProductTileWidget(
                          bloc: context.read<WishlistBloc>(),
                          isWishList: true,
                          product: data.wishlist[index],
                        );
                      },
                    ),
            );
          case WishlistLoadedErrorState:
            final error = state as WishlistLoadedErrorState;
            return Center(child: Text('Something went wrong $error'));

          default:
            return const SizedBox();
        }
      },
    );
  }
}
