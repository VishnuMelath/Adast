
import 'package:flutter/material.dart';


import '../ themes/constants.dart';

class CustomTextfield extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool login;
  final String icon;

  final bool password;
  const CustomTextfield(
      {super.key,
      required this.icon,
      this.login = false,
      this.password = false,
      required this.label,
      required this.controller});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  double elevation = 1;
  bool visible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
       
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            borderRadius: BorderRadius.circular(15),
            elevation: elevation,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              obscureText: widget.password,
              decoration: InputDecoration(
                suffixIcon: Visibility(visible: widget.password, child: IconButton(onPressed: () {
                  
                },icon:const Icon(Icons.remove_red_eye_outlined),)),
                  prefixIcon: Icon(icons[widget.label]),
                  labelStyle: const TextStyle(fontSize: 12),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  labelText: widget.label,
                  isDense: true,
                  border: InputBorder.none),
              validator: (value) {
                if (value == '' || value == null) {
                  visible = true;
                }
                return null;
              },
              onTapOutside: (event) {
                elevation = 1;
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {});
              },
              onTap: () {
                setState(() {
                  elevation = 10;
                });
              },
            ),
          ),
          if (widget.login == false)
            Visibility(
                visible: visible,
                child: Text('${widget.label} cannot be empty'))
        ],
      ),
    );
  }
}
