import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod_demo/common/http/http_manager_nullsafe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nanoid/non_secure.dart';
import 'package:path_provider/path_provider.dart';

class TestDio extends ConsumerWidget {
  const TestDio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("dio test"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("get 请求"),
            onTap: () async {
              await HttpManager().getAsync<Map<String, dynamic>>(
                "/get",
                params: {"age": 12, "name": "zs"},
              );
            },
          ),
          ListTile(
            title: const Text("post 表单 请求"),
            onTap: () async {
              final formData = FormData.fromMap({
                'name': 'dio',
                'date': DateTime.now().toIso8601String(),
              });

              await HttpManager().postAsync<Map<String, dynamic>>(
                "/post",
                data: formData,
              );
            },
          ),
          ListTile(
            title: const Text("post json 请求"),
            onTap: () async {
              await HttpManager().postAsync<Map<String, dynamic>>(
                "/post",
                data: {"age": 12, "name": "zs"},
              );
            },
          ),
          ListTile(
            title: const Text("上传文件"),
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              // Pick an image.
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);

              debugPrint("image === ${image?.path}");

              if (image == null) return;

              final id = nanoid(10);

              final temp = await FlutterImageCompress.compressAndGetFile(
                  image.path,
                  "${(await getTemporaryDirectory()).path}/compose_img_$id.jpg");

              final formData = FormData.fromMap({
                'name': 'dio',
                'date': DateTime.now().toIso8601String(),
                'file': await MultipartFile.fromFile(temp!.path,
                    filename: image.name),
              });
              await HttpManager().uploadAsync("/post",
                  data: formData,
                  onSendProgress: ((count, total) =>
                      debugPrint("count $count ==== total $total")));
            },
          ),
          ListTile(
            title: const Text("下载文件"),
            onTap: () async {
              final id = nanoid(10);

              final path =
                  "${(await getTemporaryDirectory()).path}/img_$id.jpg";

              await HttpManager().downloadAsync(
                "https://gss0.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/b03533fa828ba61eb14e6fa24734970a314e599e.jpg",
                savePath: path,
                onReceiveProgress: (count, total) =>
                    debugPrint("count $count ==== total $total"),
              );
            },
          ),
        ],
      ),
    );
  }
}
