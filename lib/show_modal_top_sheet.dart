part of 'modal_top_sheet.dart';

/// Method to shows a [ModalTopSheet].
void showModalTopSheet(
  BuildContext context, {
  required Widget child,
  bool isDismissible = true,
}) {
  Navigator.of(context).push(PageRouteBuilder(
    barrierDismissible: true,
    opaque: false,
    pageBuilder: (BuildContext context, _, __) {
      return ModalTopSheet(
        isDismissible: isDismissible,
        child: child,
      );
    },
  ));
}
