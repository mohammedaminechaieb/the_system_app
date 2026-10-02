import 'ah_models.dart';

/// A genuinely long-form, original-wording resume of the ideas popularized in
/// James Clear's Atomic Habits — ten chapters, each substantial enough to
/// read as a standalone essay. None of this is copied text from the book;
/// it's an independent explanation of the same underlying framework, with
/// added connective tissue and worked examples specific to a home-training,
/// commute-heavy, student lifestyle.
class AtomicHabitsContent {
  AtomicHabitsContent._();

  static const List<AhChapter> chapters = [
    AhChapter(
      id: 'ch1',
      number: 1,
      title: 'The Surprising Power of Small Habits',
      subtitle: 'Why 1% changes compound into everything',
      readTime: '9 min',
      sections: [
        AhSection(
          body:
              'Picture two people on the same day, doing what looks like almost nothing different. One trains for twenty minutes. The other skips it. Neither person looks different in the mirror that evening. Nothing about the scale, the mirror, or how their clothes fit has changed. If you judged the value of that twenty minutes by how much it visibly moved the needle, you would reasonably conclude it did nothing at all.\n\nThis is the central illusion that causes most people to abandon good habits and most systems built around habits to fail: we expect progress to be linear, and it almost never is. Improvement compounds — meaning each small gain multiplies the value of the gains around it rather than simply adding to them — and compounding is invisible in the short run and enormous in the long run.',
        ),
        AhSection(
          heading: 'The math of a 1% margin',
          body:
              'If you improve by just 1 percent each day for one year, you end up roughly 37 times better by the time the year is done, because the gains compound multiplicatively rather than adding up one after another. Decline works the same way in reverse: get 1 percent worse each day for a year and you decay toward almost nothing. This is not a literal formula to apply to fitness or habits — you cannot really measure "1 percent better at pushups" — but it is a genuinely useful mental model, because it explains why the difference between someone who trains three times a week for three years and someone who does nothing is not "somewhat different." It is categorically different, in a way that a single missed week explains almost none of.',
        ),
        AhSection(
          heading: 'The plateau of latent potential',
          body:
              'Here is the part almost nobody tells you honestly: for a meaningful stretch of time, doing the right things produces results that are nearly indistinguishable from doing nothing. Clear describes this as the "plateau of latent potential" — imagine an ice cube in a room that is slowly warming from 25 to 31 degrees Fahrenheit. Nothing visibly happens. The ice cube looks the same at 25, 26, 27, 28, 29, and 30 degrees. Then, at 32 degrees, it starts to melt — not because that final degree did something magical, but because all the previous degrees of unseen change finally crossed a threshold.\n\nThis maps directly onto training, studying a language, or building any skill. The visible outcome doesn\'t show up gradually and proportionally to your effort. It shows up suddenly, after a long stretch where effort seemingly produced nothing, because the underlying adaptations — neurological, physiological, habitual — were accumulating below the surface the entire time.',
          calloutLabel: 'key idea',
        ),
        AhSection(
          heading: 'Why this matters for you specifically',
          body:
              'Most people quit exactly at the point where the compounding is about to become visible, because the wait for visible proof is the hardest part, not the actual effort. If you know this in advance — genuinely expect several weeks or months of "nothing seems to be happening" before you see it in the mirror, in your numbers, or in your energy levels — you are far less likely to interpret that quiet period as evidence that the system isn\'t working. It is usually evidence that it is.',
          bullets: [
            'A missed single workout costs you almost nothing measurable — which is exactly why "just this once" feels so safe, and exactly why it is dangerous as a repeated pattern.',
            'The visible plateau period is not a sign to intensify or panic — it is the expected shape of the curve.',
            'Judge the system by the trajectory of small actions, not by the mirror this week.',
          ],
        ),
        AhSection(
          heading: 'Systems versus goals — a preview',
          body:
              'One consequence of compounding is that goals become a poor daily compass. A goal like "get fit" or "lose ten kilos" gives you no instruction for what to actually do this morning, and worse, it creates a binary win/lose framing around a process that is inherently gradual. Chapter 3 goes deep on this distinction, but it is worth planting the seed here: if results compound invisibly, then the thing you actually control day to day is not the result — it\'s the system producing it. That reframing is the foundation everything else in this resume builds on.',
        ),
      ],
    ),
    AhChapter(
      id: 'ch2',
      number: 2,
      title: 'Identity-Based Habits',
      subtitle: 'Becoming the type of person who just does this',
      readTime: '10 min',
      sections: [
        AhSection(
          body:
              'There are two fundamentally different ways to approach any change you want to make. The first is outcome-based: you focus on what you want to achieve — losing weight, running a certain distance, reading a certain number of books. The second is identity-based: you focus on who you wish to become — a person who trains, a person who reads, a person who shows up. These sound similar but produce very different behavior over time, because they operate on different levels.',
        ),
        AhSection(
          heading: 'Three layers of change',
          body:
              'Change can happen at three levels, nested inside each other like layers of an onion. The outermost layer is outcomes — what you get: the weight lost, the exam passed, the trophy won. The middle layer is process — what you do: the habits and systems you follow. The innermost, most fundamental layer is identity — what you believe about yourself: your worldview, your self-image, the judgments you make about who you are and what you are capable of.\n\nMost people build habits from the outside in. They start with an outcome they want, figure out a process to get there, and never touch identity at all. This works, but it works against a headwind, because as long as the habit still feels like something a "different kind of person" would do naturally, you are relying on discipline and motivation to force the behavior every single day. Identity-based change works from the inside out: you decide the type of person you want to be, then prove it to yourself with small wins — and the behavior starts to feel less like effort and more like consistency with who you already are.',
          calloutLabel: 'key idea',
        ),
        AhSection(
          heading: 'Every action is a vote',
          body:
              'A genuinely useful way to think about this: every action you take is like a vote for the type of person you wish to become. No single vote will transform your beliefs about yourself, in the same way no single vote will change the outcome of a national election — but as the votes accumulate, so does the evidence of your new identity. One workout does not make you "a person who trains." But a hundred votes cast in that direction, however small each individual vote was, eventually becomes difficult to deny, even to your own inner skeptic.\n\nThis is why the two-minute version of a habit (covered fully in Chapter 8) is not a cop-out — showing up and doing two minutes casts the same identity vote as a full session. The vote is "did I show up as the kind of person who does this," not "how much did I do."',
        ),
        AhSection(
          heading: 'The practical mechanism: small wins as evidence',
          body:
              'Identity change is not a slogan you repeat to yourself; affirmations without evidence rarely stick, because part of you knows they aren\'t backed by anything real. What actually works is accumulating small, concrete pieces of evidence for the identity you want. Each time you complete a workout — even a five-minute one — you are not just producing a training effect, you are also handing your self-image a data point: "I am someone who follows through." Over weeks, those data points outweigh the occasional missed day, and the identity starts to feel true rather than aspirational.',
        ),
        AhSection(
          heading: 'Applied: reframing your four core habits',
          body:
              'Instead of "I need to work out today" (outcome-flavored, and easy to argue yourself out of), try holding the frame "I am someone who trains, and today\'s training is twenty minutes." Instead of "I should read more" try "I am a person who reads — even if today that only means one page before bed." The behavior required to satisfy the second framing is the same or smaller than the first, but the psychological weight behind skipping it is different, because skipping it now contradicts a belief about yourself rather than just missing a task.',
          calloutLabel: 'applied to you',
          bullets: [
            'After any workout, however short, consciously note: "that is the kind of person I am" — don\'t evaluate the workout\'s size.',
            'When you feel resistance to a habit, ask "would the type of person I want to be skip this today?" rather than "do I feel like doing this?"',
            'Let small, repeated evidence — not motivation — be what convinces you the identity is real.',
          ],
        ),
        AhSection(
          heading: 'The caution: identity can also work against you',
          body:
              'The same mechanism cuts both ways. If you\'ve told yourself for years "I\'m not a disciplined person" or "I always quit things," each instance of following through is quietly contradicting that story, and each instance of quitting is quietly reinforcing it. This is not a reason for self-blame — it\'s a reason to be deliberate about which small actions you\'re accumulating evidence for, starting today, regardless of what the evidence said yesterday.',
        ),
      ],
    ),
    AhChapter(
      id: 'ch3',
      number: 3,
      title: 'Systems vs. Goals',
      subtitle: 'Why the scoreboard is not the strategy',
      readTime: '8 min',
      sections: [
        AhSection(
          body:
              'It feels almost heretical to say that goals are overrated, given how much of self-improvement culture is organized around setting them. But there is a real problem with using goals as your primary daily driver, and it has nothing to do with ambition — it has to do with what a goal actually is and isn\'t useful for.',
        ),
        AhSection(
          heading: 'A goal is the direction; a system is the vehicle',
          body:
              'A goal is a desired future state — "run a 10k," "reach a certain weight," "pass this course." A system is the collection of daily and weekly processes that lead there — the training schedule, the study blocks, the habit of showing up. Goals are useful exactly once: for setting direction. After that, they stop being useful as a daily tool, because a goal gives you no information about what to actually do this morning. "Get fit" doesn\'t tell you whether to squat or walk today. Your system does.',
          calloutLabel: 'key idea',
        ),
        AhSection(
          heading: 'Four specific problems with goal-fixation',
          body:
              'First, winners and losers have the same goals. Almost everyone who enters a competition wants to win it; the goal itself does not differentiate the outcome, so it cannot be the causal factor — the system each competitor follows is what differs.\n\nSecond, achieving a goal is only a momentary change. Reach the target weight and, if the underlying system reverts to what it was before, the outcome reverts too. The goal was never what sustained the result — the system was, and if the system stops, the achievement erodes regardless of how meaningful reaching it felt at the time.\n\nThird, goals restrict your happiness to a delayed, binary event. "I\'ll be satisfied once I hit X" quietly implies you are not allowed to feel good about your effort until some future date, and if you fall short, the entire period leading up to it can feel retroactively like failure — even if you built genuinely valuable habits along the way.\n\nFourth, goals are at odds with long-term progress, because once achieved, they can remove the reason to continue. Someone who "hits their goal weight" and has organized their entire identity around reaching that number sometimes has nothing left pulling them forward the next day — the system that got them there was never the point, the number was, and now the number is done.',
        ),
        AhSection(
          heading: 'What this does not mean',
          body:
              'This is not an argument against having goals at all. A goal is still useful for setting a direction and occasionally checking whether your system is actually pointed the right way. The point is narrower and more practical: don\'t rely on the goal to get you out of bed, onto the mat, or into the chair to study. Rely on the system for that, and let the goal sit quietly in the background as an occasional compass check, not a daily taskmaster.',
        ),
        AhSection(
          heading: 'Applied: this entire app is a systems tool, on purpose',
          body:
              'Notice that nothing in your daily check-in asks "are you closer to your goal weight." It asks whether you trained, meditated, slept on time, and read — process questions, not outcome questions. That\'s deliberate, not an oversight. The weekly score in your dashboard is explicitly capped so that doing more than the planned sessions doesn\'t score higher than doing exactly the planned amount — because the system rewards showing up consistently, not chasing a number.',
          calloutLabel: 'applied to you',
        ),
      ],
    ),
    AhChapter(
      id: 'ch4',
      number: 4,
      title: 'The Habit Loop',
      subtitle: 'Cue, craving, response, reward — the anatomy of every habit',
      readTime: '11 min',
      sections: [
        AhSection(
          body:
              'Every habit you have — good, bad, or neutral — runs through the same four-part sequence. Understanding this sequence is what turns habit-building from guesswork into something closer to engineering, because once you can name which part of the loop is broken, you know exactly what to fix.',
        ),
        AhSection(
          heading: 'The four stages, in detail',
          body:
              'Cue: the piece of information that predicts a reward and triggers your brain to initiate a behavior. Cues can be a time of day, a location, a preceding event, an emotional state, or the presence of certain people. Your brain is constantly scanning the environment for cues associated with either reward or threat.\n\nCraving: the motivational force behind every habit. You don\'t crave the habit itself — you crave the change in state it produces. You don\'t crave brushing your teeth; you crave the feeling of a clean mouth. You don\'t crave training; you crave the feeling of having trained, or the identity reinforcement, or the endorphin lift. Without craving, there is no reason to act.\n\nResponse: the actual habit you perform — the thought or action. Whether a craving turns into a response depends on how much friction is involved and whether you are physically and mentally capable of performing it in that moment.\n\nReward: the end goal of every habit. Rewards satisfy the craving and teach your brain which actions are worth remembering and repeating in the future. Rewards serve two purposes — they satisfy you, and they teach you, by tagging that particular behavior loop as "worth doing again" for next time a similar cue appears.',
          calloutLabel: 'key idea',
        ),
        AhSection(
          heading: 'Splitting the loop into problem and solution',
          body:
              'The four stages can be grouped into two phases. Cue and craving make up the problem phase — this is when you realize something needs to change, and you want the change. Response and reward make up the solution phase — this is where you take action and get the change you were craving. Every behavior you have is, in this sense, an attempt to solve a problem. Sometimes the problem is "I feel low energy" and the response is a walk. Sometimes it\'s the same problem and the response is scrolling a phone for forty minutes. Same craving, wildly different response, because different cues and available options were present at the time.',
        ),
        AhSection(
          heading: 'Diagnosing a habit that isn\'t sticking',
          body:
              'When a new habit fails to take root, it is almost always because one of the four stages is broken, and naming which one tells you exactly what to fix rather than vaguely trying to "have more willpower."',
          bullets: [
            'Broken cue: you genuinely forget, or nothing in your environment reminds you. Fix: make the cue obvious (Chapter 5) — lay out workout clothes, put the book on the pillow.',
            'Broken craving: the cue registers but you feel no pull toward acting on it. Fix: make it attractive (Chapter 6) — pair it with something you already enjoy, or reframe what you\'re about to do.',
            'Broken response: you want to do it but something makes it too hard, too far away, or too complicated in the moment. Fix: make it easy (Chapter 7 and the two-minute rule in Chapter 8) — reduce the number of steps between you and starting.',
            'Broken reward: you do it, but it feels unsatisfying or the payoff is too delayed to reinforce the loop. Fix: make it satisfying (Chapter 8) — add a small, immediate marker of completion.',
          ],
        ),
        AhSection(
          heading: 'Why bad habits are so persistent',
          body:
              'Bad habits typically run through the exact same four-stage loop with no missing steps — which is precisely why they\'re so hard to shake. The cue is obvious (phone buzzes), the craving is real (want the dopamine hit or distraction), the response is nearly frictionless (unlock, tap), and the reward is immediate (novel content, instantly). A new good habit usually has to compete against an existing loop that has all four stages already optimized. This is not a reason for despair — it\'s a reason to be deliberate about deliberately engineering at least as much ease and reward into the new habit as the old one already enjoys.',
        ),
      ],
    ),
    AhChapter(
      id: 'ch5',
      number: 5,
      title: 'The First Law — Make It Obvious',
      subtitle: 'Cues, environment design, and implementation intentions',
      readTime: '12 min',
      sections: [
        AhSection(
          body:
              'Most people are surprisingly unaware of what actually triggers their own behavior. Before you can change a habit, you have to notice it — and this alone, simply becoming aware of what precedes an action, is a genuinely underrated first step that most habit advice skips over in favor of jumping straight to willpower and motivation.',
        ),
        AhSection(
          heading: 'Environment beats willpower — reliably',
          body:
              'Your environment is the invisible hand that shapes behavior far more than most people credit. A bowl of fruit on the counter gets eaten more than fruit hidden in a drawer, not because anyone made a different willpower-driven decision, but because visibility itself is a cue. This has an enormous, underused implication: you can change your behavior substantially without ever touching your motivation, simply by rearranging what is visible, accessible, and in your path versus what is hidden, distant, and requires extra steps.\n\nFor a home-training, no-equipment setup specifically, this is one of the single highest-leverage moves available: if your mat is rolled up and stored in a closet, opening a new habit requires an extra decision and an extra ninety seconds of friction every single day. If it\'s unrolled and visible in the room you walk through each evening, the cue is doing work for you before you\'ve consciously decided anything.',
          calloutLabel: 'key idea',
        ),
        AhSection(
          heading: 'One space, one use — where possible',
          body:
              'A subtler environment principle: habits are easier to sustain when each physical space is associated with a narrower set of behaviors. A bed used only for sleep becomes a stronger cue for sleep than a bed also used for scrolling, snacking, and working — because the cue-behavior association gets diluted across incompatible uses. This is obviously hard to fully implement in a small student living space, but even a partial version helps: designating one specific corner or mat placement as "the training spot," used only for that, builds a cleaner cue over time than training wherever there happens to be space that day.',
        ),
        AhSection(
          heading: 'Implementation intentions: deciding in advance beats deciding in the moment',
          body:
              'Vague intentions like "I\'ll exercise more" or "I\'ll meditate when I get a chance" perform poorly in adherence research compared to specific implementation intentions — plans that name the exact time, location, and trigger in advance: "I will do a twenty-minute strength session at 17:30 in the living room" or "I will meditate for five minutes at my desk, right after I finish lunch." The mechanism is straightforward: deciding in advance removes an entire decision point from the moment itself. When 17:30 arrives, you are not asking "should I train now?" — a question your tired evening brain can talk you out of — you are simply executing a plan your rested morning brain already committed to.',
        ),
        AhSection(
          heading: 'The formula: "I will [BEHAVIOR] at [TIME] in [LOCATION]"',
          body:
              'This exact sentence structure, filled in specifically, is one of the most well-evidenced small interventions in behavior-change research. Vague versions of the same intention produce measurably worse follow-through. Filling in all three blanks — behavior, time, location — removes ambiguity that would otherwise require a fresh decision each day.',
          bullets: [
            'Weak: "I\'ll meditate more this week."',
            'Strong: "I will meditate for five minutes at 07:00, sitting on the edge of my bed, right after my alarm."',
            'Weak: "I should train after work."',
            'Strong: "I will do my 30-minute strength routine at 17:30, in the living room, right after I change out of commute clothes."',
          ],
        ),
        AhSection(
          heading: 'Habit stacking — borrowing an existing cue',
          body:
              'A close cousin of the implementation intention is habit stacking: instead of anchoring a new habit to a specific clock time, you anchor it to the completion of an existing, already-automatic habit. The formula is "After [CURRENT HABIT], I will [NEW HABIT]." This works because the existing habit is already deeply cued and doesn\'t require willpower to trigger — you are hijacking that automaticity for the new behavior riding along behind it. "After I get home from my commute, I will change into training clothes" is a stronger anchor than a clock time, because clock times can slip when a train is late, but the sequence "get home → change clothes" survives most disruptions to your day.',
        ),
        AhSection(
          heading: 'Applied: your specific cue design',
          body:
              'Given a long commute and a fixed 08:30–16:15 study/work block, the highest-leverage cues to design deliberately are the transition points — the moments where one context ends and another begins, since these are naturally occurring "reset points" your brain already treats as decision moments.',
          bullets: [
            'After arriving home from commute → change into training clothes immediately, before sitting down (sitting down first is a friction point that kills the habit stack).',
            'After dinner is cleared → open the book/app for the reading habit, same spot every time.',
            'Training gear stays visible and set up, not stored away, minimizing the decision cost each evening.',
            'Morning meditation is stacked immediately after the alarm, before checking the phone — not "sometime in the morning."',
          ],
          calloutLabel: 'applied to you',
        ),
      ],
    ),
    AhChapter(
      id: 'ch6',
      number: 6,
      title: 'The Second Law — Make It Attractive',
      subtitle: 'Craving, temptation bundling, and the role of social proof',
      readTime: '10 min',
      sections: [
        AhSection(
          body:
              'The more attractive an opportunity is, the more likely it is to become habit-forming. This sounds obvious, but the mechanism underneath it — and the practical levers for engineering attractiveness deliberately rather than waiting to feel motivated — is where the useful detail lives.',
        ),
        AhSection(
          heading: 'Dopamine drives craving, not just reward',
          body:
              'A common misconception is that dopamine is released only when you get the reward. In reality, dopamine spikes in anticipation of a reward, not just on receiving it — which is why anticipation and craving can feel almost as motivating as the reward itself, and why "getting started" is so often the hardest part: the anticipatory dopamine hasn\'t built up yet because you haven\'t begun. This is also why habit cues that reliably predict a good outcome become powerful on their own — your brain starts producing motivation the moment it recognizes the cue, before the reward has actually arrived.',
        ),
        AhSection(
          heading: 'Temptation bundling',
          body:
              'One of the most directly useful tools from this chapter: pair an action you need to do with an action you want to do. The formula is "After [HABIT I NEED], I will [HABIT I WANT]" — or, run in reverse and made conditional, "I only get to [THING I WANT] while doing [HABIT I NEED]." A genuinely common and effective example: a specific podcast or show is only allowed during training sessions, nowhere else. This doesn\'t require you to manufacture enthusiasm for training out of nothing — it borrows enthusiasm from something you already look forward to and welds it onto the harder behavior.',
          calloutLabel: 'key idea',
        ),
        AhSection(
          heading: 'The role of social proof and belonging',
          body:
              'Humans are powerfully drawn to imitate three groups: the close (family and friends), the many (the crowd, whatever a large group around us is doing), and the powerful (people with status we respect). Habits are contagious partly because we unconsciously pick up the behaviors of people we spend time around. This has a direct, practical implication for anything social — like joining a martial arts class or a training group: the environment itself starts doing motivational work for you, because showing up becomes the "normal" behavior of the group you\'re now part of, not a special act of individual willpower each time.',
        ),
        AhSection(
          heading: 'Reframing the internal narrative',
          body:
              'Motivation rituals — small pre-habit routines that put you in a particular headspace — can make a behavior feel more attractive before you even start it, similar to how an athlete\'s warm-up routine primes them psychologically as well as physically. Equally powerful is deliberately reframing how you talk to yourself about a hard habit: "I get to train" rather than "I have to train" is not just a semantic trick — repeated reframing genuinely shifts the emotional weight of the behavior over time, from obligation toward something closer to privilege or choice.',
        ),
        AhSection(
          heading: 'Applied: making your specific habits more attractive',
          body:
              'Given the constraints of home training and a busy schedule, attractiveness is often the most neglected of the Four Laws — plans tend to focus heavily on obviousness and ease while assuming motivation will simply show up. It won\'t reliably. Engineer it instead.',
          bullets: [
            'Bundle strength training with a specific podcast/show/playlist reserved only for that time.',
            'If considering a martial arts class, prioritize the social pull — a gym whose people you like showing up for beats a technically "better" gym whose culture doesn\'t attract you back.',
            'Reframe the morning meditation from "another thing on the list" to "the two minutes where nothing is required of me" — attractive framing, same behavior.',
            'For reading/learning, protect a specific comfortable spot (a chair, good lighting) reserved for that purpose — the physical comfort itself becomes part of the attraction.',
          ],
          calloutLabel: 'applied to you',
        ),
      ],
    ),
    AhChapter(
      id: 'ch7',
      number: 7,
      title: 'The Third Law — Make It Easy',
      subtitle: 'Friction, the law of least effort, and priming your environment',
      readTime: '11 min',
      sections: [
        AhSection(
          body:
              'Human behavior follows the law of least effort: given a choice between two similarly rewarding options, we gravitate naturally toward whichever requires less work. This is not laziness in any moral sense — it\'s a deeply sensible energy-conservation feature of how brains evolved. The practical implication is enormous: the goal is not to force more discipline through a high-friction habit, but to systematically reduce the friction on good habits and increase it on bad ones, so the "path of least resistance" and "the thing you actually want to do" point in the same direction.',
        ),
        AhSection(
          heading: 'Priming the environment for future you',
          body:
              'A genuinely powerful and underused technique: prepare your environment in advance to make future actions easier, essentially doing a favor for the version of you who will be tired, rushed, or unmotivated later. Laying out training clothes the night before, pre-filling a water bottle, or leaving a book open on the exact page you stopped at all reduce the number of decisions and physical steps required to start — and every removed step measurably increases the odds the habit actually happens on a low-willpower day, which is precisely the day it matters most.',
          calloutLabel: 'key idea',
        ),
        AhSection(
          heading: 'The friction is often not where you think it is',
          body:
              'People frequently misdiagnose why a habit isn\'t sticking, blaming motivation when the real problem is a small but consistently overlooked piece of friction. If a habit requires unpacking equipment, changing in a different room, or a five-minute setup before anything productive happens, that setup cost is often the actual reason for skipped days — not lack of desire. The fix isn\'t more willpower; it\'s identifying and removing that specific friction point, one time, permanently.',
        ),
        AhSection(
          heading: 'The 20-second rule and its inverse',
          body:
              'A rough but useful heuristic: reducing the number of steps between you and a good habit by even twenty seconds meaningfully increases adherence, and adding twenty seconds of friction to a bad habit meaningfully decreases it. This is why "phone charges outside the bedroom" works better than "I\'ll just have more discipline about not checking my phone in bed" — the second relies on willpower fighting zero friction; the first inserts real friction that willpower doesn\'t need to fight at all, because the behavior requires getting up.',
        ),
        AhSection(
          heading: 'Reducing friction on good habits, applied',
          body: 'Systematic friction audit for a home-training, commute-heavy schedule:',
          bullets: [
            'Training clothes laid out the night before, not found and changed into fresh each time.',
            'A specific, unchanging spot for the mat/space so no setup decision is needed.',
            'Reading material physically placed somewhere you\'ll see it at the exact trigger time (on the pillow, on the desk you sit at after dinner).',
            'Meal-prep or simple default meals reduce the friction of eating reasonably on tired days — see the Nutrition section for specifics.',
            'If a martial arts gym bag needs packing, pack it the night before a class day, not the morning of.',
          ],
        ),
        AhSection(
          heading: 'Increasing friction on habits you want less of',
          body:
              'The inverse works just as reliably. Increasing the number of steps between you and a behavior you\'re trying to reduce — deleting an app instead of just muting it, leaving your phone in another room during a focus block, not keeping snack food easily visible if that specific pattern bothers you — outperforms relying on in-the-moment willpower, because it removes the decision from a moment when your judgment is most likely to be compromised by tiredness or stress.',
        ),
      ],
    ),
    AhChapter(
      id: 'ch8',
      number: 8,
      title: 'The Fourth Law — Make It Satisfying',
      subtitle: 'The two-minute rule, immediate rewards, and tracking',
      readTime: '12 min',
      sections: [
        AhSection(
          body:
              'The first three laws increase the odds a behavior happens once. The fourth law is what makes it likely to happen again — because what is immediately rewarded gets repeated, and what is immediately punished or simply unrewarding gets avoided, regardless of how good the delayed outcome actually is.',
        ),
        AhSection(
          heading: 'The mismatch between immediate and delayed rewards',
          body:
              'Human brains evolved to prioritize immediate outcomes over delayed ones — a sensible survival trait in an ancestral environment with few delayed-gratification scenarios, and a genuinely maladaptive trait in a modern environment full of them. This is precisely why habits with an immediate cost and a delayed reward (exercise, saving money, studying) are hard, while habits with an immediate reward and a delayed cost (junk food, procrastination, impulse spending) are easy. The fourth law is essentially a workaround for this mismatch: since you can\'t rewire millions of years of evolved reward-timing, you instead attach a small immediate reward onto the habit with the delayed payoff, bridging the gap artificially until the real, larger reward eventually arrives.',
          calloutLabel: 'key idea',
        ),
        AhSection(
          heading: 'The two-minute rule',
          body:
              'When starting any new habit, it should take less than two minutes to do. "Read thirty pages a night" becomes "read one page." "Do a full workout" becomes "put on training shoes." "Meditate for twenty minutes" becomes "take one conscious breath." This is not a permanently reduced version of the habit — it is a deliberately shrunk entry point, designed to master the crucial first skill of showing up, before worrying about performing well. Almost every habit can be scaled down to a two-minute "gateway" version, and the gateway version is what should actually be scheduled and protected on hard days, with anything beyond it treated as a bonus rather than the baseline requirement.\n\nThe deeper reasoning: motivation and energy fluctuate wildly day to day, but the decision to start does not require motivation nearly as much as continuing does. Standardizing on "just start the two-minute version" removes the need to correctly predict your future motivation in advance — you simply always start, and let momentum decide whether it continues.',
        ),
        AhSection(
          heading: 'Immediate rewards, engineered deliberately',
          body:
              'Because visible progress is itself rewarding, a simple physical or visual tracking action — a checkbox ticked, a mark on a calendar — functions as a real, if small, immediate reward: satisfying in the moment, separate from whatever the eventual outcome will be. This is why a habit tracker is not just a record-keeping tool — the act of marking something complete is itself part of what reinforces the habit loop, and losing that tracker (or letting it fall out of use) quietly removes one of the few immediate rewards a delayed-payoff habit had.',
        ),
        AhSection(
          heading: 'Never miss twice',
          body:
              'A single missed day is close to statistically meaningless for any long-run outcome — the compounding math from Chapter 1 barely notices one skipped session. But missing twice in a row starts to establish a new pattern, and the brain is very good at rapidly generalizing "I don\'t really do this anymore" from just two data points. The practical rule that follows: treat any miss as an isolated event to recover from immediately, not as evidence to update your identity on. The very next opportunity should be the two-minute version if nothing else — not skipped, and importantly, not "made up for" with a doubled or extra-hard session, since overcompensating after a miss is itself a common cause of injury, burnout, or a second miss shortly after.',
          calloutLabel: 'key idea',
        ),
        AhSection(
          heading: 'Accountability makes unsatisfying costs visible',
          body:
              'One further lever on the "make it satisfying" law works in the opposite direction: making the cost of not doing a habit immediately unsatisfying, rather than only making the habit itself rewarding. A habit contract or an accountability partner who will notice a missed commitment introduces a small immediate social cost to skipping — which, for many people, is a more reliable behavioral lever than any amount of self-directed willpower, because the discomfort of letting someone else down tends to be felt more acutely and immediately than the abstract future cost of an unmet personal goal.',
        ),
        AhSection(
          heading: 'Applied: this app\'s streak and points system, explained',
          body:
              'The point and streak mechanics in this app are a direct, deliberate application of this chapter. Ticking a habit awards points immediately — a small, real, immediate reward, satisfying the fourth law directly rather than only tracking for the sake of records. The streak counter exists for the same reason a paper habit tracker works: visible, accumulating progress is itself motivating, separate from the outcome it\'s eventually meant to produce. And the streak-freeze mechanic is a direct implementation of "never miss twice, but don\'t let one miss become catastrophic" — a single bad day costs a freeze, not the entire accumulated streak, softening the punishment just enough to avoid the common failure mode where one missed day triggers total abandonment ("I already broke my streak, so what\'s the point now").',
          calloutLabel: 'applied to you',
        ),
      ],
    ),
    AhChapter(
      id: 'ch9',
      number: 9,
      title: 'Breaking Bad Habits — The Inversion',
      subtitle: 'Running the Four Laws backward',
      readTime: '9 min',
      sections: [
        AhSection(
          body:
              'Everything covered so far describes how to build a habit you want. The same four-law framework, run in reverse, describes how to break a habit you don\'t want — and understanding both directions at once is what makes the framework feel like a genuinely complete system rather than a loose collection of separately useful tips.',
        ),
        AhSection(
          heading: 'The inverted Four Laws',
          body: '',
          bullets: [
            'Make it invisible — remove the cue. If a behavior\'s trigger never appears, the craving that follows rarely arises unprompted. This is why "just have more willpower around your phone" underperforms "leave the phone in another room" — the second removes the cue entirely rather than asking willpower to fight it repeatedly.',
            'Make it unattractive — reframe the narrative. Highlight the real downsides of the behavior rather than only its short-term appeal; deliberately noticing what a habit costs you (in time, energy, how you feel afterward) shifts the emotional weight attached to the cue over repeated exposure.',
            'Make it difficult — increase friction. Add real physical or logistical steps between you and the unwanted behavior. Even small increases in friction meaningfully reduce a habit\'s frequency, because most bad habits are performed somewhat automatically and don\'t survive an added decision point.',
            'Make it unsatisfying — attach an immediate cost. A visible accountability mechanism, a small real penalty, or simply having someone else aware of the habit converts a private, consequence-free slip into one with an immediate, felt cost.',
          ],
          calloutLabel: 'key idea',
        ),
        AhSection(
          heading: 'Why bad habits persist despite genuinely wanting to stop',
          body:
              'It is entirely possible to sincerely want to stop a habit and still fail repeatedly, and this is not typically a willpower deficiency — it usually means the habit is still satisfying a real underlying craving that hasn\'t been redirected anywhere else. Removing a habit without addressing what craving it was satisfying tends to produce a vacuum that gets refilled by another, sometimes worse, habit shortly after. The more durable approach identifies the underlying craving first (boredom relief, stress relief, social connection, a break from a task) and finds a different, less costly response that satisfies the same craving, rather than trying to eliminate the craving itself.',
        ),
        AhSection(
          heading: 'Applied: a worked example',
          body:
              'Suppose the fun/entertainment block on a given evening reliably swallows far more time than intended. Rather than trying to will yourself into stopping through pure self-control each night, the inversion framework asks four separate, more answerable questions: What\'s the cue — is it boredom right after dinner, or the couch itself, or a specific notification? Can it be made invisible — a different physical spot for winding down, notifications off during that window? What\'s attractive about it — likely genuine relaxation and stimulation after a demanding day, a real craving, not a fake one — so what else could satisfy that same craving with a natural stopping point, like a single episode versus an open-ended feed? Can friction be added — a timer, logging out after each session rather than staying perpetually signed in? And what would make overuse feel unsatisfying — perhaps simply noticing and logging how it affects the next morning\'s energy, making the delayed cost visible sooner.',
        ),
        AhSection(
          heading: 'A note on self-compassion here',
          body:
              'None of this framework is designed to produce guilt, and guilt is usually counterproductive to actually applying it — a person who feels ashamed of a habit is often less able to calmly analyze its cue-craving-response-reward structure, because shame narrows attention toward self-judgment rather than toward the mechanics of the problem. The inversion technique works best approached the same way you\'d debug anything else: curious and mechanical, not moralizing.',
        ),
      ],
    ),
    AhChapter(
      id: 'ch10',
      number: 10,
      title: 'Putting It All Together',
      subtitle: 'A tiered priority system for your actual life',
      readTime: '10 min',
      sections: [
        AhSection(
          body:
              'Nine chapters of framework is a lot to hold in mind at once, and trying to apply every technique simultaneously to every habit is itself a common way this kind of system fails — the advice becomes another source of overwhelm rather than a simplification. This final chapter exists to compress everything into an explicit, ordered priority list: what to actually implement first, second, and only-if-needed, specifically for a student schedule built around a long commute, home training, and limited daily energy.',
        ),
        AhSection(
          heading: 'Tier S — implement these first, before anything else',
          body:
              'These three techniques solve the two biggest structural risk factors in this specific lifestyle: a schedule with limited, unpredictable daily energy, and long commute stretches that eat into willpower before habits even get attempted.',
          bullets: [
            'The two-minute rule — every habit gets a genuine, always-achievable minimum version. This alone prevents most missed days.',
            'Environment design — training clothes laid out, mat visible, book on the pillow. Removes decisions before they need to be made.',
            'Implementation intentions — every habit gets a specific time, location, and trigger written down in advance, not left as a vague daily intention.',
          ],
        ),
        AhSection(
          heading: 'Tier A — add once Tier S feels automatic (roughly weeks 2–4)',
          body: '',
          bullets: [
            'Habit stacking — anchor new habits to existing automatic ones (arriving home, finishing dinner).',
            'Friction reduction on good habits, friction addition on habits you\'re trying to reduce.',
            'Never-miss-twice as an explicit, pre-committed rule for what happens after any missed day.',
          ],
        ),
        AhSection(
          heading: 'Tier B — reinforcement layer (ongoing, low effort)',
          body: '',
          bullets: [
            'Identity-based framing — consciously noting "that\'s the kind of person I am" after small wins.',
            'Immediate rewards — the habit tracker itself, small deliberate self-acknowledgment.',
            'Temptation bundling — pairing harder habits with something you already enjoy.',
          ],
        ),
        AhSection(
          heading: 'Tier C — only if a specific problem shows up',
          body: '',
          bullets: [
            'Full inversion technique for a specific named bad habit that has become a real, identified problem.',
            'Elaborate external accountability systems or contracts — useful, but overkill as a default for every habit.',
          ],
        ),
        AhSection(
          heading: 'The honest summary, if you remember nothing else',
          body:
              'Small actions compound in ways that are invisible in the short run and enormous over years, so judge your system by its trajectory, not this week\'s mirror. Identity change — becoming the kind of person who does this — is more durable than outcome-chasing, and is built through small accumulated evidence, not affirmations. Systems, not goals, are what you actually touch on a Tuesday morning. Every habit runs through cue, craving, response, and reward, and diagnosing a struggling habit means finding which of those four is actually broken. And the Four Laws — obvious, attractive, easy, satisfying — are a genuinely complete toolkit: apply them to build a habit, invert them to break one, and default to their two-minute versions whenever a "real" version isn\'t realistic that day.\n\nNone of this replaces just starting. The framework is a set of tools for making starting easier and repeating more likely — it was never a substitute for actually doing the two minutes today.',
          calloutLabel: 'key idea',
        ),
      ],
    ),
  ];
}
