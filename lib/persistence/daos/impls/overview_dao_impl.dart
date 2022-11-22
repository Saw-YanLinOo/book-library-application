import 'package:hive/hive.dart';
import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/persistence/daos/overview_dao.dart';
import 'package:library_app/persistence/hive_constants.dart';

class OverViewDaoImpl extends OverViewDao {
  @override
  OverViewVO getOverView(String date) {
    return getOverViewBox().values.first;
  }

  @override
  Stream<void> getOverViewEventStream() {
    return getOverViewBox().watch();
  }

  @override
  Stream<OverViewVO?> getOverViewFromDatabase(String date) {
    return Stream.value(getOverView(date));
  }

  @override
  void saveOverView(String date, OverViewVO overView) async {
    await getOverViewBox().put(date, overView);
  }

  Box<OverViewVO> getOverViewBox() {
    return Hive.box<OverViewVO>(BOX_NAME_OVERVIEW_VO);
  }
}
