class RatedByModel {
  String rateId = "";
  double rating = 0.0;
  String userId = "";

  RatedByModel.empty();

  RatedByModel.fromJson(Map<String,dynamic> json) {
    rateId = json["_id"] ?? rateId;
    userId = json["user"] ?? userId;
    rating = double.parse("${json["rating"] ?? rating}");
  }

  @override
  String toString() {
    return 'RatedByModel{rateId: $rateId, rating: $rating, userId: $userId}';
  }
}