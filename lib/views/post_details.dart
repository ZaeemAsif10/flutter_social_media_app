import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/controllers/post_controller.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/views/colors/color.dart';
import 'package:social_media_app/views/widgets/input_widget.dart';
import 'package:social_media_app/views/widgets/post_data.dart';

class PostDetails extends StatefulWidget {
  final PostModel post;
  const PostDetails({super.key, required this.post});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.post.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.post.user!.name!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            PostData(post: widget.post),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(0.0),
              width: double.infinity,
              height: 370,
              child: Obx(
                () {
                  return _postController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: _postController.comments.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                  _postController
                                      .comments.value[index].user!.name!,
                                ),
                                subtitle: Text(_postController
                                    .comments.value[index].body!),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
            InputWidget(
              hintText: "Write a comment...",
              controller: _postController.commentController,
              obsecureText: false,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
              onPressed: () async {
                await _postController.createComment(widget.post.id);
                _postController.getComments(widget.post.id);
              },
              child: Obx(() {
                return _postController.isLoading.value
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: AppColor.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("Comment");
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
