import 'package:dio/dio.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/network/responses/get_over_view_response.dart';
import 'package:retrofit/http.dart';

part 'book_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class BookApi {
  factory BookApi(Dio dio) => _BookApi(dio);

  @GET(ENDPOINT_GET_OVER_VIEW_JSON)
  Future<GetOverViewResponse> getOverViewJson(
    @Query(PARAM_API_KEY) String apiKey,
  );
}
