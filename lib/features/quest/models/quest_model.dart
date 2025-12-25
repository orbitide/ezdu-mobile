import 'package:flutter/material.dart';

class QuestModel {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final int currentProgress;
  final int targetProgress;
  final QuestType type; // daily, weekly
  final IconData icon;
  final Color color;
  final bool completed;

  QuestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.currentProgress,
    required this.targetProgress,
    required this.type,
    required this.icon,
    required this.color,
    required this.completed,
  });

  double get progress => (currentProgress / targetProgress).clamp(0, 1);
  bool get isComplete => currentProgress >= targetProgress;
}

enum QuestType { daily, weekly }
