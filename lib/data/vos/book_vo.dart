// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookVO {
  int? id;
  String? name;
  String? posterPath;
  String? type;
  String? author;

  BookVO({
    this.id,
    this.name,
    this.posterPath,
    this.type,
    this.author,
  });

  @override
  bool operator ==(covariant BookVO other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.posterPath == posterPath &&
        other.type == type &&
        other.author == author;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        posterPath.hashCode ^
        type.hashCode ^
        author.hashCode;
  }

  @override
  String toString() {
    return 'BookVO(id: $id, name: $name, posterPath: $posterPath, type: $type, author: $author)';
  }
}
