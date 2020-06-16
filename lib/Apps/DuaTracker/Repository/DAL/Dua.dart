class Dua {

  final int id;
  final String name;
// final String note;
// final DateTime createdDate;
// final DateTime modifiedDate;

  Dua({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }


}
