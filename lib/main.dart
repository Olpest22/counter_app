import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Счётчик',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  /// Ключ, под которым значение хранится на устройстве.
  static const _counterKey = 'counter';

  int _counter = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  /// Читает сохранённое значение при запуске приложения.
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _counter = prefs.getInt(_counterKey) ?? 0;
      _isLoading = false;
    });
  }

  /// Увеличивает счётчик и сразу сохраняет новое значение.
  Future<void> _incrementCounter() async {
    setState(() => _counter++);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_counterKey, _counter);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Сохранение состояния'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Вы нажали на кнопку столько раз:'),
                  const SizedBox(height: 8),
                  Text(
                    '$_counter',
                    key: const Key('counterText'),
                    style: theme.textTheme.displayLarge,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    key: const Key('incrementButton'),
                    onPressed: _incrementCounter,
                    icon: const Icon(Icons.add),
                    label: const Text('Нажать'),
                  ),
                ],
              ),
      ),
    );
  }
}
