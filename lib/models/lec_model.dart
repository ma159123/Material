class LecModel{

  late String lec_date;
  late String lec_material;
  late String lec_name;


  LecModel.fromJson(Map<String,dynamic>json)
  {
    lec_date=json['lec_date'];
    lec_material=json['lec_material'];
    lec_name=json['lec_name'];
  }
}