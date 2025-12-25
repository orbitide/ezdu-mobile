class UserQuizSubmissionModel {
  final int quizType;
  final int quizId;
  final int markPercentage;

  UserQuizSubmissionModel({
    required this.quizType,
    required this.quizId,
    required this.markPercentage,
  });



  Map<String, dynamic> toJson() {
    return {
      'quizType': quizType,
      'quizId': quizId,
      'markPercentage': markPercentage,
    };
  }
}
