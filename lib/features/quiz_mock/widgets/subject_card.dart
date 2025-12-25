import 'package:ezdu/data/models/subject_model.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatefulWidget {
  final SubjectModel subject;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.onTap,
  });

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.97);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Adaptive colors
    final bgColor = isDark
        ? theme.colorScheme.surfaceContainerHighest.withOpacity(0.4)
        : theme.colorScheme.primaryContainer;

    final borderColor = theme.colorScheme.outline.withOpacity(0.3);
    final textColor = theme.colorScheme.onPrimaryContainer;
    final iconColor = theme.colorScheme.onPrimaryContainer.withOpacity(0.9);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? bgColor : null,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.subject.name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: isDark ? theme.colorScheme.onSurface : textColor,
                  ),
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isDark
                    ? theme.colorScheme.onSurfaceVariant
                    : iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
