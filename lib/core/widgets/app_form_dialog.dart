import 'package:flutter/material.dart';
import 'package:security_app/core/widgets/my_button.dart';

class AppFormDialog extends StatelessWidget {
  const AppFormDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.primaryText,
    required this.onPrimaryPressed,
    this.primaryIcon,
    this.isPrimaryLoading = false,
    this.canClose = true,
  });

  final String title;
  final String subtitle;
  final Widget child;

  final String primaryText;
  final Widget? primaryIcon;
  final VoidCallback onPrimaryPressed;
  final bool isPrimaryLoading;

  final bool canClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Material(
          elevation: 12,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (canClose)
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        splashRadius: 18,
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Body (dynamic form fields)
                Flexible(child: SingleChildScrollView(child: child)),

                const SizedBox(height: 20),
                MyButton(text: primaryText, onPressed: onPrimaryPressed),

                // Primary button
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton.icon(
                //     onPressed: isPrimaryLoading ? null : onPrimaryPressed,
                //     icon: isPrimaryLoading
                //         ? const SizedBox(
                //             width: 18,
                //             height: 18,
                //             child: CircularProgressIndicator(strokeWidth: 2),
                //           )
                //         : (primaryIcon ?? const SizedBox.shrink()),
                //     label: Text(primaryText),
                //     style: ElevatedButton.styleFrom(
                //       padding: const EdgeInsets.symmetric(vertical: 14),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

InputDecoration appInputDecoration({String? hint, Widget? suffixIcon}) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.grey.shade100,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    suffixIcon: suffixIcon,
  );
}
