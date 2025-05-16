import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../web_services/comment_service.dart';
import '../../../web_services/crime_service.dart';
import '../../models/comment_model.dart';
import '../../models/crime_model.dart';

class CrimeDetailsController extends GetxController {
  final CommentService _commentService = CommentService();
  final CrimeService _crimeService = CrimeService();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController replyController = TextEditingController();
  Rx<CrimeModel> crimeDetailModel = Rx<CrimeModel>(CrimeModel.empty());
  RxList<CommentModel> comments = RxList<CommentModel>();
  RxList<CommentModel> replies = RxList<CommentModel>();
  RxBool isLoading = false.obs,
      isCommentsUpdate = false.obs,
      isReliesUpdate = false.obs,
      isLikeServiceLoading = false.obs,
      isAddCommentHit = false.obs,
      isAddReplyHit = false.obs,
      isRepliesLoading = false.obs;
  RxInt likeCount = 0.obs,commentCount=0.obs;
  RxString userName = "Anonymous".obs,commentLikeId=''.obs,commentFlagId="".obs;

  // void getRepliesToSpecificComments({required String commentId}) async {
  //   if(isRepliesLoading.value) {
  //     return;
  //   }
  //   replies.clear();
  //   isRepliesLoading.value = true;
  //   var result = await _commentService.getRepliesByCommentId(
  //     commentId: commentId,
  //   );
  //   if(result is List<CommentModel>) {
  //     replies.addAll(result);
  //   }
  //   isRepliesLoading.value = false;
  //   isCommentsUpdate.toggle();
  // }

  void getCrimeDetails({required String crimeId}) async {
    if(isLoading.value) {
      return;
    }
    isLoading.value = true;
    var result = await _crimeService.getCrimeById(
      crimeId: crimeId,
    );
    if(result is CrimeModel) {
      crimeDetailModel.value = result;
      comments.addAll(crimeDetailModel.value.comments);
      commentCount.value = comments.length;
      isCommentsUpdate.toggle();
      likeCount.value = crimeDetailModel.value.likes.length;
      if(crimeDetailModel.value.reportedBy.isAnonymousMode) {
        if(crimeDetailModel.value.reportedBy.vigilanteName.isNotEmpty) {
          userName.value = crimeDetailModel.value.reportedBy.vigilanteName;
        }
      } else {
        if(crimeDetailModel.value.reportedBy.name.isNotEmpty) {
          userName.value = crimeDetailModel.value.reportedBy.name;
        }
      }
    }
    isLoading.value =false;
  }

}