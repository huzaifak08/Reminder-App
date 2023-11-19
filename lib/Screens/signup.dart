import '../libraries.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _passwordFocusNode;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    debugPrint('build');
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(context, 0.02),
                vertical: getHeight(context, 0.01)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthHeader(title: 'Create Account'),
                  SizedBox(height: getHeight(context, 0.01)),
                  SizedBox(
                    height: getHeight(context, 0.35),
                    width: getWidth(context, 1.0),
                    child: Image.asset('assets/images/login_img.png'),
                  ),
                  SizedBox(height: getHeight(context, 0.02)),
                  const Text(
                    'Email Address',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: getHeight(context, 0.012)),
                  InputTextField(
                    myController: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    hint: 'someone@gmail.com',
                    obsecureText: false,
                    onFiledSubmissionValue: (newValue) {
                      if (newValue != null) {
                        _passwordFocusNode.requestFocus();
                      }
                    },
                    onValidator: (value) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)
                          ? null
                          : 'Enter a valid Email Address';
                    },
                  ),
                  SizedBox(height: getHeight(context, 0.012)),
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: getHeight(context, 0.012)),
                  InputTextField(
                    myController: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    hint: 'abc@123',
                    obsecureText: true,
                    focusNode: _passwordFocusNode,
                    onValidator: (value) {
                      if (value!.isEmpty && value!.length < 6) {
                        return "Password Can't be less than 6 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: getHeight(context, 0.012)),
                  SizedBox(
                    height: getHeight(context, 0.05),
                    width: getWidth(context, 1.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authProvider.signUpUser(
                              _emailController.text, _passwordController.text);
                          Navigator.pushReplacementNamed(
                              context, RouteName.homeScreen);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: const Text('Continue'),
                    ),
                  ),
                  SizedBox(height: getHeight(context, 0.015)),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.grey),
                      children: [
                        const TextSpan(text: 'Already have an account? '),
                        TextSpan(
                            text: 'Sign In',
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pop();
                              })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
