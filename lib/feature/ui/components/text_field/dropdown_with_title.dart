part of 'automatize_textfield.dart';

class DropdownWithTitle extends StatefulWidget {
  final String? hint;
  final StateType? initValue;
  final String label;
  final List<StateType> items;
  final ValueChanged<StateType?>? onChanged;
  final FormFieldValidator<StateType>? validator;

  const DropdownWithTitle({
    super.key,
    required this.label,
    required this.items,
    this.onChanged,
    this.initValue,
    this.validator,
    this.hint,
  });

  @override
  State<DropdownWithTitle> createState() => _DropdownWithTitleState();
}

class _DropdownWithTitleState extends State<DropdownWithTitle> {
  StateType? _selectedValue;

  @override
  void initState() {
    _selectedValue = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _CustomFieldWithTitle(
      label: widget.label,
      field: DropdownButtonFormField2<StateType>(
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        hint: widget.hint != null ? Text(widget.hint!) : null,
        items: widget.items
            .map((item) => DropdownMenuItem<StateType>(
                  value: item,
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: _selectedValue,
        validator: widget.validator,
        onChanged: (value) {
          _selectedValue = value;
          widget.onChanged?.call(value);
        },
        iconStyleData: const IconStyleData(
          icon: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black45,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
