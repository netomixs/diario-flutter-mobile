// ignore_for_file: depend_on_referenced_packages

import 'package:diario/controllers/experimento_controller.dart';
import 'package:diario/widgets/input_text.dart';
import 'package:diario/widgets/principal_button.dart';
import 'package:diario/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import '../widgets/input_text_on_tap.dart';
import 'package:intl/intl.dart';

class NewExperimento extends StatefulWidget {
  const NewExperimento({super.key});

  @override
  State<NewExperimento> createState() => _NewExperimentoState();
}

class _NewExperimentoState extends State<NewExperimento> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime pickedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo experiemento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputText(
              hintText: "Nombre",
              controller: _textEditingController,
              icon: Icons.abc,
            ),
            InputTextOnTap(
              hintText: "Fecha de incio",
              controller: _dateController,
              onTap: () async {
                try {
                  pickedDate = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101)))!;
                } catch (e) {
                //  print(e);
                }
                
                String formattedDate = DateFormat('yyyy-MM-dd').format(
                    pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                // ignore: unnecessary_null_comparison
                if (pickedDate != null) {
                  setState(() {
                    _dateController.text =
                        formattedDate; //set foratted date to TextField value.
                  });
                } else {}
                //when click we have to show the datepicker
              },
            ),
            const SizedBox(height: 20),
            PrincipalButton(
              isload: false,
              onPressed: () {
                ExperimentoController.creatExperimento(
                    _textEditingController.text, pickedDate);
                Navigator.pop(context);
              },
              text: 'Guardar',
            ),
            SecondarylButton(
                text: "Cancelar",
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
