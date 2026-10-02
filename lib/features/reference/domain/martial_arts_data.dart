class MartialArt {
  final String name;
  final String imageUrl;
  final int cardio, strength, selfDefense, injuryRisk, beginnerFriendly;
  final String recommendation;
  final List<TechniqueNote> techniques;
  final List<ResourceLink> resources;

  const MartialArt({
    required this.name,
    required this.imageUrl,
    required this.cardio,
    required this.strength,
    required this.selfDefense,
    required this.injuryRisk,
    required this.beginnerFriendly,
    required this.recommendation,
    required this.techniques,
    required this.resources,
  });
}

class TechniqueNote {
  final String title;
  final String body;
  const TechniqueNote({required this.title, required this.body});
}

class ResourceLink {
  final String title;
  final String source;
  final String url;
  const ResourceLink({required this.title, required this.source, required this.url});
}

class MartialArtsData {
  MartialArtsData._();

  static const List<MartialArt> arts = [
    MartialArt(
      name: 'Boxing',
      imageUrl: 'https://images.unsplash.com/photo-1549719386-74dfcbf7dbed?w=900&q=80',
      cardio: 9,
      strength: 6,
      selfDefense: 7,
      injuryRisk: 5,
      beginnerFriendly: 7,
      recommendation: 'Lowest logistics barrier, best cardio return per hour — our top pick for home-training schedules.',
      techniques: [
        TechniqueNote(
          title: 'Stance, jab, footwork',
          body:
              'Stance: feet shoulder-width, lead foot forward, weight balanced 50/50, chin tucked, hands guarding cheekbones, elbows in.\n\n'
              'Jab: extend lead hand straight from the chin, rotate fist palm-down on impact, snap back to guard. Power comes from the push off the back foot and hip rotation.\n\n'
              'Footwork: small steps, never cross your feet. Stay on the balls of your feet.\n\n'
              'Practice at home: shadow boxing in front of a mirror, 3×3-minute rounds.',
        ),
      ],
      resources: [
        ResourceLink(title: 'Boxing: A Guide to the Manly Art of Self Defense', source: 'Public domain, Internet Archive', url: 'https://archive.org/details/boxingguidetoman00newy'),
        ResourceLink(title: 'USA Boxing — official resources', source: 'Find a gym, amateur rules', url: 'https://www.usaboxing.org'),
      ],
    ),
    MartialArt(
      name: 'Kickboxing',
      imageUrl: 'https://images.unsplash.com/photo-1615117972428-14eb1f60cd80?w=900&q=80',
      cardio: 9,
      strength: 7,
      selfDefense: 7,
      injuryRisk: 5,
      beginnerFriendly: 7,
      recommendation: 'Boxing fundamentals plus kicks — great all-round cardio if a boxing-only gym isn\'t nearby.',
      techniques: [
        TechniqueNote(
          title: 'Basics beyond boxing',
          body: 'Shares boxing\'s stance and hand technique, adding low/mid kicks. Beginners typically start with the round kick, thrown off the lead or rear leg with hip rotation, shin making contact rather than the foot.',
        ),
      ],
      resources: [ResourceLink(title: 'Internet Archive: Martial Arts collection', source: 'Includes kickboxing/striking references', url: 'https://archive.org/details/boxing-martial-arts-and-weapons')],
    ),
    MartialArt(
      name: 'Muay Thai',
      imageUrl: 'https://images.unsplash.com/photo-1544717684-1243da23b545?w=900&q=80',
      cardio: 9,
      strength: 8,
      selfDefense: 8,
      injuryRisk: 6,
      beginnerFriendly: 6,
      recommendation: 'Most complete striking art (elbows, knees, clinch) but a higher-contact style — better once basics are comfortable.',
      techniques: [
        TechniqueNote(
          title: 'The teep and roundhouse',
          body: 'The teep (push kick) uses the ball or heel of the foot to create distance defensively or offensively. The Muay Thai roundhouse rotates further through the hip than kickboxing\'s version, generating power through the shin.',
        ),
      ],
      resources: [],
    ),
    MartialArt(
      name: 'Karate',
      imageUrl: 'https://images.unsplash.com/photo-1555597673-b21d5c935865?w=900&q=80',
      cardio: 6,
      strength: 5,
      selfDefense: 6,
      injuryRisk: 3,
      beginnerFriendly: 8,
      recommendation: 'Traditional, structured, low injury risk — a strong choice if moderate rather than extreme training fits your week.',
      techniques: [
        TechniqueNote(
          title: 'Stance, straight punch, front kick',
          body:
              'Zenkutsu-dachi (front stance): front leg bent ~90°, back leg straight, hips forward.\n\n'
              'Choku-zuki (straight punch): travels from the hip in a straight line, non-punching hand retracts to the hip.\n\n'
              'Mae-geri (front kick): chamber the knee high, extend through the ball of the foot, snap back after impact.',
        ),
      ],
      resources: [],
    ),
    MartialArt(
      name: 'Taekwondo',
      imageUrl: 'https://images.unsplash.com/photo-1615729947596-a598e5de0ab3?w=900&q=80',
      cardio: 7,
      strength: 5,
      selfDefense: 5,
      injuryRisk: 4,
      beginnerFriendly: 8,
      recommendation: 'Excellent kicking mobility and coordination work, structured belt progression.',
      techniques: [
        TechniqueNote(
          title: 'Roundhouse kick (dollyo chagi)',
          body: 'Pivot on the standing foot ~90°, chamber the kicking knee to the side, snap shin/instep through the target in an arc, retract before the foot returns to the ground.',
        ),
      ],
      resources: [],
    ),
    MartialArt(
      name: 'Judo',
      imageUrl: 'https://images.unsplash.com/photo-1555597673-53ba1a29d0e3?w=900&q=80',
      cardio: 8,
      strength: 8,
      selfDefense: 9,
      injuryRisk: 6,
      beginnerFriendly: 6,
      recommendation: 'If self-defense matters most, lower striking-injury risk than Muay Thai while still very physical — our other top pick.',
      techniques: [
        TechniqueNote(
          title: 'Breakfall (ukemi) — the essential first skill',
          body:
              'For a backward fall: tuck chin to chest, round your back, slap the mat with both arms at 45°, exhale sharply. Taught before any throwing in every legitimate class — do not skip this.\n\n'
              'Practice at home: breakfalls onto a mattress, stance drills, grip strength work.',
        ),
      ],
      resources: [
        ResourceLink(title: 'Kodokan Judo — Jigoro Kano', source: "The founder's own text", url: 'https://archive.org/details/kodokanjudo0000kano'),
        ResourceLink(title: 'USA Judo — official resources', source: 'Find a club, rules', url: 'https://www.usjudo.org'),
      ],
    ),
    MartialArt(
      name: 'BJJ',
      imageUrl: 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=900&q=80',
      cardio: 7,
      strength: 7,
      selfDefense: 9,
      injuryRisk: 4,
      beginnerFriendly: 7,
      recommendation: 'Highest reported "addictive" factor among beginners — very social, technical, lower striking risk.',
      techniques: [
        TechniqueNote(
          title: 'Base, bridging, escaping',
          body:
              'Base: wide knees, low hips — a stable, hard-to-topple position.\n\n'
              'Bridging (upa): plant feet near hips, drive hips upward explosively while turning — the core movement behind most escapes.\n\n'
              'Shrimping: push off feet/shoulders to slide hips away from a pin.',
        ),
      ],
      resources: [ResourceLink(title: 'Judo Formal Techniques — Draeger & Otaki', source: 'Detailed grappling reference', url: 'https://archive.org/details/judo-formal-techniques-a-basic-guide-to-throwing-and-grappling-the-essentials-of-kodokan')],
    ),
    MartialArt(
      name: 'Wrestling',
      imageUrl: 'https://images.unsplash.com/photo-1517438476312-10d79c077509?w=900&q=80',
      cardio: 9,
      strength: 9,
      selfDefense: 8,
      injuryRisk: 6,
      beginnerFriendly: 5,
      recommendation: 'Highest strength/power development of any option here — physically demanding, less common as a casual beginner class.',
      techniques: [
        TechniqueNote(title: 'Stance and level change', body: 'Athletic stance with knees bent and hips low, weight on the balls of the feet — the base for every takedown.'),
      ],
      resources: [],
    ),
    MartialArt(
      name: 'Tai Chi',
      imageUrl: 'https://images.unsplash.com/photo-1552196563-55cd4e45efb3?w=900&q=80',
      cardio: 3,
      strength: 2,
      selfDefense: 2,
      injuryRisk: 1,
      beginnerFriendly: 9,
      recommendation: 'Not a substitute for the arts above — a low-impact complement for balance, coordination, and recovery days.',
      techniques: [
        TechniqueNote(title: 'What it actually provides', body: 'Well-supported for balance, coordination, and relaxation. Not meaningful cardio or strength training — pairs alongside strength/cardio work, doesn\'t replace it.'),
      ],
      resources: [],
    ),
  ];
}
