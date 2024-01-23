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

class AppBarWithSubtitle extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarWithSubtitle({
    Key? key,
    required this.titleSection,
  }) : super(key: key);
  final Widget titleSection;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: kToolbarHeight),
                child: CustomSingleChildLayout(
                  delegate: const _ToolbarContainerLayout(kToolbarHeight),
                  child: Container(
                    color: theme.appBarTheme.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(child: titleSection),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ToolbarContainerLayout extends SingleChildLayoutDelegate {
  const _ToolbarContainerLayout(this.toolbarHeight);

  final double toolbarHeight;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.tighten(height: toolbarHeight);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, toolbarHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_ToolbarContainerLayout oldDelegate) =>
      toolbarHeight != oldDelegate.toolbarHeight;
}

class YourModalWidget extends StatelessWidget {
  const YourModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4 - 60,
              ),
              color: Colors.blue,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Modal Item $index'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  );
                },
                itemCount: 2,
              ),
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: theme.appBarTheme.backgroundColor,
                height: 60,
                child: Center(
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      color: Colors.blue,
                      iconSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 2);
    path.conicTo(size.width / 8, size.height * 0.5, size.width / 3,
        size.height * 0.75, 0.5);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width * 2 / 3, size.height * 0.75);
    path.conicTo(size.width * 0.875, size.height * 0.5, size.width,
        size.height * 0.5, 0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
