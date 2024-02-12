import 'package:dicoding_moments/common.dart';
import 'package:dicoding_moments/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final Function() onLogout;
  final Function() onLanguageSettingsScreen;

  const ProfileScreen({
    super.key,
    required this.onLogout,
    required this.onLanguageSettingsScreen,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 150,
                ),
                Text(
                  authWatch.profile?.name ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    AppLocalizations.of(context)?.appSettingsTitle ?? "App",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () {
                        widget.onLanguageSettingsScreen();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 8,
                        ),
                        alignment: Alignment.centerLeft,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: authWatch.isLoadingLogout
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : ListTile(
                                leading: const Icon(
                                  Icons.language,
                                ),
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  AppLocalizations.of(context)
                                          ?.languageSettingsTitle ??
                                      "Language",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                ),
                              ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    AppLocalizations.of(context)?.accountSettingsTitle ??
                        "Account",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final authRead = context.read<AuthProvider>();
                        final result = await authRead.logout();
                        if (result) widget.onLogout();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 8,
                        ),
                        alignment: Alignment.centerLeft,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: authWatch.isLoadingLogout
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : Text(
                                AppLocalizations.of(context)
                                        ?.logoutSettingsTitle ??
                                    "Log out",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
