class TopicsModel{

  late int topic_grade;
  late int topic_term;
  late String topic_name;

  TopicsModel.fromJson(Map<String,dynamic>json)
  {
    topic_name=json['topic_name'];
    topic_term=json['topic_term'];
    topic_grade=json['topic_grade'];
  }
}