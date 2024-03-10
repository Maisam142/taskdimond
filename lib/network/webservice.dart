import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:riverpod/riverpod.dart' as Response;

@Injectable()
class Webservice {
  final Dio _dio;

  Webservice(this._dio);

  Stream<Response.AsyncValue<KtList<Map<String, dynamic>>>>
  getWebserviceProductDetails(String productId) async* {
    try {
      yield const Response.AsyncValue.loading();
      var response = await _dio.get(
        'https://fakestoreapi.com/products',
        queryParameters: {'productId': productId},
      );
      if (response.statusCode == 200) {
        List<dynamic> responseDataList = response.data as List<dynamic>;

        KtList<Map<String, dynamic>> products = KtList.from(
            responseDataList.cast<Map<String, dynamic>>());

        yield Response.AsyncValue.data(products);

        for (var product in products.iter) {
          String title = product['title'];
          double price = (product['price'] as num).toDouble();
          String description = product['description'];
          String image = product['image'];
          String category = product['category'];

          // print('title: $title');
          // print('price: $price');
          // print('description: $description');
          // print('image: $image');
          // print('category: $category');
          // print('----------------------');
        }
      } else {
        yield const Response.AsyncValue.error(
            DioError, StackTrace.empty);
      }
    } on DioError catch (error, stacktrace) {
      yield Response.AsyncValue.error(error, stacktrace);
    }
  }
}
