import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalize/app/core/routes/go_route_config.dart';

class ScaffoldWithAppbar extends StatelessWidget {
  final GoRouterConfig page;
  final String? title;

  const ScaffoldWithAppbar({super.key, required this.page, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          child: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              FluentIcons.arrow_circle_left_20_filled,
              color: Theme.of(context).colorScheme.secondary,
              size: 30,
            ),
          ),
        ),
        title: Text(title ?? page.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: page.child,
        ),
      ),
    );
  }
}