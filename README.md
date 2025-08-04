# Flutter Login Component

Un componente di login Flutter personalizzabile e riutilizzabile che può essere facilmente integrato in qualsiasi applicazione Flutter con supporto per backend HTTP.

## ✨ Caratteristiche

- 🎨 **UI moderna e pulita** - Design responsive e personalizzabile
- ✅ **Validazione integrata** - Email e password con validatori personalizzabili
- 👁️ **Toggle visibilità password** - Icone personalizzabili per mostrare/nascondere password
- 🔧 **Styling personalizzabile** - Colori, decorazioni, stili button completamente customizzabili
- 🌐 **Integrazione HTTP** - Servizio HTTP integrato per chiamate backend
- ⚙️ **Configurazione globale** - URL backend e headers configurabili globalmente
- 📱 **Design responsive** - Si adatta a diverse dimensioni schermo
- 🧪 **Test completi** - Test unitari e widget inclusi

## 📦 Installazione

Aggiungi questo al file `pubspec.yaml` del tuo progetto:

```yaml
dependencies:
  flutter_login:
    git:
      url: https://github.com/davideloddeDev/flutter-login.git
```

## 🚀 Utilizzo Base

```dart
import 'package:flutter_login/flutter_login.dart';

// Configurazione globale (opzionale)
void main() {
  LoginConfig.instance.setBaseUrl('https://api.tuodominio.com');
  LoginConfig.instance.setLoginEndpoint('/auth/login');
  LoginConfig.instance.addHeaders({
    'X-App-Version': '1.0.0',
  });
  
  runApp(MyApp());
}

// Utilizzo del widget
LoginWidget(
  title: 'Accedi',
  onLogin: (LoginData loginData) {
    print('Email: ${loginData.email}');
    print('Password: ${loginData.password}');
    // Gestisci il login
  },
)
```

## 🔧 Configurazione Avanzata

### Styling Personalizzato

```dart
LoginWidget(
  title: 'Benvenuto',
  onLogin: _handleLogin,
  
  // Personalizza l'aspetto
  backgroundColor: Colors.white,
  borderRadius: BorderRadius.circular(16),
  padding: EdgeInsets.all(24),
  
  // Decorazioni campi
  emailDecoration: InputDecoration(
    labelText: 'La tua Email',
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
  passwordDecoration: InputDecoration(
    labelText: 'Password',
    prefixIcon: Icon(Icons.lock),
    border: OutlineInputBorder(),
  ),
  
  // Stile pulsante
  buttonStyle: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    padding: EdgeInsets.symmetric(vertical: 16),
  ),
  buttonText: 'Accedi Ora',
  
  // Toggle password personalizzato
  showPasswordToggle: true,
  visibilityIcon: Icon(Icons.visibility),
  visibilityOffIcon: Icon(Icons.visibility_off),
  
  // Footer personalizzato
  footer: TextButton(
    onPressed: () => Navigator.pushNamed(context, '/register'),
    child: Text('Non hai un account? Registrati'),
  ),
)
```

### Integrazione con Backend HTTP

```dart
// Configurazione globale
LoginConfig.instance.setBaseUrl('https://api.esempio.com');
LoginConfig.instance.setLoginEndpoint('/auth/login');
LoginConfig.instance.addHeaders({
  'Content-Type': 'application/json',
  'X-API-Key': 'your-api-key',
});

// Utilizzo del servizio HTTP
void _handleLogin(LoginData loginData) async {
  try {
    final response = await LoginService.instance.login(loginData);
    
    if (response.success) {
      // Login riuscito
      final token = response.token;
      final userData = response.userData;
      // Salva token e naviga
    } else {
      // Login fallito
      showError(response.message);
    }
  } catch (e) {
    showError('Errore di rete: $e');
  }
}
```

### Chiamata HTTP Personalizzata

```dart
// Per URL specifici o configurazioni custom
final response = await LoginService.instance.customLogin(
  loginData,
  url: 'https://custom-api.com/login',
  headers: {'Authorization': 'Bearer custom-token'},
  timeout: Duration(seconds: 60),
);
```

## 🎯 Validazione Personalizzata

```dart
LoginWidget(
  emailValidator: (email) {
    if (email?.isEmpty ?? true) return 'Email richiesta';
    if (!email!.contains('@company.com')) {
      return 'Utilizza email aziendale';
    }
    return null;
  },
  passwordValidator: (password) {
    if (password?.isEmpty ?? true) return 'Password richiesta';
    if (password!.length < 8) return 'Minimo 8 caratteri';
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Deve contenere almeno una maiuscola';
    }
    return null;
  },
  onLogin: _handleLogin,
)
```

## 📱 Esempio Completo

Vedi la cartella `example/` per un'implementazione completa che mostra:

- Configurazione backend
- Styling personalizzato
- Gestione errori
- Toggle modalità HTTP/simulazione
- Validazione avanzata

## 🧪 Test

Esegui i test:

```bash
flutter test
```

## 📋 API Reference

### LoginWidget

| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| `onLogin` | `Function(LoginData)` | **Richiesto.** Callback chiamato al login |
| `title` | `String?` | Titolo del widget |
| `showPasswordToggle` | `bool` | Abilita toggle visibilità password (default: true) |
| `emailDecoration` | `InputDecoration?` | Decorazione campo email |
| `passwordDecoration` | `InputDecoration?` | Decorazione campo password |
| `buttonStyle` | `ButtonStyle?` | Stile del pulsante login |
| `visibilityIcon` | `Widget?` | Icona per mostrare password |
| `visibilityOffIcon` | `Widget?` | Icona per nascondere password |

### LoginConfig

| Metodo | Descrizione |
|--------|-------------|
| `setBaseUrl(String)` | Imposta URL base del backend |
| `setLoginEndpoint(String)` | Imposta endpoint di login |
| `addHeaders(Map<String, String>)` | Aggiunge headers HTTP |
| `setTimeout(int)` | Imposta timeout richieste |

### LoginService

| Metodo | Descrizione |
|--------|-------------|
| `login(LoginData)` | Esegue login con configurazione globale |
| `customLogin(LoginData, {...})` | Login con parametri personalizzati |

## 🤝 Contribuire

I pull request sono benvenuti. Per modifiche importanti, apri prima un issue per discutere cosa vorresti cambiare.

## 📄 Licenza

MIT
