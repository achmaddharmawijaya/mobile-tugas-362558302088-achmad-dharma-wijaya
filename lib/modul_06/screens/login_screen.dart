
import 'package:flutter/material.dart';

import '../models/sesi_pengguna.dart';
import '../services/auth_api.dart';
import '../services/sesi_memori.dart';
import '../widgets/field_kata_sandi.dart';
import '../widgets/kartu_sesi.dart';

class LoginScreen extends StatefulWidget {
  final AuthApi api;
  final SesiMemori sesiMemori;
  final DateTime Function() jam;

  const LoginScreen({
    super.key,
    required this.api,
    required this.sesiMemori,
    this.jam = DateTime.now,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _sandiController = TextEditingController();

  SesiPengguna? _sesi;
  String? _pesanError;
  bool _sedangMemproses = false;
  bool _sedangKeluar = false;

  @override
  void initState() {
    super.initState();
    _sesi = widget.sesiMemori.baca();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _sandiController.dispose();
    super.dispose();
  }

  Future<void> _masuk() async {
    if (_sedangMemproses) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _sedangMemproses = true;
      _pesanError = null;
    });

    try {
      final SesiPengguna sesi = await widget.api.masuk(
        email: _emailController.text,
        sandi: _sandiController.text,
      );

      await widget.sesiMemori.simpan(sesi);

      if (!mounted) return;

      setState(() {
        _sesi = sesi;
        _sandiController.clear();
      });
    } on AuthException catch (e) {
      if (!mounted) return;

      setState(() {
        _pesanError = e.pesan;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _pesanError = 'Terjadi kesalahan. Silakan coba lagi.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _sedangMemproses = false;
        });
      }
    }
  }

  Future<void> _keluar() async {
    if (_sedangKeluar) return;

    setState(() {
      _sedangKeluar = true;
    });

    try {
      await widget.sesiMemori.hapus();

      if (!mounted) return;

      setState(() {
        _sesi = null;
        _pesanError = null;
      });
    } finally {
      if (mounted) {
        setState(() {
          _sedangKeluar = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modul 06 — Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: _sesi == null
                  ? _formLogin()
                  : KartuSesi(
                      sesi: _sesi!,
                      sekarang: widget.jam(),
                      onKeluar: _keluar,
                      sedangKeluar: _sedangKeluar,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formLogin() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.lock_outline_rounded,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Selamat Datang',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Silakan masuk menggunakan akun demo.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          TextFormField(
            controller: _emailController,
            enabled: !_sedangMemproses,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            autofillHints: const [AutofillHints.username],
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email wajib diisi.';
              }
              if (!value.contains('@')) {
                return 'Masukkan alamat email yang valid.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          FieldKataSandi(
            controller: _sandiController,
            enabled: !_sedangMemproses,
            onSubmitted: _masuk,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Kata sandi wajib diisi.';
              }
              return null;
            },
          ),
          if (_pesanError != null) ...[
            const SizedBox(height: 16),
            Text(
              _pesanError!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _sedangMemproses ? null : _masuk,
            child: _sedangMemproses
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Masuk'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Akun demo:\n'
            'Email: student@trpl.test\n'
            'Kata sandi: belajar123',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
