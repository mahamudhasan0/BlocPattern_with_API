import 'package:bloc/bloc.dart';
import 'package:blocapi/Model/ProductModel.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart'; 

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsLoadedEvent, ProductsState> {
  ProductsBloc() : super(ProductsLoadingState()) {
    on<ProductsLoadedEvent>((event, emit) async {
      try {
        emit(ProductsLoadingState());

        final dio = Dio(); // Create a Dio instance

        // Make a GET request using Dio
        final response = await dio.get("https://fakestoreapi.com/products");

        if (response.statusCode == 200) {
          emit(ProductsLoadedState(productsModelFromJson(response.data)));
        } else {
          throw Exception("Failed To Load");
        }
      } catch (e) {
        emit(ProductsErrorState(e.toString()));
      }
    });
  }
}
