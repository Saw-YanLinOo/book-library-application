import 'package:dio/dio.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/network/book_api.dart';
import 'package:library_app/network/dataagents/book_data_agent.dart';

class RetrofitBookDataAgent implements BookDataAgent {
  late BookApi mApi;

  RetrofitBookDataAgent._() {
    final dio = Dio();
    mApi = BookApi(dio);
  }

  static final RetrofitBookDataAgent _singleton = RetrofitBookDataAgent._();
  factory RetrofitBookDataAgent() => _singleton;

  @override
  Future<List<OverViewVO>?> getOverViewJson() {
    return mApi
        .getOverViewJson(API_KEY)
        .asStream()
        .map((event) => event.results)
        .first;
  }
}
