import 'package:library_app/data/vos/shelf_vo.dart';

abstract class ShelfDao {
  void saveShelf(ShelfVO shelfVO);
  void removeShelf(String index);
  void renameShelf(String name,String index);
  ShelfVO? getShelf(String index);
  List<ShelfVO>? getAllShelf();
  Stream<void> getAllShelfEventStream();
  Stream<ShelfVO?> getShelfStream(String index);
  Stream<List<ShelfVO>?> getAllShelfStream();
}
