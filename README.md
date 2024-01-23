# ModalTopSheet

[![Pub](https://img.shields.io/pub/v/modal_top_sheet.svg)](https://pub.dev/packages/modal_top_sheet)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![pub points](https://img.shields.io/pub/points/modal_top_sheet)](https://pub.dev/packages/modal_top_sheet/score) 
[![popularity](https://img.shields.io/pub/popularity/modal_top_sheet)](https://pub.dev/packages/modal_top_sheet/score)

[ModalTopSheet] A Flutter package for creating top-aligned modal sheets. This package not extends the modal sheet functionality in Flutter to allow for a more flexible and customizable user interface. The effect is like [AppBar] dropdown for example.

## Features

https://github.com/Bomsamdi/modal_top_sheet/assets/94292009/4612353d-3f33-4dc1-ac31-621fdccec81d

## Installation

Include your package in your `pubspec.yaml` file:

```yaml
dependencies:
  modal_top_sheet: ^0.0.1
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:modal_top_sheet/modal_top_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void openModal() async => showModalTopSheet(
        context,
        isDismissible: false,
        child: const YourModalWidget(),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSubtitle(
        titleSection: InkWell(
            onTap: openModal,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Modal Sheet Example',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Tap to expand',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            )),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
            itemCount: 20,
          ),
        ],
      ),
    );
  }
}
```

Full example usage in `/example` folder.

## Issues and Bugs

Report any issues or bugs on the GitHub issues page.

## License

This package is licensed under the MIT License.

## Support

For any questions or assistance, please contact the author.
