import 'package:bloc_tutorial/presentation/bloc/bloc_cart/cart_bloc.dart';
import 'package:bloc_tutorial/presentation/ui/project_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    context.read<CartBloc>().add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartRemoveActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Removed from Cart'),
            ),
          );
        }
      },
      listenWhen: (previous, current) => current is CartActionState,
      buildWhen: (previous, current) => current is! CartActionState,
      bloc: BlocProvider.of<CartBloc>(context),
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          case CartLoadedSuccessState:
            final data = state as CartLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Cart'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(CartInitialEvent());
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
                body: data.products.isEmpty
                    ? const Center(child: Text("No Cart Items"))
                    : ListView.builder(
                        itemCount: data.products.length,
                        itemBuilder: (context, index) {
                          return ProductTileWidget(
                              isCart: true,
                              product: data.products[index],
                              bloc: context.watch<CartBloc>());
                        }));
          case CartLoadedErrorState:
            final errorState = state as CartLoadedErrorState;
            return Scaffold(
                body: Center(
              child: Text(errorState.errorMsg),
            ));
          default:
            return const SizedBox();
        }
      },
    );
  }
}
