import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, destructive }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    final ButtonStyle style = switch (variant) {
      AppButtonVariant.primary => ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: colors.primary.withValues(alpha: 0.5),
        ),
      AppButtonVariant.secondary => OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary),
          disabledForegroundColor: colors.primary.withValues(alpha: 0.5),
        ),
      AppButtonVariant.destructive => ElevatedButton.styleFrom(
          backgroundColor: colors.error,
          foregroundColor: colors.onError,
          disabledBackgroundColor: colors.error.withValues(alpha: 0.5),
        ),
    };

    final Widget child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == AppButtonVariant.secondary
                  ? colors.primary
                  : colors.onPrimary,
            ),
          )
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                  Text(label),
                ],
              )
            : Text(label);

    final VoidCallback? effectiveOnPressed =
        isLoading ? null : onPressed;

    return switch (variant) {
      AppButtonVariant.secondary => SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: effectiveOnPressed,
            style: style,
            child: child,
          ),
        ),
      _ => SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: effectiveOnPressed,
            style: style,
            child: child,
          ),
        ),
    };
  }
}
