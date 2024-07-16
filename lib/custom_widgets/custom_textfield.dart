import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomTextfield extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool login;
  final bool password;
  final TextEditingController? passController;
  const CustomTextfield({
    super.key,
    this.login = false,
    this.password = false,
    required this.label,
    required this.controller,
    this.passController,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  double elevation = 1;
  bool visible = false;
  late bool show;
  @override
  void initState() {
    show = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: elevation,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 100),
          child: TextFormField(
            autovalidateMode: widget.login||widget.passController!=null
                ? AutovalidateMode.disabled
                : AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            obscureText: show,
            decoration: InputDecoration(
                suffixIcon: Visibility(
                    visible: widget.password&&widget.passController==null,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: eye[show]!,
                    )),
                prefixIcon: Icon(icons[widget.label]),
                labelStyle: const TextStyle(fontSize: 12),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                labelText: widget.label,
                isDense: true,
                border: InputBorder.none),
            validator: (value) {
              if (value == '' || value == null) {
                return '${widget.label} cannot be empty';
              }
              else if(widget.passController!=null&&widget.passController!.text!=widget.controller.text)
              {
                return 'passwords doesn\'t matches ';
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
      ),
    );
  }
}
