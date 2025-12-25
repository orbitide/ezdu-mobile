import 'package:equatable/equatable.dart';

class ArchiveQuizSettingsModel extends Equatable {
  final int timeInMinutes;
  final bool enableNegativeMarking;
  final double negativeMarkValue;

  const ArchiveQuizSettingsModel({
    required this.timeInMinutes,
    required this.enableNegativeMarking,
    required this.negativeMarkValue,
  });

  @override
  List<Object?> get props => [
    timeInMinutes,
    enableNegativeMarking,
    negativeMarkValue,
  ];
}
