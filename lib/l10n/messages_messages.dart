// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  static m0(howMany) => "${Intl.plural(howMany, zero: 'There are no emails left', one: 'There is ${howMany} email left', other: 'There are ${howMany} emails left')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Login" : MessageLookupByLibrary.simpleMessage("Login"),
    "auto" : MessageLookupByLibrary.simpleMessage("auto"),
    "cancel" : MessageLookupByLibrary.simpleMessage("cancel"),
    "home" : MessageLookupByLibrary.simpleMessage("Home"),
    "language" : MessageLookupByLibrary.simpleMessage("language"),
    "logout" : MessageLookupByLibrary.simpleMessage("logout"),
    "logoutTip" : MessageLookupByLibrary.simpleMessage("logoutTip"),
    "noDescription" : MessageLookupByLibrary.simpleMessage("Flutter APP"),
    "password" : MessageLookupByLibrary.simpleMessage("password"),
    "passwordRequired" : MessageLookupByLibrary.simpleMessage("passwordRequired"),
    "remainingEmailsMessage" : m0,
    "theme" : MessageLookupByLibrary.simpleMessage("theme"),
    "title" : MessageLookupByLibrary.simpleMessage("Flutter APP Title"),
    "userName" : MessageLookupByLibrary.simpleMessage("userName"),
    "userNameOrEmail" : MessageLookupByLibrary.simpleMessage("userNameOrEmail"),
    "userNameOrPasswordWrong" : MessageLookupByLibrary.simpleMessage("userNameOrPasswordWrong"),
    "userNameRequired" : MessageLookupByLibrary.simpleMessage("userNameRequired"),
    "yes" : MessageLookupByLibrary.simpleMessage("yes")
  };
}
