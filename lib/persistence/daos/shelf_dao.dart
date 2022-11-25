import 'package:library_app/data/vos/shelf_vo.dart';

abstract class ShelfDao {
  void saveShelf(ShelfVO shelfVO);
  List<ShelfVO>? getAllShelf();
  Stream<void> getAllShelfEventStream();
  Stream<List<ShelfVO>?> getAllShelfStream();
}
