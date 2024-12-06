import 'package:flutter/material.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class ScheduleMeeting1 extends StatefulWidget {
  const ScheduleMeeting1({super.key});

  @override
  State<ScheduleMeeting1> createState() => _ScheduleMeeting1State();
}

class _ScheduleMeeting1State extends State<ScheduleMeeting1> {
  late final TextEditingController _titleController;
  late final TextEditingController _idController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _idController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _onSchedulePressed() {
    Navigator.pop(context, '${_titleController.text}, ${_idController.text}');
  }

  void _onCancelPressed() {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Aurora',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: TextField(
                  controller: _titleController,
                  maxLength: 22,
                  decoration: const InputDecoration(labelText: 'Meeting Title'),
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                width: 150,
                child: TextField(
                  controller: _idController,
                  maxLength: 4,
                  decoration: const InputDecoration(labelText: 'Employee ID'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _onSchedulePressed,
                child: const Text('Schedule'),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: _onCancelPressed,
                child: const Text('Cancel'),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            color: Colors.green,
            child: VirtualKeyboard(
              height: 150,
              textColor: Colors.white,
              fontSize: 12,
              // builder: _builder,
              type: VirtualKeyboardType.Alphanumeric,
              // postKeyPress: _onKeyPress,
            ),
          )
        ],
      ),
    );
  }
}
