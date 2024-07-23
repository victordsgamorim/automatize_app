part of 'side_menu.dart';

class _MenuHeader extends StatefulWidget {
  final AnimationController controller;
  final VoidCallback onPressed;

  const _MenuHeader({
    required this.controller,
    required this.onPressed,
  });

  @override
  State<_MenuHeader> createState() => _MenuHeaderState();
}

class _MenuHeaderState extends State<_MenuHeader> {
  late final Animation<double> _fadeTransition;
  late final Animation<AlignmentGeometry> _alignTransition;
  late final Animation<double> _rotateTransition;

  @override
  void initState() {
    _fadeTransition = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: widget.controller, curve: kAnimationCurve));

    _alignTransition = Tween<AlignmentGeometry>(
            begin: Alignment.centerRight, end: Alignment.center)
        .animate(
      CurvedAnimation(parent: widget.controller, curve: kAnimationCurve),
    );

    _rotateTransition = Tween<double>(begin: 0, end: .5).animate(
        CurvedAnimation(parent: widget.controller, curve: kAnimationCurve));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 56,
      child: Stack(
        children: [
          Positioned(
            left: 4,
            bottom: 0,
            child: FadeTransition(
              opacity: _fadeTransition,
              child: const AutomatizeHeader(label: "Menu"),
            ),
          ),
          AlignTransition(
            alignment: _alignTransition,
            child: AutomatizeButton.square(
              icon: RotationTransition(
                turns: _rotateTransition,
                child: const Icon(Icons.arrow_back_rounded),
              ),
              onPressed: widget.onPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverMenuHeaderDelegate extends SliverPersistentHeaderDelegate {
  final AnimationController controller;
  final VoidCallback onPressed;

  _SliverMenuHeaderDelegate({
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: context.colorScheme.onPrimary,
      child: _MenuHeader(
        controller: controller,
        onPressed: onPressed,
      ),
    );
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
