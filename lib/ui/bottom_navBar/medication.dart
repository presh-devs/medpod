import 'package:flutter/material.dart';

class MedicationPage extends StatelessWidget {
  const MedicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final List<String> mediactions = [];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('All meds'),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                  physics: ScrollPhysics(parent: null),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: const ListTile(
                        leading: Icon(Icons.close),
                        title: Text('Hydroxyurea'),
                        subtitle: Text('100 pill(s) left'),
                        trailing: Icon(Icons.ac_unit_outlined),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
