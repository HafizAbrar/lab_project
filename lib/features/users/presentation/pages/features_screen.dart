import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/feature_dto.dart';
import '../providers/users_providers.dart';
import 'actions_screen.dart';

class FeaturesScreen extends ConsumerWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuresAsync = ref.watch(allFeaturesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("All Features")),
      body: featuresAsync.when(
        data: (features) {
          if (features.isEmpty) {
            return const Center(child: Text("No features available"));
          }
          return ListView.builder(
            itemCount: features.length,
            itemBuilder: (context, index) {
              final FeatureDto feature = features[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    feature.feature,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,color: Colors.green,),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FeatureActionsScreen(feature: feature),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(
          child: Text("❌ Error: $err"),
        ),
      ),
    );
  }
}
