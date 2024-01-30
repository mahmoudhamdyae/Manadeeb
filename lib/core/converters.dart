import '../presentation/resources/strings_manager.dart';

String convertSaff(String saff, String data) {
  switch(saff) {
    case AppStrings.saff6:
      return '${data}six';
    case AppStrings.saff7:
      return '${data}seven';
    case AppStrings.saff8:
      return '${data}eight';
    case AppStrings.saff9:
      return '${data}nine';
    case AppStrings.saff10:
      return '${data}ten';
    case AppStrings.saff11:
      return '${data}eleven';
    case AppStrings.saff12:
      return '${data}twelve';
    default:
      return '';
  }
}