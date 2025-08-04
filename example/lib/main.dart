import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

void main() {
  // Configurazione globale del componente login
  LoginConfig.instance.setBaseUrl('https://api.example.com');
  LoginConfig.instance.setLoginEndpoint('/auth/login');
  LoginConfig.instance.addHeaders({
    'X-App-Version': '1.0.0',
    'Authorization': 'Bearer demo-token',
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Component Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginDemoScreen extends StatefulWidget {
  const LoginDemoScreen({Key? key}) : super(key: key);

  @override
  State<LoginDemoScreen> createState() => _LoginDemoScreenState();
}

class _LoginDemoScreenState extends State<LoginDemoScreen> {
  String _lastLoginAttempt = '';
  bool _isLoading = false;
  bool _useHttpService = false;

  void _handleLogin(LoginData loginData) async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_useHttpService) {
        // Usa il servizio HTTP integrato
        final response = await LoginService.instance.login(loginData);

        setState(() {
          _isLoading = false;
          _lastLoginAttempt = '''
Email: ${loginData.email}
Password: ${loginData.password.replaceAll(RegExp(r'.'), '*')}
HTTP Response: ${response.success ? 'Success' : 'Failed'}
Status Code: ${response.statusCode}
Message: ${response.message ?? 'No message'}
''';
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.success
                  ? 'Login riuscito!'
                  : 'Login fallito: ${response.message}'),
              backgroundColor: response.success ? Colors.green : Colors.red,
            ),
          );
        }
      } else {
        // Simula una chiamata API locale
        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          _isLoading = false;
          _lastLoginAttempt = '''
Email: ${loginData.email}
Password: ${loginData.password.replaceAll(RegExp(r'.'), '*')}
Mode: Local simulation
''';
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login simulato con: ${loginData.email}'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _lastLoginAttempt = 'Errore: $e';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore durante il login: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Flutter Login Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sezione informazioni
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Test del Componente Flutter Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Questo è un esempio di utilizzo del componente login riutilizzabile.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    const Text('Caratteristiche testate:'),
                    const SizedBox(height: 4),
                    const Text('• Validazione email'),
                    const Text('• Validazione password (min 6 caratteri)'),
                    const Text('• Toggle visibilità password personalizzabile'),
                    const Text('• Styling personalizzabile'),
                    const Text('• Callback onLogin'),
                    const Text('• Configurazione URL backend globale'),
                    const Text('• Servizio HTTP integrato'),
                    const SizedBox(height: 12),

                    // Toggle per servizio HTTP
                    SwitchListTile(
                      title: const Text('Usa servizio HTTP'),
                      subtitle: Text(_useHttpService
                          ? 'Chiamerà: ${LoginConfig.instance.loginUrl ?? "URL non configurato"}'
                          : 'Modalità simulazione locale'),
                      value: _useHttpService,
                      onChanged: (value) {
                        setState(() {
                          _useHttpService = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Componente Login centrato
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: LoginWidget(
                  title: 'Accedi alla Demo',
                  onLogin: _handleLogin,
                  buttonText: _isLoading ? 'Accesso in corso...' : 'Accedi',
                  showPasswordToggle: true,
                  visibilityIcon: const Icon(Icons.remove_red_eye_outlined),
                  visibilityOffIcon: const Icon(Icons.visibility_off_outlined),
                  emailDecoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Inserisci la tua email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  passwordDecoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Inserisci la tua password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  footer: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Funzionalità "Password dimenticata" non implementata in questa demo'),
                            ),
                          );
                        },
                        child: const Text('Password dimenticata?'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Non hai un account? '),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Funzionalità "Registrazione" non implementata in questa demo'),
                                ),
                              );
                            },
                            child: const Text('Registrati'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Sezione risultati
            if (_lastLoginAttempt.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ultimo tentativo di login:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _lastLoginAttempt,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Credenziali di test
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '💡 Credenziali di test',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Email: test@example.com'),
                    const Text('Password: password123'),
                    const SizedBox(height: 8),
                    const Text(
                      'Prova anche con email non valide o password troppo corte per vedere la validazione in azione!',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
