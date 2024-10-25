import 'package:asset_management_module/model/purchase_order_submission.dart';
import 'package:asset_management_module/model/submission_suppliers.dart';
import 'package:asset_management_module/submission/dialog_reason/view.dart';
import 'package:asset_management_module/utils/data/client.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ChooseApprovedSupplierController extends GetxController {
  Rx<PurchaseOrderSubmission> submission = PurchaseOrderSubmission().obs;
  Rx<SubmissionSuppliers> supplierData = SubmissionSuppliers().obs;
  Rx<SupplierRelations> selectedSupplier = SupplierRelations().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    submission.value = Get.arguments['data'];
    await DioClient().get('/submission/suppliers/${submission.value.id}').then((res)
      => supplierData.value = SubmissionSuppliers.fromJson(res['data']));
  }

  void downloadFile(SupplierRelations item) async {
    Uri url = Uri.parse(item.fileUrl!);
    if(!await launchUrl(url)) {
      throw Exception('Oppss..');
    }
  }

  void save() async {
    final result = await Get.dialog(const DialogReasonPage(),
        arguments: {
          'type': 'approve_level_2',
          'data': submission.value,
          'selected_supplier': selectedSupplier.value,
        }
    );
    if(result == null) return;

    Get.back(result: true);
  }
}