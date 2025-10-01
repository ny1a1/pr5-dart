import 'package:flutter/material.dart';
import 'widgets/app_button.dart';
import 'widgets/app_input.dart';
import 'widgets/app_select.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Widgets Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Widgets")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppButton(
              label: "Login",
              onPressed: () => print("Login Pressed"),
              type: AppButtonType.online,
              backgroundColor: Colors.green,
            ),
            const SizedBox(height: 16),
            AppInput(
              hint: "Enter your name",
              controller: _controller,
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 16),
            AppSelect<String>(
              hint: "Choose option",
              value: _selectedValue,
              items: const [
                DropdownMenuItem(value: "1", child: Text("Option 1")),
                DropdownMenuItem(value: "2", child: Text("Option 2")),
              ],
              onChanged: (val) {
                setState(() => _selectedValue = val);
              },
            ),
          ],
        ),
      ),
    );
  }
}