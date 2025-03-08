import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Web Responsive App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<String> message;

  @override
  void initState() {
    super.initState();
    message = ApiService().fetchMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
        actions: [
          ResponsiveMenu(),
        ],
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: message,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text(
                snapshot.data ?? 'No message received',
                style: const TextStyle(fontSize: 24),
              );
            }
          },
        ),
      ),
    );
  }
}

class ResponsiveMenu extends StatelessWidget {
  const ResponsiveMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              MenuItem(title: 'About', route: AboutPage()),
              MenuItem(title: 'Research', route: ResearchPage()),
              MenuItem(title: 'Programming', route: ProgrammingPage()),
              MenuItem(title: 'Life', route: LifePage()),
              MenuItem(title: 'Contact', route: ContactPage()),
            ],
          );
        } else {
          return PopupMenuButton<String>(
            onSelected: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => getPage(value)),
              );
            },
            itemBuilder: (context) => [
              'About', 'Research', 'Programming', 'Life', 'Contact'
            ].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList(),
          );
        }
      },
    );
  }
  Widget getPage(String title) {
    switch (title) {
      case 'About':
        return AboutPage();
      case 'Research':
        return ResearchPage();
      case 'Programming':
        return ProgrammingPage();
      case 'Life':
        return LifePage();
      case 'Contact':
        return ContactPage();
      default:
        return const MyHomePage(title: 'Flutter Web Responsive');
    }
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final Widget route;

  const MenuItem({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Center(child: Text('This is the About Page')),
    );
  }
}

class ResearchPage extends StatelessWidget {
  const ResearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Research')),
      body: const Center(child: Text('This is the Research Page')),
    );
  }
}

class ProgrammingPage extends StatelessWidget {
  const ProgrammingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Programming')),
      body: const Center(child: Text('This is the Programming Page')),
    );
  }
}

class LifePage extends StatelessWidget {
  const LifePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Life')),
      body: const Center(child: Text('This is the Life Page')),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: const Center(child: Text('This is the Contact Page')),
    );
  }
}
