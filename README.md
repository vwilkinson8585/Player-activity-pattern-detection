Player Behavior Pattern Detection – Beginner VIP Ops Project

By Vincent Wilkinson Jr.

Overview

This project is my beginner-friendly attempt at understanding how sportsbook VIP teams and player-experience roles track player activity and engagement.

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

Player Segmentation (Matches the 20 Users)
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

These queries match EXACT column names and datasets EXACTLY.

1. Find players who deposited but didn’t bet
SELECT d.player_id
FROM deposits d
LEFT JOIN bets b ON d.player_id = b.player_id
WHERE b.player_id IS NULL;

2. Find total net loss (stake - payout)
SELECT player_id,
       SUM(stake) AS total_staked,
       SUM(payout) AS total_payout,
       SUM(stake - payout) AS net_loss
FROM bets
GROUP BY player_id
ORDER BY net_loss DESC;

3. Check login activity
SELECT player_id,
       COUNT(*) AS login_count
FROM logins
GROUP BY player_id
ORDER BY login_count DESC;

4. Simple engagement score 
SELECT 
    p.player_id,
    COUNT(DISTINCT d.deposit_id) AS deposits,
    COUNT(DISTINCT b.bet_id) AS bets,
    COUNT(DISTINCT l.login_id) AS logins,
    (COUNT(d.deposit_id)*0.3 + COUNT(b.bet_id)*0.5 + COUNT(l.login_id)*0.2) AS engagement_score
FROM players p
LEFT JOIN deposits d ON p.player_id = d.player_id
LEFT JOIN bets b ON p.player_id = b.player_id
LEFT JOIN logins l ON p.player_id = l.player_id
GROUP BY p.player_id
ORDER BY engagement_score DESC;

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
