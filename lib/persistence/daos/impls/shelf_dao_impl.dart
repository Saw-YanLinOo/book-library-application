import 'package:hive/hive.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/persistence/daos/shelf_dao.dart';
import 'package:library_app/persistence/hive_constants.dart';

class ShelfDaoImpl extends ShelfDao {
  @override
  List<ShelfVO>? getAllShelf() {
    return getSelfBox().values.toList();
  }

  @override
  Stream<List<ShelfVO>?> getAllShelfStream() {
    return Stream.value(getAllShelf());
  }

  @override
  void saveShelf(ShelfVO shelfVO) async {
    var index = getAllShelf()?.length;

    index = index ?? 0 + 1;
    shelfVO.index = index;
    await getSelfBox().put(index, shelfVO);
  }

  @override
  Stream<void> getAllShelfEventStream() {
    return getSelfBox().watch();
  }

  Box<ShelfVO> getSelfBox() {
    return Hive.box<ShelfVO>(BOX_NAME_SHELF_VO);
  }
}
