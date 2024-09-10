import 'package:flutter/material.dart';
import 'package:promoter/core/utils/styles.dart';

import '../../../generated/l10n.dart';

// import '../../../../../generated/l10n.dart';

class CustomSearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String) onchange; // New callback

  const CustomSearchWidget({
    super.key,
    required this.searchController,
    required this.onchange, // Pass the callback
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white38,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    controller: searchController,
                    onChanged: onchange,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).search,
                      hintStyle: Styles.textStyle16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
