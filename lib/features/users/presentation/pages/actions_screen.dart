import 'package:flutter/material.dart';
import '../../data/models/feature_dto.dart';

class FeatureActionsScreen extends StatelessWidget {
  final FeatureDto feature;

  const FeatureActionsScreen({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${feature.feature}")),
      body: feature.actions.isEmpty
          ? const Center(child: Text("No actions available"))
          : ListView.builder(
        itemCount: feature.actions.length,
        itemBuilder: (context, index) {
          final action = feature.actions[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.check_circle_outline,color: Colors.green,),
              title: Text(action),
            ),
          );
        },
      ),
    );
  }
}
