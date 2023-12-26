import 'package:qi_services/common_lib.dart';

enum _ButtonVariant { filled, text }

class ButtonLoading extends StatelessWidget {
  const ButtonLoading.filled({super.key}) : _type = _ButtonVariant.filled;
  const ButtonLoading.text({super.key}) : _type = _ButtonVariant.text;

  final _ButtonVariant _type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final Color foregroundColor = switch (_type) {
      _ButtonVariant.filled => colorScheme.onPrimary,
      _ButtonVariant.text => colorScheme.primary,
    };

    return SizedBox.square(
      dimension: IconSizes.small,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: StrokeWidths.small,
          color: foregroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
        ),
      ),
    );
  }
}
