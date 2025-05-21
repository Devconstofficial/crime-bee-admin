import 'dart:typed_data';

import 'package:crime_bee_admin/view/models/blog_model.dart';
import 'package:crime_bee_admin/web_services/blog_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class BlogController extends GetxController {
  var selectedBlogType = ''.obs;
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  var selectedBlogStatus = ''.obs;
  RxList notifications = [].obs;
  RxList activities = [].obs;
  var selectedFilters = <String>{}.obs;

  Rx<Uint8List?> selectedImage = Rx<Uint8List?>(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = await image.readAsBytes();
    }
  }

  Future<void> createBlogAsAdmin({
    required String title,
    required String category,
    required String description,
    required String coverImage,
  }) async {
    try {
      final result = await _service.createBlogByAdmin(
        title: title,
        category: category,
        description: description,
        coverImage: coverImage,
      );

      if (result is BlogModel) {
        print("Blog created successfully: ${result.title}");
        // allUserBlogs.insert(0, result);
        // applyPagination();
      } else if (result is Map && result.containsKey("error")) {
        print("Failed to create blog: ${result['error']}");
      }
    } catch (e) {
      print("Exception while creating blog: $e");
    }
  }

  Future<void> updateBlogAsAdmin({
  required String id,
  required String title,
  required String category,
  required String description,
  required String coverImage,
}) async {
  try {
    final result = await _service.updateBlogByAdmin(
      blogId: id,
      title: title,
      category: category,
      description: description,
      coverImage: coverImage,
    );

    if (result is BlogModel) {
      print("Blog updated successfully: ${result.title}");

      final index = allBlogs.indexWhere((blog) => blog.blogId == id);
      if (index != -1) {
        allBlogs[index] = result;
        allBlogs.refresh();
      }

    } else if (result is Map && result.containsKey("error")) {
      print("Failed to update blog: ${result['error']}");
    }
  } catch (e) {
    print("Exception while updating blog: $e");
  }
}


  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
  }

  var isNotificationVisible = false.obs;

  void toggleNotificationVisibility() {
    isNotificationVisible.value = !isNotificationVisible.value;
  }

  @override
  onInit() {
    super.onInit();
    fetchAllBlogs();
    fetchAllUserBlogs();
  }

  String formatDate(String isoDate) {
    final DateTime parsedDate = DateTime.parse(isoDate);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  final RxList<BlogModel> allUserBlogs = <BlogModel>[].obs;
  final RxList<BlogModel> paginatedUserBlogs = <BlogModel>[].obs;

  final int userBlogsPerPage = 3;
  final RxInt userBlogsCurrentPage = 1.obs;
  final RxInt userBlogTotalPages = 1.obs;

  final BlogService _service = BlogService();

  Future<void> fetchAllUserBlogs() async {
    try {
      final List<BlogModel> blogs = [];

      int page = 1;
      while (true) {
        final response = await _service.getBlogsByUser(
          page: page,
          limit: userBlogsPerPage,
        );

        if (response is Map && response.containsKey("blogs")) {
          final List<BlogModel> pageBlogs = response["blogs"];
          if (pageBlogs.isEmpty) break;

          blogs.addAll(pageBlogs);

          final int totalPages = response["totalPages"];
          userBlogTotalPages.value = totalPages;

          if (page >= totalPages) break;

          page++;
        } else {
          break;
        }
      }

      allUserBlogs.assignAll(blogs);
      applyPagination();
    } catch (e) {
      print("Error fetching all blogs: $e");
    }
  }

  void applyPagination() {
    final startIndex = (userBlogsCurrentPage.value - 1) * userBlogsPerPage;
    final endIndex = (startIndex + userBlogsPerPage > allUserBlogs.length)
        ? allUserBlogs.length
        : startIndex + userBlogsPerPage;

    paginatedUserBlogs.value = allUserBlogs.sublist(startIndex, endIndex);
  }

  void changeUserBlogPage(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= userBlogTotalPages.value) {
      userBlogsCurrentPage.value = pageNumber;
      applyPagination();
    }
  }

  void goToPreviousUserBlogPage() {
    if (userBlogsCurrentPage.value > 1) {
      userBlogsCurrentPage.value -= 1;
      applyPagination();
    }
  }

  void goToNextUserBlogPage() {
    if (userBlogsCurrentPage.value < userBlogTotalPages.value) {
      userBlogsCurrentPage.value += 1;
      applyPagination();
    }
  }

  bool get isUserBlogBackDisabled => userBlogsCurrentPage.value == 1;
  bool get isUserBlogNextDisabled =>
      userBlogsCurrentPage.value == userBlogTotalPages.value;

  final RxList<BlogModel> allBlogs = <BlogModel>[].obs;
  final RxList<BlogModel> paginatedBlogs = <BlogModel>[].obs;

  final int blogsPerPage = 3;
  final RxInt blogsCurrentPage = 1.obs;
  final RxInt blogTotalPages = 1.obs;

  Future<void> fetchAllBlogs() async {
    try {
      allBlogs.clear();
      paginatedBlogs.clear();
      final List<BlogModel> blogs = [];

      int page = 1;
      while (true) {
        final response = await _service.getBlogsByAdmin(
          page: page,
          limit: blogsPerPage,
        );

        if (response is Map && response.containsKey("blogs")) {
          final List<BlogModel> pageBlogs = response["blogs"];
          if (pageBlogs.isEmpty) break;

          blogs.addAll(pageBlogs);

          final int totalPages = response["totalPages"];
          blogTotalPages.value = totalPages;

          if (page >= totalPages) break;

          page++;
        } else {
          break;
        }
      }

      allBlogs.assignAll(blogs);
      applyPagination1();
    } catch (e) {
      print("Error fetching all blogs: $e");
    }
  }

  void applyPagination1() {
    final startIndex = (blogsCurrentPage.value - 1) * blogsPerPage;
    final endIndex = (startIndex + blogsPerPage > allBlogs.length)
        ? allBlogs.length
        : startIndex + blogsPerPage;

    paginatedBlogs.value = allBlogs.sublist(startIndex, endIndex);
  }

  void changeBlogPage(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= blogTotalPages.value) {
      blogsCurrentPage.value = pageNumber;
      applyPagination1();
    }
  }

  void goToPreviousBlogPage() {
    if (blogsCurrentPage.value > 1) {
      blogsCurrentPage.value -= 1;
      applyPagination1();
    }
  }

  void goToNextBlogPage() {
    if (blogsCurrentPage.value < blogTotalPages.value) {
      blogsCurrentPage.value += 1;
      applyPagination1();
    }
  }

  bool get isBlogBackDisabled => blogsCurrentPage.value == 1;
  bool get isBlogNextDisabled => blogsCurrentPage.value == blogTotalPages.value;

  List<BlogModel> get currentPageUsers {
    final startIndex = (blogsCurrentPage.value - 1) * blogsPerPage;
    final endIndex = startIndex + blogsPerPage;
    return allBlogs.sublist(
      startIndex,
      endIndex > allBlogs.length ? allBlogs.length : endIndex,
    );
  }

  List<BlogModel> get userBlogsCurrentPageUsers {
    final startIndex = (userBlogsCurrentPage.value - 1) * userBlogsPerPage;
    final endIndex = startIndex + userBlogsPerPage;
    return allUserBlogs.sublist(
      startIndex,
      endIndex > allUserBlogs.length ? allUserBlogs.length : endIndex,
    );
  }
}
