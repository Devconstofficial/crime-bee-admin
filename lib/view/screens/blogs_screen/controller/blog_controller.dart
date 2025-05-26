import 'dart:developer';
import 'dart:typed_data';
import 'package:mime/mime.dart';
import 'package:crime_bee_admin/view/models/blog_model.dart';
import 'package:crime_bee_admin/view/models/blog_model2.dart';
import 'package:crime_bee_admin/web_services/blog_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BlogController extends GetxController {
  var selectedBlogType = ''.obs;
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  var selectedBlogStatus = ''.obs;
  var status = ''.obs;
  RxList notifications = [].obs;
  RxList activities = [].obs;
  var selectedFilters = <String>{}.obs;

  RxString selectedImage = ''.obs;
  var isUploading = false.obs;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        isUploading(true);
        final Uint8List imageBytes = await pickedFile.readAsBytes();
        final mimeType = lookupMimeType(pickedFile.name) ?? 'image/jpeg';
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('blogs_image/${DateTime.now().millisecondsSinceEpoch}.jpg');
        final metadata = SettableMetadata(contentType: mimeType);
        UploadTask uploadTask = storageRef.putData(imageBytes, metadata);
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          log("Upload progress: ${snapshot.bytesTransferred} / ${snapshot.totalBytes}");
        }, onError: (e) {
          log("Upload error: $e");
        });
        final TaskSnapshot taskSnapshot = await uploadTask;
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();

        log("Image uploaded successfully: $downloadUrl");
        selectedImage.value = downloadUrl;
        isUploading(false);
      } catch (e) {
        log("Upload failed: $e");
        Get.snackbar(
          'Error',
          'Failed to upload image.',
          backgroundColor: kPrimaryColor,
          colorText: kWhiteColor,
        );
        isUploading(false);
      }
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

      if (result is BlogModel1) {
        print("Blog created successfully: ${result.title}");
        fetchAllBlogs();
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

      if (result is BlogModel1) {
        print("Blog updated successfully: ${result.title}");

        fetchAllBlogs();
      } else if (result is Map && result.containsKey("error")) {
        print("Failed to update blog: ${result['error']}");
      }
    } catch (e) {
      print("Exception while updating blog: $e");
    }
  }

  Future<void> approveRejectBlogAsAdmin({
    required String id,
    required String status,
  }) async {
    try {
      final result =
          await _service.statusBlogByAdmin(blogId: id, status: status);

      if (result is BlogModel1) {
        print("Blog updated successfully: ${result.title}");

        fetchAllUserBlogs();
      } else if (result is Map && result.containsKey("error")) {
        print("Failed to update blog: ${result['error']}");
      }
    } catch (e) {
      print("Exception while updating blog: $e");
    }
  }

  Future<void> deleteBlog(String blogId) async {
    try {
      final result = await _service.deleteBlogByAdmin(blogId);

      if (result is String) {
        Get.back();
        Get.snackbar('Success', result,
            backgroundColor: Colors.green, colorText: kWhiteColor);
        await fetchAllUserBlogs();
      } else if (result is Map && result.containsKey('error')) {
        Get.snackbar(
          'Error',
          result['error'].toString(),
          backgroundColor: kPrimaryColor,
          colorText: kWhiteColor,
        );
      } else {
        Get.snackbar(
          'Error',
          'Unexpected error occurred',
          backgroundColor: kPrimaryColor,
          colorText: kWhiteColor,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: kPrimaryColor,
        colorText: kWhiteColor,
      );
    }
  }

  Future<void> deleteBlog1(String blogId) async {
    try {
      final result = await _service.deleteBlogByAdmin(blogId);

      if (result is String) {
        Get.back();
        Get.snackbar('Success', result,
            backgroundColor: Colors.green, colorText: kWhiteColor);
        await fetchAllBlogs();
      } else if (result is Map && result.containsKey('error')) {
        Get.snackbar(
          'Error',
          result['error'].toString(),
          backgroundColor: kPrimaryColor,
          colorText: kWhiteColor,
        );
      } else {
        Get.snackbar(
          'Error',
          'Unexpected error occurred',
          backgroundColor: kPrimaryColor,
          colorText: kWhiteColor,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: kPrimaryColor,
        colorText: kWhiteColor,
      );
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
  var isLoading1 = false.obs;
  final BlogService _service = BlogService();

  Future<void> fetchAllUserBlogs() async {
    try {
      isLoading1(true);
      final List<BlogModel> blogs = [];
      allUserBlogs.clear();
      paginatedUserBlogs.clear();

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
          isLoading1(false);
          break;
        }
      }

      allUserBlogs.assignAll(blogs);
      applyPagination();
      isLoading1(false);
    } catch (e) {
      isLoading1(false);
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
  final RxList<BlogModel> filteredBlogs = <BlogModel>[].obs;
  var isLoading = false.obs;

  final int blogsPerPage = 3;
  final RxInt blogsCurrentPage = 1.obs;
  final RxInt blogTotalPages = 1.obs;

  Future<void> fetchAllBlogs() async {
    try {
      isLoading(true);
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
          isLoading(false);
          break;
        }
      }

      allBlogs.assignAll(blogs);
      applyPagination1();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print("Error fetching all blogs: $e");
    }
  }

  void applyPagination1() {
    final List<BlogModel> baseList =
        filteredBlogs.isNotEmpty || selectedFilters.isNotEmpty
            ? filteredBlogs
            : allBlogs;

    final startIndex = (blogsCurrentPage.value - 1) * blogsPerPage;
    final endIndex = (startIndex + blogsPerPage > baseList.length)
        ? baseList.length
        : startIndex + blogsPerPage;

    paginatedBlogs.value = baseList.sublist(startIndex, endIndex);
  }

  void changeBlogPage(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= blogTotalPages.value) {
      blogsCurrentPage.value = pageNumber;
      applyPagination1();
    }
  }

  void applyCategoryFilters() {
    if (selectedFilters.isEmpty) {
      filteredBlogs.assignAll(allBlogs);
    } else {
      final List<BlogModel> filtered = allBlogs.where((blog) {
        return selectedFilters.contains(blog.category);
      }).toList();

      filteredBlogs.assignAll(filtered);
    }

    blogsCurrentPage.value = 1;
    blogTotalPages.value = (filteredBlogs.length / blogsPerPage)
        .ceil()
        .clamp(1, double.infinity)
        .toInt();
    applyPagination1();
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

  void resetCategoryFilters() {
    selectedFilters.clear();
    filteredBlogs.clear();
    blogsCurrentPage.value = 1;
    blogTotalPages.value = (allBlogs.length / blogsPerPage)
        .ceil()
        .clamp(1, double.infinity)
        .toInt();
    applyPagination1();
  }
}
