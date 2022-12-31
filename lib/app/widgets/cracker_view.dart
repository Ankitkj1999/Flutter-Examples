import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class FireWorkAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const FireWorkAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(seconds: 1)})
      : super(key: key);

  @override
  State<FireWorkAnimation> createState() => _FireWorkAnimationState();
}

class _FireWorkAnimationState extends State<FireWorkAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value * 200),
          child: child,
        );
      },
    );
  }
}
