import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class JobDetailsScreenSkeleton extends StatelessWidget {
  const JobDetailsScreenSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJobCardSkeleton(),
            Divider(height: 32, color: Colors.grey.shade300),
            _buildSectionHeader(),
            const SizedBox(height: 8),
            _buildLines(5),
            Divider(height: 32, color: Colors.grey.shade300),
            _buildSectionHeader(),
            const SizedBox(height: 8),
            _buildLines(5),
            Divider(height: 32, color: Colors.grey.shade300),
            _buildSectionHeader(),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                5,
                (index) => Container(
                  width: 60,
                  height: 30,
                  margin: const EdgeInsets.only(right: 8.0),
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            Divider(height: 32, color: Colors.grey.shade300),
            _buildSectionHeader(),
            const SizedBox(height: 8),
            _buildLines(3),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCardSkeleton() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            width: 150,
            height: 20,
            color: Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Container(
            width: 100,
            height: 16,
            color: Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 16),
        Divider(thickness: 0.3, color: Colors.grey.shade300),
        const SizedBox(height: 16),
        Center(
          child: Container(
            width: 100,
            height: 16,
            color: Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                width: 60,
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            width: 100,
            height: 16,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader() {
    return Container(
      width: 200,
      height: 20,
      color: Colors.grey.shade300,
    );
  }

  Widget _buildLines(int count) {
    return Column(
      children: List.generate(
        count,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
