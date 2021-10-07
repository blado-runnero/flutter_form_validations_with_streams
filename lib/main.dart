import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/cubit/dashboard_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (BuildContext context) => SampleCubit(),
          child: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextStyle labelTextStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);

  TextStyle getHintTextStyle(context, hint) {
    return TextStyle(
        fontSize: 18,
        color: hint ? Colors.grey.shade400 : Colors.black,
        fontWeight: FontWeight.w900);
  }

  Widget makeForm(
      {@required String? labelText,
      @required String? hintText,
      @required TextEditingController? controller,
      @required context,
      List<TextInputFormatter> inputFormatters = const [],
      Function? onTap,
      Function? onEditingComplete,
      TextInputAction textInputAction = TextInputAction.done,
      bool obscureText = false,
      bool autofocus = false,
      bool readonly = false,
      String Function(String text)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText ?? "",
            style: labelTextStyle ?? TextStyle(),
          ),
          SizedBox(
            height: 19,
          ),
          TextFormField(
            autofocus: autofocus,
            onEditingComplete: () => onEditingComplete,
            textInputAction: textInputAction,
            onTap: () => onTap,
            obscureText: obscureText,
            onChanged: onChanged,
            maxLength: 20,
            controller: controller,
            inputFormatters: inputFormatters,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            cursorColor: Colors.black,
            readOnly: readonly,
            style: getHintTextStyle(context, false),
            decoration: InputDecoration(
                errorStyle: TextStyle(fontStyle: FontStyle.italic),
                isDense: true,
                counterText: "",
                contentPadding: EdgeInsets.only(bottom: 8),
                hintStyle: getHintTextStyle(context, true),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                hintText: hintText),
          ),
        ],
      ),
    );
  }

  Widget getErrorText(String errorText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
          height: 16,
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  errorText,
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFFF0000),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                StreamBuilder(
                  stream: BlocProvider.of<SampleCubit>(context).nameStream,
                  builder: (context, snapshot) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, top: 24),
                      child: Column(
                        children: [
                          makeForm(
                              labelText: "Enter Your Name",
                              context: context,
                              hintText: "John Doe",
                              onChanged: (text) {
                                BlocProvider.of<SampleCubit>(context)
                                    .updateName(text);
                                return "435252";
                              }),
                          snapshot.hasError
                              ? getErrorText(snapshot.error.toString())
                              : SizedBox(
                                  height: 29,
                                )
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder(
                  stream:
                      BlocProvider.of<SampleCubit>(context).phoneNumberStream,
                  builder: (context, snapshot) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, top: 24),
                      child: Column(
                        children: [
                          makeForm(
                              labelText: "Enter OTP Number",
                              context: context,
                              hintText: "99999 99999",
                              onChanged: (text) {
                                BlocProvider.of<SampleCubit>(context)
                                    .updatePhone(text);
                                return text;
                              }),
                          snapshot.hasError
                              ? getErrorText(snapshot.error.toString())
                              : SizedBox(
                                  height: 29,
                                )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            StreamBuilder(
              stream: BlocProvider.of<SampleCubit>(context).buttonValid,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF08B578),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: snapshot.hasData ? () {
                            BlocProvider.of<SampleCubit>(context).onNext();
                          } : null,
                          child: Text(
                            "Next",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
