class Zikir {
// id INTEGER PRIMARY KEY, name TEXT, timesToBeRead INT, timesRead INT, duaID INT

  final int id;
  final String name;
  final int timesToBeRead;
  final int timesRead;
  final int duaID;

  Zikir({this.id, this.name, this.timesToBeRead, this.timesRead, this.duaID});

// id INTEGER PRIMARY KEY, name TEXT, timesToBeRead INT, timesRead INT, duaID INT

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'timesToBeRead': timesToBeRead,
      'timesRead': timesRead,
      'duaID': duaID
    };
  }
}
