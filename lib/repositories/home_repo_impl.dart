import 'package:injectable/injectable.dart';
import 'package:riverpod/riverpod.dart' as Response;
import '../network/webservice.dart';
abstract class HomeRepo {
  Stream<Response.AsyncValue> fetchProductDetails(String productId);
}
@Injectable()
class HomeRepoImpl extends HomeRepo {
  final Webservice _webservice;

  HomeRepoImpl(this._webservice);

  @override
  Stream<Response.AsyncValue> fetchProductDetails(String productId) async* {
    final snapshots = _webservice.getWebserviceProductDetails(
        productId);
    await for (final snapshot in snapshots) {
      yield snapshot.when(
        data: (data) {
          return Response.AsyncData(data);
        },
        error: (Object error, StackTrace? stackTrace) =>
            Response.AsyncError(error , stackTrace!),
        loading: () => const Response.AsyncLoading(),
      );
    }
  }
}
