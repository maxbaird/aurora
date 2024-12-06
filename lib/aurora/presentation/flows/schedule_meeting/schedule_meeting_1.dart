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

  late final FocusNode _titleFocusNode;
  late final FocusNode _idFocusNode;

  bool _shiftEnabled = false;
  bool _titleFieldSelected = false;
  bool _fieldSelected = false;

  @override
  void initState() {
    _titleController = TextEditingController();
    _idController = TextEditingController();

    _titleFocusNode = FocusNode();
    _idFocusNode = FocusNode();

    _titleFocusNode.addListener(() {
      if (_titleFocusNode.hasFocus) {
        _fieldSelected = true;
        _titleFieldSelected = true;
      }
    });

    _idFocusNode.addListener(() {
      if (_idFocusNode.hasFocus) {
        _fieldSelected = true;
        _titleFieldSelected = false;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _idController.dispose();
    _titleFocusNode.dispose();
    _idFocusNode.dispose();
    super.dispose();
  }

  void _onSchedulePressed() {
    Navigator.pop(context, '${_titleController.text}, ${_idController.text}');
  }

  void _onCancelPressed() {
    Navigator.pop(context, null);
  }

  dynamic _onKeyPress(VirtualKeyboardKey key) {
    if (!_fieldSelected) {
      return;
    }

    final currentController =
        _titleFieldSelected ? _titleController : _idController;

    if (key.keyType == VirtualKeyboardKeyType.String) {
      currentController.text = currentController.text +
          ((_shiftEnabled ? key.capsText : key.text) ?? '');
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (currentController.text.isEmpty) return;
          currentController.text = currentController.text
              .substring(0, currentController.text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          currentController.text = '${currentController.text}\n';
          break;
        case VirtualKeyboardKeyAction.Space:
          currentController.text = currentController.text + (key.text ?? '');
          break;
        case VirtualKeyboardKeyAction.Shift:
          _shiftEnabled = !_shiftEnabled;
          break;
        default:
      }
    }
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
                  focusNode: _titleFocusNode,
                  controller: _titleController,
                  maxLength: 22,
                  decoration: const InputDecoration(labelText: 'Meeting Title'),
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                width: 150,
                child: TextField(
                  focusNode: _idFocusNode,
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
              postKeyPress: _onKeyPress,
              height: 150,
              textColor: Colors.white,
              fontSize: 12,
              type: VirtualKeyboardType.Alphanumeric,
            ),
          )
        ],
      ),
    );
  }
}
