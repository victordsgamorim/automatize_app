import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/utils/extensions/build_context_extension.dart';

class Body extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const Body({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            context.colorScheme.onPrimary,
            const Color(0xffD6E3FF).withOpacity(.5)
          ])),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
