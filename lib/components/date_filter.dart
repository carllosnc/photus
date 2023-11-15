import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '/imports/app.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.calendar_month_outlined,
      ),
      iconSize: 20,
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return const DateContent();
          },
        );
      },
    );
  }
}

class DateContent extends StatefulWidget {
  const DateContent({
    super.key,
  });

  @override
  State<DateContent> createState() => _DateContentState();
}

class _DateContentState extends State<DateContent> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfDateRangePicker(
            onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
              setState(() {
                _startDate = dateRangePickerSelectionChangedArgs.value.startDate;
                _endDate = dateRangePickerSelectionChangedArgs.value.endDate;
              });
            },
            initialDisplayDate: DateTime.now(),
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.range,
            headerStyle: const DateRangePickerHeaderStyle(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            headerHeight: 70,
            rangeTextStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButton(
                  onPressed: () {
                    files.setRangeDate(
                      newEndDate: _endDate,
                      newStartDate: _startDate,
                    );

                    Navigator.pop(context);
                  },
                  child: const Text("Filtrate"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
