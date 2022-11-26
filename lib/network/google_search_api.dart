import 'package:dio/dio.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/network/responses/get_search_google_book_response.dart';
import 'package:retrofit/retrofit.dart';

part 'google_search_api.g.dart';

@RestApi(baseUrl: GOOGLE_BOOK_SEARCH_URL)
abstract class GoogleSearchApi {
  factory GoogleSearchApi(Dio dio) => _GoogleSearchApi(dio);

  @GET(ENDPOINT_SEARCH_GOOGLE_BOOK)
  Future<GetSearchGoogleBookResponse> getSearchGoogleBook(
    @Query(PARAM_QUERY) String query,
  );
}
