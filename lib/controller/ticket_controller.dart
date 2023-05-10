import 'package:get/get.dart';

class TicketController extends GetxController {
  bool isContentVisible = false;
  RxInt currentIndex = 0.obs; //현재 선택된 옵션 인덱스
  RxList<bool> isSelected = [true, false].obs; //선택 여부 리스트
  RxBool isNextPageBtnActivated = false.obs; //다음단계 버튼 활성화 여부

  //옵션 선택 핸들러
  handleSelectOption(index) {
    currentIndex.value = index;
    for (var i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
    activateNextPageButton();
  }

  //다음단계 버튼 활성화
  activateNextPageButton() {
    if (currentIndex.value == 1) {
      isNextPageBtnActivated.value = true;
    } else {
      isNextPageBtnActivated.value = false;
    }
  }
}
