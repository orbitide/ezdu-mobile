import 'package:ezdu/data/models/subject_model.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatefulWidget {
  final SubjectModel subject;
  final Color cardColor;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.onTap,
    required this.cardColor,
  });

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = widget.cardColor;

    return GestureDetector(
      onTapDown: (_) => {},
      onTapUp: (_) {
        widget.onTap();
      },
      onTapCancel: () => {},
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.brightness == Brightness.dark
              ? cardColor.withValues(alpha: 0.25)
              : cardColor,
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? cardColor.withValues(alpha: 0.5)
                : cardColor.withValues(alpha: 0.4),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.brightness == Brightness.dark
                  ? cardColor.withValues(alpha: 0.25)
                  : cardColor.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.subject,
                    color: theme.brightness == Brightness.dark
                        ? cardColor
                        : _getTextColor(cardColor).withValues(alpha: 0.8),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subject.name,
                        style: TextStyle(
                          color: theme.brightness == Brightness.dark
                              ? Colors.white
                              : _getTextColor(cardColor),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.subject.code,
                        style: TextStyle(
                          color: theme.brightness == Brightness.dark
                              ? Colors.white70
                              : _getTextColor(cardColor).withValues(alpha: 0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Icon(
                Icons.chevron_right,
                color: theme.brightness == Brightness.dark
                    ? cardColor
                    : _getTextColor(cardColor).withValues(alpha: 0.8),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getTextColor(Color bgColor) {
  final luminance = bgColor.computeLuminance();
  return luminance > 0.5 ? Colors.black87 : Colors.white;
}
