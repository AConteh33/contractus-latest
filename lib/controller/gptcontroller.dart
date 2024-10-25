import 'package:contractus/service/gptservice.dart';
import 'package:get/get.dart';

class GptController extends GetxController {
  var input = ''.obs;
  var contract = ''.obs;
  var isLoading = false.obs;

  final GptService _gptService = GptService();

  void generateContract() async {
    if (input.isNotEmpty) {
      isLoading.value = true;
      try {
        contract.value = await _gptService.generateContract(input.value);
      } catch (e) {
        Get.snackbar('Error', e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }
}
