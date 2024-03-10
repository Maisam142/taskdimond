import 'package:injectable/injectable.dart';
import 'package:riverpod/riverpod.dart' as Response;
import '../../repositories/home_repo_impl.dart';

abstract class FetchMovieUseCase {
  Stream<Response.AsyncValue> fetchProductDetails(productId);
}

@Injectable()
class FetchMovieUseCaseImpl extends FetchMovieUseCase {
  final HomeRepoImpl _homeRepoImpl;

  FetchMovieUseCaseImpl(this._homeRepoImpl);

  @override
  Stream<Response.AsyncValue> fetchProductDetails(productId) async* {
    yield* _homeRepoImpl.fetchProductDetails(productId);
  }
}

