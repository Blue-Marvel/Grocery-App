import 'package:bloc_tutorial/presentation/bloc/bloc_cart/cart_bloc.dart';
import 'package:bloc_tutorial/presentation/bloc/bloc_home/home_bloc.dart';
import 'package:bloc_tutorial/presentation/bloc/bloc_wishlist/wishlist_bloc.dart';
import 'package:bloc_tutorial/presentation/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<WishlistBloc>(
          create: (context) => WishlistBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          useMaterial3: false,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
