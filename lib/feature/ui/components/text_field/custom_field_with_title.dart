part of "automatize_textfield.dart";

class _CustomFieldWithTitle extends StatelessWidget {
  final String label;
  final Widget field;

  const _CustomFieldWithTitle({
    super.key,
    required this.label,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        field
      ],
    );
  }
}
