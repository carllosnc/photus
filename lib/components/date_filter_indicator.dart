import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/imports/app.dart';

class DateFilterIndicator extends StatefulWidget {
  const DateFilterIndicator({
    super.key,
  });

  @override
  State<DateFilterIndicator> createState() => _DateFilterIndicatorState();
}

class _DateFilterIndicatorState extends State<DateFilterIndicator> with FilesMixin {
  @override
  Widget build(BuildContext context) {
    if (files.startDate == null) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 40,
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red.shade900,
            Colors.orange.shade800,
          ],
        ),
      ),
      child: Row(
        children: [
          Text(
            DateFormat.yMMMd().format(files.startDate!),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (files.endDate != null)
            Row(
              children: [
                const SizedBox(width: 5),
                const Text("👉"),
                const SizedBox(width: 5),
                Text(
                  DateFormat.yMMMd().format(files.endDate!),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          const Spacer(),
          IconButton(
            onPressed: () {
              files.setRangeDate(
                newEndDate: null,
                newStartDate: null,
              );
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
