import 'package:bloc_tutorial/models/home_product_model.dart';
import 'package:bloc_tutorial/presentation/bloc/bloc_cart/cart_bloc.dart';
import 'package:bloc_tutorial/presentation/bloc/bloc_home/home_bloc.dart';
import 'package:bloc_tutorial/presentation/bloc/bloc_wishlist/wishlist_bloc.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductModel product;
  final dynamic bloc;
  final bool isCart;
  final bool isWishList;
  const ProductTileWidget(
      {super.key,
      required this.product,
      required this.bloc,
      this.isWishList = false,
      this.isCart = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery.sizeOf(context).width,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(product.image),
              fit: BoxFit.fill,
            ),
            boxShadow: [
              const BoxShadow(
                color: Colors.grey,
                offset: Offset(6, 6),
                blurRadius: 5,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: const Offset(2, 3),
                blurRadius: 8,
              ),
            ],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(50),
            ),
          ),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        isCart || isWishList
                            ? null
                            : bloc.add(CartButtonClickEvent(product: product));

                        isCart ? bloc.add(RemoveFromCartEvent(product)) : null;

                        isWishList
                            ? bloc.add(RemoveWishlistEvent(product: product))
                            : null;
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                            isCart ? Icons.delete : Icons.shopping_bag_outlined,
                            color: Colors.black),
                      ),
                    ),
                    isCart || isWishList
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () {
                              bloc.add(
                                  WishListButtonClickEvent(product: product));
                            },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  // margin: const EdgeInsets.all(8),
                  width: MediaQuery.sizeOf(context).width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  color: Colors.white.withOpacity(0.6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            product.description,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        '\$${product.price.toString()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
