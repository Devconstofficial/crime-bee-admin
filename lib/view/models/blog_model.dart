
import 'package:crime_bee_admin/view/models/user_model.dart';

class BlogModel {
  String blogId = "";
  String title = "";
  String category = "";
  String description = "";
  String blogStatus = "";
  String coverImage = "";
  int views = 0;
  String createdAt = DateTime.now().toIso8601String();
  String updatedAt = DateTime.now().toIso8601String();
  UserModel postedBy = UserModel.empty();

  BlogModel.empty();

  BlogModel.fromJson(Map<String,dynamic> json) {
    blogId = json["_id"] ?? json["id"] ?? blogId;
    title = json["title"] ?? title;
    category = json["category"] ?? category;
    description = json["description"] ?? description;
    postedBy = UserModel.fromJson(json["publishedBy"] ?? {});
    blogStatus = json["blogStatus"] ?? blogStatus;
    views = json["views"] ?? views;
    createdAt = json["createdAt"] ?? createdAt;
    updatedAt = json["updatedAt"] ?? updatedAt;
    coverImage = json["coverImage"] ?? coverImage;
  }
  
  
  @override
  String toString() {
    return 'BlogModel{blogId: $blogId, title: $title, category: $category, description: $description, blogStatus: $blogStatus, coverImage: $coverImage, views: $views, createdAt: $createdAt, updatedAt: $updatedAt, postedBy: $postedBy}';
  }
}
