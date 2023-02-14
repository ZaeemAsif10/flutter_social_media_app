import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/models/comment_model.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/views/colors/color.dart';

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<CommentModel>> comments = Rx<List<CommentModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();
  final TextEditingController textController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('${url}feeds'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['feeds'];
        for (var item in content) {
          posts.value.add(PostModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      e.toString();
    }
  }

  Future createPost() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var data = {
        'content': textController.text.trim(),
      };

      var response = await http.post(
        Uri.parse('${url}feed/store'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        textController.clear();
        getAllPosts();
        print(jsonDecode(response.body));
      } else {
        isLoading.value = false;
        getAllPosts();
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.red,
          colorText: AppColor.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      e.toString();
    }
  }

  Future getComments(id) async {
    try {
      comments.value.clear();
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('${url}feed/comments/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        var data = jsonDecode(response.body);
        var content = data['comments'];
        for (var item in content) {
          comments.value.add(CommentModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(jsonDecode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      e.toString();
    }
  }

  Future createComment(id) async {
    try {
      isLoading.value = true;
      var data = {
        'body': commentController.text.trim(),
      };

      var response = await http.post(
        Uri.parse('${url}feed/comment/$id'),
        body: data,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        commentController.clear();
        print(jsonDecode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future likeAndDislike(id) async {
    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse('${url}feed/like/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 || data['message'] == 'liked') {
        isLoading.value = false;
        print(jsonDecode(response.body));
      } else if (response.statusCode == 200 || data['message'] == 'Unliked') {
        isLoading.value = false;
        print(jsonDecode(response.body));
      } else {
        isLoading.value = false;
        print(jsonDecode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
