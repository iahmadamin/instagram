import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';

class AddPostController extends GetxController {
  var mediaList = [].obs;
  int selectedImageIndex = 0;
  int selectedCategory = 0;

  @override
  void onInit() {
    _fetchNewMedia();
    super.onInit();
  }

  void updateCategory(int index) {
    selectedCategory = index;
    update();
  }

  void updateSelectedImageIndex(int index) {
    selectedImageIndex = index;
    update();
  }

  _fetchNewMedia() async {
    final result = await PhotoManager.requestPermission();
    if (result) {
      // success//load the album list
      final List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      final List<AssetEntity> media = await albums[0].getAssetListPaged(0, 50);
      mediaList.assignAll(media);
    } else {
      // fail
      /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
    }
  }
}
