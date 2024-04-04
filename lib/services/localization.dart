import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Localization {
  Localization(this.locale);

  final Locale locale;

  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'addTask': 'Add Task',
      'add': 'Add',
      'login': 'Login',
      'password': 'Password',
      'confirmPassword': 'Confirm password',
      'loginFirst!': 'You need to login first!',
      'forgotPassword': 'Forgot Password?',
      'passwordResetTitle': 'Password Reset Email Sent',
      'passwordResetContent':
          'A password reset email has been sent to {email}. Please check your inbox.',
      'tasks': '{a} tasks',
      'retry': 'Retry',
      'userNotExistTitle': 'User does not exist',
      'userNotExistContent':
          'Perhaps there was a typographical error. Please consider re-entering the information and retrying.',
      'orContinueWith': 'Or continue with',
      'notAMember': 'Not a member?',
      'registerNow': 'Register now',
      'loginNow': 'Login now',
      'register': 'Register',
      'welcomeToCommunity': 'Welcome to our community!',
      'passwordsDoNotMatch': 'Passwords do not match',
      'error': 'Error',
      'theAccountAlreadyExists': 'The account already exists for that email.',
      'already': 'Already have an account?'
    },
    'fr': {
      'addTask': 'Ajouter une tâche',
      'add': 'Ajouter',
      'login': 'Connexion',
      'password': 'Mot de passe',
      'confirmPassword': 'Confirmer le mot de passe',
      'loginFirst!': 'Vous devez se connecter dabord!',
      'forgotPassword': 'Mot de passe oublié?',
      'passwordResetTitle': 'Email de réinitialisation du mot de passe envoyé',
      'passwordResetContent':
          'Un email de réinitialisation de mot de passe a été envoyé à {email}. Veuillez vérifier votre boîte de réception.',
      'tasks': '{a} tâches',
      'retry': 'Réessayer',
      'userNotExistTitle': "L'utilisateur n'existe pas",
      'userNotExistContent':
          'Il y a peut-être eu une erreur de frappe. Veuillez envisager de saisir à nouveau les informations et de réessayer.',
      'orContinueWith': 'Ou continuer avec',
      'notAMember': 'Pas encore membre?',
      'registerNow': 'S\'inscrire maintenant',
      'loginNow': 'Se connecter maintenant',
      'register': 'S\'inscrire',
      'welcomeToCommunity': 'Bienvenue dans notre communauté !',
      'passwordsDoNotMatch': 'Les mots de passe ne correspondent pas',
      'error': 'Erreur',
      'theAccountAlreadyExists': 'Le compte existe déjà pour cet e-mail.',
      'already': 'Vous avez déjà un compte ?'
    },
  };

  String? get addTask {
    return _localizedValues[locale.languageCode]!['addTask'];
  }

  String? get add {
    return _localizedValues[locale.languageCode]!['add'];
  }

  String? get login {
    return _localizedValues[locale.languageCode]!['login'];
  }

  String? get loginFirst {
    return _localizedValues[locale.languageCode]!['loginFirst!'];
  }

  String? get password {
    return _localizedValues[locale.languageCode]!['password'];
  }

  String? get confirmPassword {
    return _localizedValues[locale.languageCode]!['confirmPassword'];
  }

  String? get forgotPassword {
    return _localizedValues[locale.languageCode]!['forgotPassword'];
  }

  String? passwordResetTitle(String email) {
    return _localizedValues[locale.languageCode]!['passwordResetTitle']!
        .replaceFirst('{email}', email);
  }

  String? passwordResetContent(String email) {
    return _localizedValues[locale.languageCode]!['passwordResetContent']!
        .replaceFirst('{email}', email);
  }

  String? tasks(int a) {
    return _localizedValues[locale.languageCode]!['tasks']!
        .replaceFirst('{a}', a.toString());
  }

  String? get retry {
    return _localizedValues[locale.languageCode]!['retry'];
  }

  String? get userNotExistTitle {
    return _localizedValues[locale.languageCode]!['userNotExistTitle'];
  }

  String? get userNotExistContent {
    return _localizedValues[locale.languageCode]!['userNotExistContent'];
  }

  String? get orContinueWith {
    return _localizedValues[locale.languageCode]!['orContinueWith'];
  }

  String? get notAMember {
    return _localizedValues[locale.languageCode]!['notAMember'];
  }

  String? get registerNow {
    return _localizedValues[locale.languageCode]!['registerNow'];
  }

  String? get loginNow {
    return _localizedValues[locale.languageCode]!['loginNow'];
  }

  String? get register {
    return _localizedValues[locale.languageCode]!['register'];
  }

  String? get welcomeToCommunity {
    return _localizedValues[locale.languageCode]!['welcomeToCommunity'];
  }

  String? get passwordsDoNotMatch {
    return _localizedValues[locale.languageCode]!['passwordsDoNotMatch'];
  }

  String? get error {
    return _localizedValues[locale.languageCode]!['error'];
  }

  String? get theAccountAlreadyExists {
    return _localizedValues[locale.languageCode]!['theAccountAlreadyExists'];
  }

  String? get already {
    return _localizedValues[locale.languageCode]!['already'];
  }
}

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) {
    return SynchronousFuture<Localization>(Localization(locale));
  }

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}
