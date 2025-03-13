
import 'package:crime_bee_admin/view/models/user_model.dart';

class CommentModel {
  bool isFlagged = false;
  String commentId = "";
  String text = "";
  String commentedById = "";
  UserModel commentedBy = UserModel.empty();
  String postId = "";
  String postType = "";
  List<String> likes = <String>[];
  List<CommentModel> replies = <CommentModel>[];
  List<String> repliesId =<String>[];
  String createdAt = "";
  int totalPage=0;
  int currentPage=0;

  CommentModel.empty();

  CommentModel.fromJson(Map<String,dynamic> json) {
    commentId = json["_id"] ?? json["id"] ?? commentId;
    isFlagged = json["flagged"] ?? false;
    text = json["text"] ?? text;
    if(json["user"] is String) {
      commentedById = json["user"] ?? commentedById;
    }
    if(json["user"] is Map<String, dynamic>) {
      commentedBy = UserModel.fromJson(json["user"]);
    }
    postId = json["post"] ?? postId;
    postType = json["postType"] ?? postType;
    if(json["likes"] is List) {
      for(var result in json['likes']) {
        likes.add(result.toString());
      }
    }
    if(json["replies"] is List) {
      for(var result in json["replies"]) {
        if(result is Map<String,dynamic>) {
          replies.add(CommentModel.fromJson(result));
        } else if(result is String) {
          repliesId.add(result);
        }
      }
    }
    createdAt = json["createdAt"] ?? createdAt;
  }

  @override
  String toString() {
    return 'CommentModel{isFlagged: $isFlagged, commentId: $commentId, text: $text, commentedById: $commentedById, commentedBy: $commentedBy, postId: $postId, postType: $postType, likes: $likes, replies: $replies, repliesId: $repliesId, createdAt: $createdAt, totalPage: $totalPage, currentPage: $currentPage}';
  }
}