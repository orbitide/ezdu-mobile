import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:flutter/material.dart';
import '../widgets/subject_card.dart';

class SubjectSelectionPage extends StatelessWidget {
  final Future<ApiResponse<PagedList<SubjectModel>>> subjectListFuture;
  final Function(SubjectModel) onSubjectSelected;

  const SubjectSelectionPage({
    super.key,
    required this.subjectListFuture,
    required this.onSubjectSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Choose Subject'),
        centerTitle:false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FutureBuilder<ApiResponse<PagedList<SubjectModel>>>(
              future: subjectListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text('Loading subjects...'),
                        ),
                      ],
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Error loading data: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (snapshot.hasData &&
                    snapshot.data!.data != null &&
                    snapshot.data!.data!.items.isNotEmpty) {
                  final subjects = snapshot.data!.data!.items;

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SubjectCard(
                          subject: subject,
                          onTap: () => onSubjectSelected(subject),
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: Text('No subjects found.'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}