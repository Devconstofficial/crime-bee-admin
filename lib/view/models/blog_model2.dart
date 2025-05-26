

class BlogModel1 {
  String blogId = "";
  String title = "";
  String category = "";
  String description = "";
  String blogStatus = "";
  String coverImage = "";
  int views = 0;
  String createdAt = DateTime.now().toIso8601String();
  String updatedAt = DateTime.now().toIso8601String();
  String postedBy = "";

  BlogModel1.empty();

  BlogModel1.fromJson(Map<String,dynamic> json) {
    blogId = json["_id"] ?? json["id"] ?? blogId;
    title = json["title"] ?? title;
    category = json["category"] ?? category;
    description = json["description"] ?? description;
    postedBy = json["publishedBy"] ?? postedBy;
    blogStatus = json["blogStatus"] ?? blogStatus;
    views = json["views"] ?? views;
    createdAt = json["createdAt"] ?? createdAt;
    updatedAt = json["updatedAt"] ?? updatedAt;
    coverImage = json["coverImage"] ?? coverImage;
  }
  
  
  @override
  String toString() {
    return 'BlogModel1{blogId: $blogId, title: $title, category: $category, description: $description, blogStatus: $blogStatus, coverImage: $coverImage, views: $views, createdAt: $createdAt, updatedAt: $updatedAt, postedBy: $postedBy}';
  }
}
