import 'package:bloc_tutorial/presentation/bloc/bloc_home/home_bloc.dart';
import 'package:bloc_tutorial/presentation/ui/cart.dart';
import 'package:bloc_tutorial/presentation/ui/project_tile_widget.dart';
import 'package:bloc_tutorial/presentation/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: BlocProvider.of<HomeBloc>(context),
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishListActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const WishListScreen()));
        } else if (state is HomeNavigateToCartActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const CartScreen()));
        } else if (state is HomeClickedAddToCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Added to Cart'),
            ),
          );
        } else if (state is HomeClickedAddToWishActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Added to Wish List'),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Grocery App"),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(WishListNavigateEvent());
                    },
                    icon: const Icon(Icons.favorite_border_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(CartNavigateEvent());
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (BuildContext context, int index) =>
                    ProductTileWidget(
                  product: successState.products[index],
                  bloc: context.read<HomeBloc>(),
                ),
              ),
            );

          case HomeLoadedErrorState:
            final errorState = state as HomeLoadedErrorState;
            return Scaffold(
              body: Center(
                child: Text(errorState.errorMsg),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
