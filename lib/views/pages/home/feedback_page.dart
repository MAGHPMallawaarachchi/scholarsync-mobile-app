import 'package:flutter/material.dart';
import '../../../themes/palette.dart';
import '../../widgets/app_bar.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  FeedbackFormState createState() => FeedbackFormState();
}

class FeedbackFormState extends State<FeedbackForm> {
  int? _selectedIndex;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: 'Give Feedback',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          titleCenter: true,
          leftIcon: true,
          onPressedListButton: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: Form(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Help us serve you better',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'How would you rate your overall experience with ScholarSync?',
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            feedbackColorBox('Terrible',
                                Icons.sentiment_very_dissatisfied, 0),
                            feedbackColorBox(
                                'Bad', Icons.sentiment_dissatisfied, 1),
                            feedbackColorBox(
                                'Okay', Icons.sentiment_neutral, 2),
                            feedbackColorBox(
                                'Good', Icons.sentiment_satisfied, 3),
                            feedbackColorBox(
                                'Amazing', Icons.sentiment_very_satisfied, 4),
                          ],
                        ),
                        const SizedBox(height: 40),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const Text(
                                'What specific features do you like most about the app?',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _controller1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color:
                                            PaletteLightMode.secondaryTextColor,
                                        width: 1),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your rating';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 40),
                              const Text(
                                'What improvements or new features would you like to see in future updates?',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _controller2,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color:
                                            PaletteLightMode.secondaryTextColor,
                                        width: 1),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your suggestions';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 40),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Any other feedback or suggestions?',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  )),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _controller3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color:
                                            PaletteLightMode.secondaryTextColor,
                                        width: 1),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your feedback';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: SizedBox(
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        CommonColors.secondaryGreenColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: const Text('Submit',
                                    style: TextStyle(
                                        color: CommonColors.whiteColor)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget feedbackColorBox(String text, IconData icon, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          backgroundColor: index == _selectedIndex
              ? CommonColors.secondaryGreenColor
              : CommonColors.whiteColor,
          fixedSize: const Size(20, 70)),
      child: Column(
        children: [
          Icon(
            icon,
            color: index == _selectedIndex
                ? CommonColors.whiteColor
                : PaletteDarkMode.secondaryTextColor,
            size: 25,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: index == _selectedIndex
                  ? CommonColors.whiteColor
                  : PaletteDarkMode.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
