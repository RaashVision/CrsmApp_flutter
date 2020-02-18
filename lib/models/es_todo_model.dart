class ESTodoModel{

//Auto generate by the database
  int id;
  String title;
  DateTime startdate;
  DateTime enddate;
  DateTime createdate;
  bool isCompleted;


  //Constuctor
  ESTodoModel({this.title,this.startdate,this.enddate,this.createdate,this.isCompleted});

//CONVERT CLASS TO JSON
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'startdate': startdate?.toIso8601String(),
      'enddate': enddate?.toIso8601String(),
      'createdate' : createdate?.toIso8601String(),
      'isCompleted':isCompleted == null ? false : isCompleted 
    };
  }

//JSON TO CLASS
  static ESTodoModel fromMap(Map<String, dynamic> map) {
    return ESTodoModel( 

       title : map['title'],
       startdate: map['startdate'] == null
          ? null
          : DateTime.parse(map['startdate'] as String),
       enddate: map['enddate'] == null
          ? null
          : DateTime.parse(map['enddate'] as String),
       createdate: map['createdate'] == null
          ? null
          : DateTime.parse(map['createdate'] as String),
      isCompleted: map['isCompleted']

    );
  }

}