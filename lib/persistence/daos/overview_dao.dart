import 'package:library_app/data/vos/over_view_vo.dart';

abstract class OverViewDao {
  void saveOverView(String date, OverViewVO overView);
  OverViewVO getOverView(String date);
  Stream<void> getOverViewEventStream();
  Stream<OverViewVO?> getOverViewFromDatabase(String date);
}
