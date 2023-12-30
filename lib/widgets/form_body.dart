import 'package:qi_services/common_lib.dart';

class FormBody extends StatelessWidget {
  const FormBody({
    super.key,
    required this.formKey,
    this.padding = EdgeInsets.zero,
    this.spacing = 0.0,
    this.alignment = Alignment.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisSize = MainAxisSize.min,
    this.maxWidth,
    required this.children,
  });

  final Alignment alignment;

  final EdgeInsets padding;

  final double spacing;

  final GlobalKey<FormState> formKey;

  final MainAxisAlignment mainAxisAlignment;

  final CrossAxisAlignment crossAxisAlignment;

  final MainAxisSize mainAxisSize;

  final List<Widget> children;

  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    Widget current = SingleChildScrollView(
      padding: padding,
      child: Form(
        key: formKey,
        child: ColumnPadded(
          spacing: spacing,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: children,
        ),
      ),
    );

    if (maxWidth != null) {
      current = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: current,
      );
    }

    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: current,
      ),
    );
  }
}
