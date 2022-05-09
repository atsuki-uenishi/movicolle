import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApiResultsScreen extends StatefulWidget {
  const ApiResultsScreen({Key? key}) : super(key: key);
  static const String id = 'api_results_screen';

  @override
  _ApiResultsScreenState createState() => _ApiResultsScreenState();
}

class _ApiResultsScreenState extends State<ApiResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> apiResults = ModalRoute.of(context)!
        .settings
        .arguments as List<Map<String, dynamic>>;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              for (var data in apiResults)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    onTap: () {
                      final Map<String, dynamic> sendData = {
                        'tittle': data['tittle'],
                        'posterUrl': data['posterUrl']
                      };
                      Navigator.pop(context, sendData);
                    },
                    title: Text(data['tittle'],
                        style: Theme.of(context).textTheme.bodyText1),
                    subtitle: Image.network(
                      data['posterUrl'],
                      height: 250.0.h,
                    ),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
