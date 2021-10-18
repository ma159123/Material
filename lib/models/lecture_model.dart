class LectureModel{
  String? lec_name;
  String? lec_material;
 // String? icon;

  String? lec_date;
  LectureModel({
    required this.lec_name,
    required this.lec_material,
    required this.lec_date,
   // required this.icon,

  });

  LectureModel.fromJson(Map<String,dynamic>?json)
  {
    lec_name=json!['lec_name'];
    lec_material=json['lec_material'];
    lec_date=json['lec_date'];
  //  icon=json['icon'];

  }

  Map<String,dynamic>toMap()
  {
    return{
      'lec_name':lec_name,
      'lec_material':lec_material,
      'lec_date':lec_date,
      //'icon':icon,

    };
  }
}