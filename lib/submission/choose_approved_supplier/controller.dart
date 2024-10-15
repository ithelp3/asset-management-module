import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ChooseApprovedSupplierController extends GetxController {
  Rx<PurchaseOrderSubmission> submission = PurchaseOrderSubmission().obs;
  RxList<SubmissionSuppliers> suppliers = <SubmissionSuppliers>[].obs;
  Rx<SubmissionSuppliers> selectedSupplier = SubmissionSuppliers().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    submission.value = Get.arguments['data'];
    await DioClient().get('/purchaseorder/submission-suppliers/${submission.value.id}',
    ).then((res) => suppliers.value = List.from(res['data'].map((json) => SubmissionSuppliers.fromJson(json))));
  }

  void downloadFile(SubmissionSuppliers item) async {
    Uri url = Uri.parse(item.fileUrl!);
    if(!await launchUrl(url)) {
      throw Exception('Oppss..');
    }
  }
}
