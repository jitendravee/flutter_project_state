import 'package:flutter/material.dart';
import 'package:red_core/model/git_repo_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoListViewChildContainer extends StatelessWidget {
  final String description;
  final int commentCount;
  final Owner ownerData;
  final String createdDate;
  final String updatedDate;

  const RepoListViewChildContainer({
    super.key,
    required this.description,
    required this.commentCount,
    required this.createdDate,
    required this.updatedDate,
    required this.ownerData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showOwnerDetailsPopup(context),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              // Comment Count with Icon
              Row(
                children: [
                  Icon(
                    Icons.comment,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$commentCount comments',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDateInfo("Created:", createdDate),
                  _buildDateInfo("Updated:", updatedDate),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateInfo(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  void _showOwnerDetailsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            ownerData.login ?? "Owner",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (ownerData.avatarUrl != null)
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(ownerData.avatarUrl!),
                ),
              const SizedBox(height: 16),
              Text(
                'ID: ${ownerData.id}',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                'Type: ${ownerData.type ?? "N/A"}',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 8),
              if (ownerData.htmlUrl != null)
                InkWell(
                  onTap: () => _launchURL(ownerData.htmlUrl!),
                  child: Text(
                    'Profile',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
