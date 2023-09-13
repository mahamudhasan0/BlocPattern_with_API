import 'package:blocapi/Bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(ProductsLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Products Screen",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductsLoadedState) {
              return ListView.builder(
                itemCount: state.productsModel.length,
                itemBuilder: (context, index) {
                  final product = state.productsModel[index];
                  final imageUrl = product.image ?? '';

                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: AspectRatio(
                        aspectRatio: 1.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        product.title.toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${product.price!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            product.description.toString(),
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is ProductsErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return const SizedBox();
          },
        ));
  }
}
