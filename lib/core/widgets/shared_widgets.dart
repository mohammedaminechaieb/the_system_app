import 'package:flutter/material.dart';
import '../theme/app_palette.dart';

/// Spacing scale stays theme-independent — the palette only controls
/// color/typography/radius, not layout rhythm.
class AppSpacing {
  AppSpacing._();
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 28.0;
}

/// A themed card. Reads its radius/colors from the active palette so it
/// looks right across all four themes without any call-site changes.
class SectionCard extends StatelessWidget {
  final String? title;
  final IconData? titleIcon;
  final Widget? trailing;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const SectionCard({
    super.key,
    this.title,
    this.titleIcon,
    this.trailing,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final content = Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (titleIcon != null) ...[
                        Icon(titleIcon, size: 17, color: p.primary),
                        const SizedBox(width: 8),
                      ],
                      Flexible(child: Text(title!, style: Theme.of(context).textTheme.headlineMedium)),
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          child,
        ],
      ),
    );

    // Only wrap in an InkWell (a real hit-testable gesture widget) when this
    // card is actually tappable. An InkWell with onTap: null still occupies
    // a slot in the gesture arena and can interfere with tap targets nested
    // inside it (e.g. habit checkboxes) — so for non-interactive cards we
    // skip it entirely rather than passing onTap: null.
    return Card(
      child: onTap != null
          ? InkWell(onTap: onTap, borderRadius: BorderRadius.circular(p.cardRadius), child: content)
          : content,
    );
  }
}

class PageHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? description;
  final Widget? trailing;

  const PageHeader({super.key, required this.eyebrow, required this.title, this.description, this.trailing});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eyebrow.toUpperCase(), style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.primary, letterSpacing: 1.2)),
                const SizedBox(height: 4),
                Text(title, style: Theme.of(context).textTheme.displayMedium),
                if (description != null) ...[
                  const SizedBox(height: 5),
                  Text(description!, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class Pill extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? background;
  final Color? foreground;
  const Pill({super.key, required this.text, this.icon, this.background, this.foreground});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: background ?? p.primarySoft, borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 12, color: foreground ?? p.primary), const SizedBox(width: 5)],
          Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: foreground ?? p.primary)),
        ],
      ),
    );
  }
}

enum EvidenceLevel { wellSupported, uncertain, weak, myth }

class EvidencePill extends StatelessWidget {
  final EvidenceLevel level;
  const EvidencePill({super.key, required this.level});
  const EvidencePill.wellSupported({super.key}) : level = EvidenceLevel.wellSupported;
  const EvidencePill.uncertain({super.key}) : level = EvidenceLevel.uncertain;
  const EvidencePill.weak({super.key}) : level = EvidenceLevel.weak;
  const EvidencePill.myth({super.key}) : level = EvidenceLevel.myth;

  String get _label {
    switch (level) {
      case EvidenceLevel.wellSupported:
        return 'Well-supported';
      case EvidenceLevel.uncertain:
        return 'Reasonable, uncertain';
      case EvidenceLevel.weak:
        return 'Weak evidence';
      case EvidenceLevel.myth:
        return 'Myth';
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    Color bg, fg;
    switch (level) {
      case EvidenceLevel.wellSupported:
        bg = p.accentSoft;
        fg = p.success;
        break;
      case EvidenceLevel.weak:
      case EvidenceLevel.myth:
        bg = p.dangerSoft;
        fg = p.danger;
        break;
      case EvidenceLevel.uncertain:
        bg = p.primarySoft;
        fg = p.warning;
        break;
    }
    return Pill(text: _label, background: bg, foreground: fg);
  }
}

enum CalloutTone { neutral, warm, cool }

class CalloutBox extends StatelessWidget {
  final String text;
  final IconData icon;
  final CalloutTone tone;
  const CalloutBox({super.key, required this.text, this.icon = Icons.info_outline, this.tone = CalloutTone.neutral});
  const CalloutBox.summer({super.key, required this.text})
      : icon = Icons.wb_sunny_rounded,
        tone = CalloutTone.warm;
  const CalloutBox.winter({super.key, required this.text})
      : icon = Icons.ac_unit_rounded,
        tone = CalloutTone.cool;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final Color accent = tone == CalloutTone.warm ? p.warning : (tone == CalloutTone.cool ? p.accent : p.primary);
    final Color bg = tone == CalloutTone.neutral ? p.primarySoft : p.surfaceSunken;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(p.cardRadius * 0.6),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: accent),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.textPrimary))),
        ],
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;
  final double gap;
  const BulletList({super.key, required this.items, this.gap = 8});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: EdgeInsets.only(bottom: gap),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6, right: 10),
                  child: Container(width: 5, height: 5, decoration: BoxDecoration(color: p.primary, shape: BoxShape.circle)),
                ),
                Expanded(child: Text(item, style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
          ),
      ],
    );
  }
}

/// Simple expandable accordion used for reference technique detail.
class Accordion extends StatefulWidget {
  final String title;
  final IconData? icon;
  final Widget child;
  const Accordion({super.key, required this.title, this.icon, required this.child});

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(border: Border.all(color: p.borderSoft), borderRadius: BorderRadius.circular(p.cardRadius * 0.7)),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _open = !_open),
            borderRadius: BorderRadius.circular(p.cardRadius * 0.7),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  if (widget.icon != null) ...[Icon(widget.icon, size: 17, color: p.primary), const SizedBox(width: 10)],
                  Expanded(child: Text(widget.title, style: Theme.of(context).textTheme.titleMedium)),
                  AnimatedRotation(
                    turns: _open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(Icons.expand_more, color: p.textFaint, size: 20),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(padding: const EdgeInsets.fromLTRB(14, 0, 14, 14), child: widget.child),
            crossFadeState: _open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

class StatBox extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon;
  const StatBox({super.key, required this.value, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: p.surface, border: Border.all(color: p.borderSoft), borderRadius: BorderRadius.circular(p.cardRadius * 0.8)),
      child: Column(
        children: [
          if (icon != null) ...[Icon(icon, size: 16, color: p.primary), const SizedBox(height: 4)],
          Text(value, style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 22, fontWeight: FontWeight.w700, color: p.primary)),
          const SizedBox(height: 3),
          Text(label.toUpperCase(), style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

/// Asks before deleting a logged entry — the delete icon sits right next
/// to the entry text, so a stray tap shouldn't silently destroy history.
Future<bool> confirmDelete(BuildContext context, {String what = 'this entry'}) async {
  final p = AppPalette.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text('Delete $what?'),
      content: const Text("This can't be undone."),
      actions: [
        TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancel')),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text('Delete', style: TextStyle(color: p.danger, fontWeight: FontWeight.w700)),
        ),
      ],
    ),
  );
  return result ?? false;
}
