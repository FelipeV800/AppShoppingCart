import 'package:get/get.dart';

class MainController extends GetxController {
  var pageIndex = 0.obs;

  setPageIndex (int pageIndex){
    this.pageIndex.value = pageIndex;
  }
}