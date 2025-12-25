import 'package:ezdu/data/models/option_model.dart';
import 'package:flutter/material.dart';

class ArchiveOptionsWidget extends StatelessWidget {
  final List<OptionModel> options;
  final int? selectedOption;
  final Function(OptionModel) onSelectOption;

  const ArchiveOptionsWidget({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.onSelectOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        options.length,
        (index) => OptionCardWidget(
          option: options[index],
          isSelected: selectedOption == options[index].id,
          onTap: () => onSelectOption(options[index]),
        ),
      ),
    );
  }
}

class OptionCardWidget extends StatelessWidget {
  final OptionModel option;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCardWidget({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color backgroundColor;
    Color borderColor;

    if (isSelected) {
      backgroundColor = colorScheme.primaryContainer;
      borderColor = colorScheme.primary;
    } else {
      backgroundColor = colorScheme.surfaceContainer;
      borderColor = colorScheme.outline;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 2),
                  color: isSelected ? borderColor : Colors.transparent,
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 16, color: colorScheme.onPrimary)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  option.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
