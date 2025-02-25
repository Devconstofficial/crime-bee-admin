import 'package:crime_bee_admin/view/models/user_model.dart';

class NotificationModel {
  String notificationId = "";
  String title = "";
  String body = "";
  String recipientId = "";
  UserModel recipient = UserModel.empty();
  String createdAt = DateTime.now().toUtc().toIso8601String();
  dynamic data;
  int currentPage = 0;
  int totalPage = 0;

  NotificationModel.empty();

  NotificationModel.fromJson(Map<String,dynamic> json) {
    notificationId = json["_id"] ?? json["id"] ?? notificationId;
    title = json["title"] ?? title;
    body = json["body"] ?? body;
    data = json["data"];
    if(json["recipient"]!=null) {
      if(json["recipient"] is String) {
        recipientId = json["recipient"] ?? recipientId;
      } else if(json["recipient"] is Map<String,dynamic>) {
        recipient = UserModel.fromJson(json["recipient"]);
      }
    }
    createdAt = json["createAt"] ?? createdAt;
  }

  Map<String,dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "data": data,
      if(recipientId.isNotEmpty)"recipient": recipientId,
      "createAt": createdAt,
    };
  }

  @override
  String toString() {
    return 'NotificationModel{notificationId: $notificationId, title: $title, body: $body, recipientId: $recipientId, recipient: $recipient, createdAt: $createdAt, data: $data, currentPage: $currentPage, totalPage: $totalPage}';
  }
}