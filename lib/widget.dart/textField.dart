import 'package:flutter/material.dart';

// ignore: camel_case_types
class customTextField extends StatefulWidget {
  final TextEditingController? TheController;
  final TextInputType inputType;
  final String hint;
  bool visbleText;
  customTextField(
      {super.key,
      required this.hint,
      required this.visbleText,
      required this.inputType,
      // ignore: non_constant_identifier_names
      this.TheController});

  @override
  State<customTextField> createState() => _customTextFieldState();
}

class _customTextFieldState extends State<customTextField> {
  IconData usedIcon = Icons.remove_red_eye;
  late bool securetext = widget.visbleText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.TheController,
      textInputAction: TextInputAction.next,
      keyboardType: widget.inputType,
      obscureText: securetext,
      decoration: InputDecoration(
          suffixIcon: widget.visbleText
              ? IconButton(
                  color: const Color.fromARGB(255, 113, 143, 224),
                  onPressed: () {
                    setState(() {
                      securetext = !securetext;
                    });
                    securetext
                        ? usedIcon = Icons.visibility
                        : usedIcon = Icons.visibility_off;
                  },
                  icon: Icon(usedIcon))
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 113, 143, 224), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 113, 143, 224), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: widget.hint),
    );
  }
}

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: "Search box"),
    );
  }
}
