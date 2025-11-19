Player Behavior Pattern Detection – Beginner VIP Ops Project

By Vincent Wilkinson Jr.

Overview

This project is my attempt at understanding how sportsbook VIP teams and player-experience roles track player activity and engagement.

I created a simple sample dataset with 20 players and used basic SQL thinking and common-sense pattern reading to spot:

Who’s engaged

Who’s slowing down

Who deposited but didn’t bet

Who might be at risk of dropping off

Who might benefit from outreach or a check-in

I’m early in SQL, but I understand players and behavior — so this project is about showing the mindset and pattern recognition behind real VIP work.

 Dataset Structure (All Based on 20 Players)

I created four tables:

1. players

Basic profile and acquisition info.

Column	Meaning
player_id	Unique player
signup_date	First join date
region	State
channel	How they were acquired
vip_tier	Basic tier label
2. deposits

Tracks money loaded into the account.

Column	Meaning
deposit_id	Unique deposit
player_id	Who deposited
deposit_ts	When
amount	How much
method	Card/ACH/PayPal
3. bets

All wagers placed by the players.

Column	Meaning
bet_id	Unique bet
player_id	Who bet
bet_ts	When
sport	NBA/NFL/MLB/etc.
market_type	ML, Spread, Parlay, SGP
stake	Amount risked
payout	Amount returned
status	Won/Lost
4. logins

Shows how often players open the app.

Column	Meaning
login_id	Unique login
player_id	Who logged in
login_ts	When
device_type	iOS/Android/Web
🔍 What I Was Trying to Do

I wanted to answer simple but important questions a VIP Host or Player Experience Specialist thinks about:

Who’s active?

Who’s cooling off?

Who’s depositing but not betting?

Who’s showing early signs of churn?

Who’s consistent and needs maintenance?

Who might be a future VIP based on behavior?

This is the real essence of VIP Ops — reading patterns, not just pulling data.

 Key Insights 
1. Several players showed a drop in logins

Looking at the login timestamps, I could see players who went from logging in often… to barely logging in.
This usually signals:

frustration

losing streaks

confusion

or just cooling interest

These players would need a check-in.

2. Some players deposited but didn’t bet much

In the 20-player dataset, a few players made deposits but:

made zero bets, or

bet once and stopped

This is a major opportunity for onboarding support or outreach.

3. A few players were very consistent

These players show:

regular logins

multiple bets across weeks

steady deposits

These are “healthy” players that a VIP host or CX rep maintains.

4. A couple players look like early VIP candidates

Higher stakes, more bet volume, and consistent logins signal players a host would want to keep an eye on for:

tailored offers

event invitations

personalized touchpoints

Player Segmentation 
Healthy Players

Active in logins and bets

Normal behavior pattern

No major drop-offs

Softening Players

Fewer logins

Fewer bets

Smaller stakes

Mild decline

At-Risk Players

No recent bets

Little/no logins

No recent deposits

Clear drop-off

This is based on behavior, not complicated formulas.

SQL Examples 

These queries match exact column names and datasets exactly.

1. Basic activity summary
SELECT
  p.player_id,
  COUNT(DISTINCT d.deposit_id) AS deposit_count,
  COUNT(DISTINCT b.bet_id)     AS bet_count,
  COUNT(DISTINCT l.login_id)   AS login_count
FROM players p
LEFT JOIN deposits d ON p.player_id = d.player_id
LEFT JOIN bets b      ON p.player_id = b.player_id
LEFT JOIN logins l    ON p.player_id = l.player_id
GROUP BY p.player_id;


2. Players who deposited multiple times but only placed one bet
SELECT
  p.player_id,
  COUNT(DISTINCT d.deposit_id) AS deposit_count,
  COUNT(DISTINCT b.bet_id)     AS bet_count,
  COUNT(DISTINCT l.login_id)   AS login_count
FROM players p
LEFT JOIN deposits d ON p.player_id = d.player_id
LEFT JOIN bets b      ON p.player_id = b.player_id
LEFT JOIN logins l    ON p.player_id = l.player_id
GROUP BY p.player_id
HAVING deposit_count >= 2
   AND bet_count = 1;

(This highlighted players 19 and 20.)

3. Players who look consistently engaged
SELECT
  p.player_id,
  COUNT(DISTINCT d.deposit_id) AS deposit_count,
  COUNT(DISTINCT b.bet_id)     AS bet_count,
  COUNT(DISTINCT l.login_id)   AS login_count
FROM players p
LEFT JOIN deposits d ON p.player_id = d.player_id
LEFT JOIN bets b      ON p.player_id = b.player_id
LEFT JOIN logins l    ON p.player_id = l.player_id
GROUP BY p.player_id
HAVING bet_count >= 2
   AND login_count >= 2
   AND deposit_count >= 1;

players 1, 2, 4

4. Total staked amount (early VIP signal)
SELECT
  p.player_id,
  p.vip_tier,
  SUM(b.stake) AS total_staked
FROM players p
JOIN bets b ON p.player_id = b.player_id
GROUP BY p.player_id, p.vip_tier
ORDER BY total_staked DESC;

(This highlighted players 6 and 15.)

What I Learned

SQL doesn’t have to be scary — you can start simple

Logins, deposits, and bets tell a full story when you put them together

Behavior patterns show themselves faster than people think

VIP work is about timing, emphathy, and paying attention

This type of work actually fits how I naturally think

I’m still early, but this project helped me step into the mindset of a VIP Host:
spot changes, identify opportunities, and know when to reach out.

 Next Steps I Want to Add

Cleaner SQL

More players (100+)

A “reactivation playbook” for each risk tier

A simple dashboard view

Add responsible gaming signals (very high spikes)

I’m learning out loud and showing my growth with each project.

Included Files

data/players.csv (20 players)

data/deposits.csv

data/bets.csv

data/logins.csv

sql/queries.sql

case-study.pdf
