import 'package:ezdu/data/models/topic_model.dart';
import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final TopicModel topic;
  final bool isSelected;
  final VoidCallback onTap;

  const TopicCard({
    super.key,
    required this.topic,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? Colors.green[50] : Colors.white,
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                topic.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                value: isSelected,
                onChanged: (_) {},
                activeColor: Colors.green,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}