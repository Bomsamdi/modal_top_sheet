part of 'modal_top_sheet.dart';

/// The top modal sheet.
class ModalTopSheet extends StatefulWidget {
  const ModalTopSheet({
    super.key,
    required this.child,
    this.isDismissible = true,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Whether this modal sheet can be dismissed by tapping the scrim.
  final bool isDismissible;

  @override
  State<ModalTopSheet> createState() => _ModalTopSheetState();
}

class _ModalTopSheetState extends State<ModalTopSheet>
    with TickerProviderStateMixin {
  /// The animation controller for the modal sheet.
  late AnimationController _animationController;

  /// The animation for the modal sheet's background color.
  late Animation<Color?> animatedBackgroundColor;

  /// The animation for the modal sheet's fade.
  late Animation<double> animatedFade;

  /// The animation controller for the modal sheet's fade.
  late AnimationController _animationFadeController;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimation();
  }

  /// Initializes the animations.
  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animatedBackgroundColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.black.withOpacity(0.5),
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    animatedFade = CurvedAnimation(
      parent: _animationFadeController,
      curve: customEaseInExpo,
    );
  }

  /// Starts the animation.
  void _startAnimation() {
    _animationController.forward();
    _animationFadeController.forward();
  }

  @override
  void dispose() {
    /// Dispose the animation controller.
    _animationController.dispose();

    /// Dispose the animation fade controller.
    _animationFadeController.dispose();
    super.dispose();
  }

  /// Hides the modal sheet.
  void _hideSheet() {
    Future.wait([
      _animationController.reverse(),
      _animationFadeController.reverse()
    ])
        .then((List responses) => Navigator.pop(context))
        .catchError((e) => print(e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          _animationController.reverse();
          _animationFadeController.reverse();
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight),
          child: Scaffold(
            backgroundColor: animatedBackgroundColor.value,
            body: GestureDetector(
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: animatedFade,
                          child: Transform.translate(
                            offset: Offset(
                                0.0,
                                -MediaQuery.of(context).size.height *
                                    (1 - _animationController.value)),
                            child: child,
                          ),
                        );
                      },
                      child: widget.child,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: widget.isDismissible ? _hideSheet : null,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
