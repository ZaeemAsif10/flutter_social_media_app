import 'package:get/get.dart';
import 'package:social_media_app/route/app_route.dart';
import 'package:social_media_app/views/home.dart';
import 'package:social_media_app/views/login_page.dart';
import 'package:social_media_app/views/post_details.dart';
import 'package:social_media_app/views/register_page.dart';

// late PostModel post;

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: AppRoute.login,
    page: () => const LoginPage(),
  ),
  GetPage(
    name: AppRoute.register,
    page: () => const RegisterPage(),
  ),
  GetPage(
    name: AppRoute.home,
    page: () => const HomePage(),
  ),
  // GetPage(
  //   name: AppRoute.postDetail,
  //   page: () => PostDetails(post: post),
  // )
];
