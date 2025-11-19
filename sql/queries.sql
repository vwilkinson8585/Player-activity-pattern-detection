-- 1. Basic activity summary
SELECT
    p.player_id,
    COUNT(DISTINCT d.deposit_id) AS deposit_count,
    COUNT(DISTINCT b.bet_id)    AS bet_count,
    COUNT(DISTINCT l.login_id)  AS login_count
FROM players p
LEFT JOIN deposits d ON p.player_id = d.player_id
LEFT JOIN bets      b ON p.player_id = b.player_id
LEFT JOIN logins    l ON p.player_id = l.player_id
GROUP BY p.player_id;

-- 2. Players who deposited multiple times but only placed one bet
SELECT
    p.player_id,
    COUNT(DISTINCT d.deposit_id) AS deposit_count,
    COUNT(DISTINCT b.bet_id)    AS bet_count,
    COUNT(DISTINCT l.login_id)  AS login_count
FROM players p
LEFT JOIN deposits d ON p.player_id = d.player_id
LEFT JOIN bets      b ON p.player_id = b.player_id
LEFT JOIN logins    l ON p.player_id = l.player_id
GROUP BY p.player_id
HAVING deposit_count >= 2
   AND bet_count = 1;

-- 3. Players who look consistently engaged
SELECT
    p.player_id,
    COUNT(DISTINCT d.deposit_id) AS deposit_count,
    COUNT(DISTINCT b.bet_id)    AS bet_count,
    COUNT(DISTINCT l.login_id)  AS login_count
FROM players p
LEFT JOIN deposits d ON p.player_id = d.player_id
LEFT JOIN bets      b ON p.player_id = b.player_id
LEFT JOIN logins    l ON p.player_id = l.player_id
GROUP BY p.player_id
HAVING bet_count   >= 2
   AND login_count >= 2
   AND deposit_count >= 1;

-- 4. Total staked amount (early VIP signal)
SELECT
    p.player_id,
    p.vip_tier,
    SUM(b.stake) AS total_staked
FROM players p
JOIN bets b ON p.player_id = b.player_id
GROUP BY p.player_id, p.vip_tier
ORDER BY total_staked DESC;
