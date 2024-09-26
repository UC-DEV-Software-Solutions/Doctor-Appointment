import 'package:firebase_testing/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:ikchatbot/ikchatbot.dart';

import '../../widgets/keyword_response.dart';

class ChatBotscreen extends StatefulWidget {
  const ChatBotscreen({super.key});

  @override
  State<ChatBotscreen> createState() => _ChatBotscreenState();
}

class _ChatBotscreenState extends State<ChatBotscreen> {
  final chatBotConfig = IkChatBotConfig(
    //SMTP Rating to your mail Settings
    ratingIconYes: const Icon(Icons.star),
    ratingIconNo: const Icon(Icons.star_border),
    ratingIconColor: Colors.black,
    ratingBackgroundColor: Colors.white,
    ratingButtonText: 'Submit Rating',
    thankyouText: 'Thanks for your rating!',
    ratingText: 'Rate your experience:',
    ratingTitle: 'Thank you for using the chatbot!',
    body: 'This is a test email sent from Flutter and Dart.',
    subject: 'Test Rating',
    recipient: 'recipient@example.com',
    isSecure: false,
    senderName: 'Your Name',
    smtpUsername: 'Your Email',
    smtpPassword: 'your password',
    smtpServer: 'stmp.gmail.com',
    smtpPort: 587,
    //Settings to your system Configurations
    sendIcon: const Icon(Icons.send, color: Colors.black),
    userIcon: const Icon(Icons.person, color: Colors.white),
    botIcon: const Icon(Icons.android, color: Colors.white),
    botChatColor: const Color.fromARGB(255, 81, 80, 80),
    delayBot: 100,
    closingTime: 1,
    delayResponse: 1,
    userChatColor: Colors.blue,
    waitingTime: 1,
    keywords: keywords,
    responses: responses,
    backgroundColor: Colors.white,
    initialGreeting:
    "👋 Hello! \nWelcome to EZYDOC ChatBOT.\nHow can I assist you today?",
    defaultResponse: "Sorry, I didn't understand your response.",
    inactivityMessage: "Is there anything else you need help with?",
    closingMessage: "This conversation will now close.",
    inputHint: 'Send a message',
    waitingText: 'Please wait...', backgroundImage: '', useAsset: false, backgroundAssetimage: 'assets/images/CHATbackground.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainWhite,
        title: Text('EZYDOC ChatBot'),
      ),
      body: ikchatbot(config: chatBotConfig),
    );
  }
}
