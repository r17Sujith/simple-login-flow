import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wingman/screens/home_screen.dart';
import 'package:wingman/screens/profile_form.dart';
import 'package:wingman/service/login_service.dart';
class VerifyScreenDTO{
  VerifyScreenDTO(this.requestId,this.number);

  String requestId;
  String number;
}
class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key,required  this.dto}) : super(key: key);

  final VerifyScreenDTO dto;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}
class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Colors.blue,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.account_circle,
                            size: 60,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter OTP',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "OTP has been sent to +91-${widget.dto.number}",
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: PinCodeTextField(
                          appContext: context,
                          controller: otpController,
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8.0),
                            fieldHeight: 50,
                            fieldWidth: 50,
                            activeFillColor: Colors.white.withOpacity(0.3),
                            activeColor: Colors.white,
                            inactiveFillColor: Colors.white.withOpacity(0.1),
                            inactiveColor: Colors.white,
                            selectedFillColor: Colors.white.withOpacity(0.5),
                            selectedColor: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: null,
                          keyboardType: TextInputType.number,
                          onCompleted: (value) {
                            // Perform OTP verification action using 'value'
                          },
                          onChanged: (value) {
                            setState(() {
                              hasError = false;
                            });
                          },
                          beforeTextPaste: (text) {
                            return false;
                          },
                        ),
                      ),
                      hasError
                          ? const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Invalid OTP',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                          : const SizedBox(),
                      const SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (otpController.text.length != 6) {
                              hasError = true;
                            } else {
                              hasError = false;
                              LoginService().verifyOtp(widget.dto.requestId,otpController.text,context).then((bool requestId) {
                                if(requestId){
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                      builder: (context) =>   const HomeScreen()),(route) => route.isFirst,);
                                } else{
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>  const ProfileFormScreen()));
                                }
                              });
                            }
                            setState(() {

                            }
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Verify',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: const Text(
                          "\nRetry",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),),
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.50);
    path.quadraticBezierTo(
        size.width / 4, size.height * 0.9, size.width / 2, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height * 0.65, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
