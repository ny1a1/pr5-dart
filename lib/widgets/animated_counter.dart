import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int initialValue;
  final int maxValue;
  final Duration animationDuration;
  final Color? primaryColor;

  const AnimatedCounter({
    Key? key,
    this.initialValue = 0,
    this.maxValue = 100,
    this.animationDuration = const Duration(milliseconds: 300),
    this.primaryColor,
  }) : super(key: key);

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin {
  late int _counter;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;

    _scaleController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );

    _colorController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _colorAnimation = ColorTween(
      begin: widget.primaryColor ?? Colors.blue,
      end: Colors.red,
    ).animate(_colorController);

    _progressController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: _counter / widget.maxValue,
    );
    _progressAnimation = Tween<double>(
      begin: _counter / widget.maxValue,
      end: _counter / widget.maxValue,
    ).animate(_progressController);
  }

  void _updateCounter(int delta) {
    final newValue = (_counter + delta).clamp(0, widget.maxValue);
    if (newValue == _counter) return;

    setState(() {
      _counter = newValue;
    });

    _scaleController.forward(from: 0.0);

    if (_counter == widget.maxValue) {
      _colorController.forward();
    } else {
      _colorController.reverse();
    }

    _progressAnimation = Tween<double>(
      begin: _progressController.value,
      end: _counter / widget.maxValue,
    ).animate(_progressController);

    _progressController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _colorController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: Listenable.merge([_scaleController, _colorController]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _colorAnimation.value,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: _progressAnimation.value,
              backgroundColor: Colors.grey[300],
              color: _colorAnimation.value,
              minHeight: 8,
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBounceButton(Icons.remove, () => _updateCounter(-1)),
            const SizedBox(width: 20),
            _buildBounceButton(Icons.add, () => _updateCounter(1)),
          ],
        ),
      ],
    );
  }

  Widget _buildBounceButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.elasticOut,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.primaryColor ?? Colors.blue,
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}