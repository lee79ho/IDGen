import 'package:flutter/material.dart';
import 'package:poc_app/core/api_service.dart';

/// A modal bottom sheet that informs the user about a required or optional app update.
///
/// This widget is displayed from the [SplashPage] if the `ApiService`
/// indicates that an update is available.
void showUpdateBottomSheet(BuildContext context, UpdateStatus status, VoidCallback onConfirm) {
  showModalBottomSheet(
    context: context,
    isDismissible: status == UpdateStatus.optionalUpdate,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              status == UpdateStatus.forceUpdate
                  ? 'New version available'
                  : 'Update Recommended',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text(
              'A new version of the app is available. Please update to continue.',
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (status == UpdateStatus.optionalUpdate)
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Later'),
                  ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: onConfirm,
                  child: const Text('Update Now'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
