import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/routing_constants.dart';
import '../login/bloc/bloc.dart';
import '../login/bloc/login_bloc2.dart';
import '../widgets/error_message.dart';
import '../widgets/loading_indicator.dart';

import 'package:bloc_with_freezed_with_test/widgets/show_toast.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key:key);


  @override
  _LoginState createState() {
    print(" ==== createState");
    return _LoginState();
  }
}

class _LoginState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

    late LoginBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = LoginBloc();
    print(" ==== initState");
  }

  @override
  void didChangeDependencies() {
    print(" ==== didChangeDependencies");
  }


  @override
  void deactivate() {
    print(" ==== deactivate");
  }

  @override
  void setState(VoidCallback fn) {
    print(" ==== setState");
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    print(" ==== didUpdateWidget");
  }




  @override
  void dispose() {
    print(" ==== dispose");
    _bloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      _buildEditScreen(context);
  }

  Widget _buildEditScreen(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      LoginBloc _bloc = BlocProvider.of<LoginBloc>(context);
      LoginBloc2 bloc2 = BlocProvider.of<LoginBloc2>(context);
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title:   Text('OTP '+ _bloc.state.email.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Color(0xFF2793F1), Color(0xFF2793F1)],
                ),
              ),
            ),
          ),

          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MaterialButton(
                  elevation: 0,
                  color: Color(0xFFF2F2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  onPressed:  () {},
                  child: const Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MaterialButton(
                  elevation: 0,
                  color: const Color(0xFF2793F1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  disabledColor: const Color(0XFFF2F2F2),
                  textColor: Colors.white,
                  disabledTextColor: Colors.black,
                  onPressed: (!state.isModified! ||
                      !_bloc.isValid)
                      ? null
                      : () {
                    !state.isModified !|| !_bloc.isValid
                        ? null
                        : _bloc.add(  LoginToAccount());
                  },
                  child: Text(
                    !state.isModified! || !_bloc.isValid || state.isLoading!
                        ? "Save"
                        : "Save",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: BlocListener<LoginBloc, LoginState>(

            listener: (context, state) {
              if (state.isSucceed!) {

                ShowToast.showToast(state.successMsg.toString());

                if(currentRoute!=null)
                {
                  debugPrint(currentRoute);
                }

                Navigator.of(context).pushNamed(otppage,arguments: {"email":state.email});
              } else if (state.isFailed!) {
                FocusScope.of(context).unfocus();
                ShowToast.showToast(state.error.toString());

                Navigator.of(context).pushNamed(otppage,arguments: {"email":state.email});

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => BlocProvider.value(
                //       value: bloc,
                //       child: OtpScreen(email: state.email.toString()),
                //     ),
                //   ),
                // );
                //

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MultiBlocProvider(
                //       providers: [
                //
                //         BlocProvider.value(
                //           value: _bloc,
                //         ),
                //
                //         BlocProvider.value(
                //           value: _bloc,
                //         ),
                //
                //
                //       ], child: OtpScreen(),
                //     ),
                //   ),
                // );


                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  OtpScreen(email: state.email.toString())),
                // );



              }
            },
            child: Stack(
              children: <Widget>[
                _detailedWidget(_bloc, state),
                state.isBusy()!
                    ? Positioned.fill(
                    child: LoadingIndicator(
                        text:  'Loading'))
                    : Container(),
              ],
            ),
          ),

        ),
      );
    });
  }

  Widget _detailedWidget(LoginBloc bloc, LoginState state) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 12, top: 24, right: 12, bottom: 24),
          child: _buildForm(context, bloc, state),
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    LoginBloc bloc,
    LoginState state,
  ) {
    final size = MediaQuery.of(context).size;

    _emailController.value = _emailController.value.copyWith(text: state.email);

    _passwordController.value =
        _passwordController.value.copyWith(text: state.password);

    return Form(
      child: Column(children: <Widget>[

        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: true,
          enableSuggestions: true,
          textCapitalization: TextCapitalization.sentences,
          readOnly: state.isBusy()!,
          controller: _emailController,
          keyboardType: TextInputType.text,
          onChanged: (value) => bloc.add(EmailChanged(value)),
          validator: (_) => !state.emailValidation!.isValid
              ? state.emailValidation?.errorMessage.toString()
              : null,
          inputFormatters: [LengthLimitingTextInputFormatter(255)],
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              helperText: '',
              labelText: 'Email',
              errorMaxLines: 2),
        ),

        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: true,
          enableSuggestions: true,
          textCapitalization: TextCapitalization.sentences,
          readOnly: state.isBusy()!,
          controller: _passwordController,
          keyboardType: TextInputType.text,
          onChanged: (value) => bloc.add(PasswordChanged(value)),
          validator: (_) => !state.passwordValidation!.isValid
              ? state.passwordValidation?.errorMessage.toString()
              : null,
          inputFormatters: [LengthLimitingTextInputFormatter(255)],
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              helperText: '',
              labelText: 'Password',
              errorMaxLines: 2),
        ),

      ]),
    );
  }

}
