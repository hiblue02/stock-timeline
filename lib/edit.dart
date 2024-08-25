import 'package:flutter/material.dart';
import 'package:ui/app_function.dart';
import 'package:ui/model/data.dart';

Future<void> edit(BuildContext context, ChartData chart) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // 사용자가 다이얼로그 밖을 클릭해도 다이얼로그가 닫히도록 설정
    builder: (BuildContext context) {
      return _EditDialog(chart: chart);
    },
  );
}

class _EditDialog extends StatefulWidget {
  final ChartData chart;

  const _EditDialog({required this.chart});

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<_EditDialog> {
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.chart.title);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chart Data Update'),
      content: Container(
        width: 600, // 원하는 너비
        height: 150, // 원하는 높이
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Enter new title'),
              ),
            ),
            const SizedBox(width: 16), // 간격을 조정합니다
            ElevatedButton(
                onPressed: () {
                  uploadExcel();
                },
                child: const Text(
                  ("Upload File"),
                ))
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // 제목을 업데이트하고 다이얼로그를 닫습니다
            setState(() {
              widget.chart.title = titleController.text;
            });
            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // 다이얼로그를 닫습니다
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
