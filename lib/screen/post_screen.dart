import 'dart:io';

import 'package:dicoding_moments/common.dart';
import 'package:dicoding_moments/model/post_story.dart';
import 'package:dicoding_moments/provider/list_story_provider.dart';
import 'package:dicoding_moments/provider/post_story_provider.dart';
import 'package:dicoding_moments/utils/result_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    super.key,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  _onGalleryView() async {
    final provider = context.read<PostStoryProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final provider = context.read<PostStoryProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.read<PostStoryProvider>().imagePath;
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 25.0,
      ),
      child: kIsWeb
          ? Image.network(
              imagePath.toString(),
              fit: BoxFit.contain,
            )
          : Image.file(
              File(imagePath.toString()),
              fit: BoxFit.contain,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PostStoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.postTitleAppBar ?? "New Story",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              final ScaffoldMessengerState scaffoldMessengerState =
                  ScaffoldMessenger.of(context);

              if (provider.imagePath != null && provider.imageFile != null) {
                PostStoryModel postStoryModel = PostStoryModel(
                  description: descriptionController.text,
                  imagePath: provider.imagePath!,
                  imageFile: provider.imageFile!,
                );
                final result = await provider.postStory(postStoryModel);
                if (result && context.mounted) {
                  context.read<ListStoryProvider>().refreshStories();
                  Navigator.pop(context, provider.result);
                } else {
                  scaffoldMessengerState.showSnackBar(
                    SnackBar(
                      content: Text(
                        provider.message,
                      ),
                    ),
                  );
                }
              } else {
                scaffoldMessengerState.showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Pick image and description',
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: provider.state == ResultState.loading
                ? const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    AppLocalizations.of(context)!.postButtonText,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            context.watch<PostStoryProvider>().imagePath == null
                ? Icon(
                    Icons.photo,
                    size: MediaQuery.of(context).size.width,
                  )
                : _showImage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _onGalleryView(),
                  icon: const Icon(Icons.photo_library),
                  label: Text(
                    AppLocalizations.of(context)?.galleryButtonPostTitle ??
                        "Gallery",
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _onCameraView(),
                  icon: const Icon(Icons.camera_alt_rounded),
                  label: Text(
                    AppLocalizations.of(context)?.cameraButtonPostTitle ??
                        "Camera",
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                              ?.handleEmptyTextDescriptionPost ??
                          'Please enter description.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)?.hintTextDescriptionPost ??
                            "Description",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
