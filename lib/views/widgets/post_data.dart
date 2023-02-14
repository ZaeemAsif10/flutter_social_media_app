import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/controllers/post_controller.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/views/colors/color.dart';
import 'package:social_media_app/views/post_details.dart';

class PostData extends StatefulWidget {
  final PostModel post;
  const PostData({super.key, required this.post});

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(
        left: 10,
        top: 15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.grey1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.user!.name!,
            style: GoogleFonts.poppins(),
          ),
          Text(
            widget.post.user!.email!,
            style: GoogleFonts.poppins(fontSize: 10),
          ),
          const SizedBox(height: 10),
          Text(widget.post.content!),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await _postController.likeAndDislike(widget.post.id);
                  _postController.getAllPosts();
                },
                icon: widget.post.liked! ? 
                const Icon(
                  Icons.thumb_up,
                  color: Colors.blue,
                ):
                const Icon(
                  Icons.thumb_up_alt_outlined,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => PostDetails(post: widget.post));
                },
                icon: const Icon(Icons.comment),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
