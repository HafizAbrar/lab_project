// lib/features/projects/presentation/screens/project_details_screen.dart

import 'package:flutter/material.dart';
import '../../data/models/project_dto.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectDto project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Detail"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------ IMAGES ------------
            if (project.images.isNotEmpty)
              SizedBox(
                height: 220,
                child: PageView.builder(
                  itemCount: project.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          project.images[index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 20),

            // ------------ NAME ------------
            Text(
              project.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // ------------ DESCRIPTION ------------
            Text(
              project.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // ------------ DETAILS ------------
            _infoRow("Status", project.status),
            _infoRow("Budget", project.budget.toString()),
            _infoRow("Start Date", project.startDate),
            _infoRow("End Date", project.endDate),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
