import 'package:bloc/bloc.dart';
import 'package:blocapi/Model/ProductModel.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsLoadedEvent, ProductsState> {
  ProductsBloc() : super(ProductsLoadingState()) {
    on<ProductsLoadedEvent>((event, emit) async {
      try {
        emit(ProductsLoadingState());
        var response =
            await http.get(Uri.parse("https://fakestoreapi.com/products"));
        // ignore: unrelated_type_equality_checks
        if (response.statusCode == 200) {
          emit(ProductsLoadedState(productsModelFromJson(response.body)));
        } else {
          throw Exception("Failed To Load");
        }
      } catch (e) {
        emit(ProductsErrorState(e.toString()));
      }
    });
  }
}
