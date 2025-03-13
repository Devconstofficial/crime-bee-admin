class TermsModel {
  String termId = "";
  String type = "";
  String text = "";

  TermsModel.fromJson(Map<String,dynamic> json) {
    termId = json["_id"] ?? json["id"] ?? termId;
    type = json["type"] ?? type;
    text = json["text"] ?? text;
  }

  TermsModel.empty();

  @override
  String toString() {
    return 'TermsModel{termId: $termId, type: $type, text: $text}';
  }
}