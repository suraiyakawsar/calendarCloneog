import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../model/event.dart';
import '../utils.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildEditingActions(),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTitle(),
                SizedBox(
                  // height: 12,
                  child: buildDateTimePickers(),
                ),
              ],
            ),
          ),
        ),
      );

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shadowColor: Colors.red),
          icon: Icon(Icons.done),
          label: Text('SAVE'),
          onPressed: () {},
        ),
      ];

  Widget buildTitle() => TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add Title',
        ),
        onFieldSubmitted: (_) {},
        validator: (title) => title != null && title.isEmpty ? 'Title cannot be empty' : null,
        controller: titleController,
      );

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildFrom() => Container(
        margin: EdgeInsets.all(10),
        child: buildHeader(
          header: "FROM",
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: buildDropDownField(
                  text: Utils.toDate(fromDate),
                  onClicked: () => pickToDateTime(pickDate: true),
                ),
              ),
              Expanded(
                child: buildDropDownField(
                  text: Utils.toTime(fromDate),
                  onClicked: () => pickToDateTime(pickDate: false),
                ),
              ),
            ],
          ),
        ),
      );
  Widget buildTo() => Container(
        margin: EdgeInsets.all(10),
        child: buildHeader(
          header: "TO",
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: buildDropDownField(
                  text: Utils.toDate(toDate),
                  onClicked: () => pickFromDateTime(pickDate: true),
                ),
              ),
              Expanded(
                child: buildDropDownField(
                  text: Utils.toTime(toDate),
                  onClicked: () => pickFromDateTime(pickDate: false),
                ),
              ),
            ],
          ),
        ),
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate, pickDate: pickDate);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time = Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date = DateTime(initialDate.year, initialDate.month, initialDate.year);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Widget buildDropDownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          child,
        ],
      );
}
