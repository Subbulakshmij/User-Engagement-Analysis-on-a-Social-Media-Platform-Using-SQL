/*2 We want to reward the user who has been around the longest, Find the 5 oldest users. --

select id,  username, created_at from users 
order by 3 
limit 5;

/*3. To target inactive users in an email ad campaign, find the users who have never posted a
photo.*/
select id, username from users where id not in(
select user_id from photos);

/* 4. Suppose you are running a contest to find out who got the most likes on a photo. Find out who
won? */
select 
u.id, username, count(*) from users u join photos p on u.id= p.user_id
join likes l on p.id = l.photo_id
group by 1, 2
order by count(*) desc
limit 3;

/* 5. The investors want to know how many times does the average user post. */
SELECT 
    (SELECT COUNT(*) FROM photos) / (SELECT COUNT(DISTINCT user_id) FROM photos) AS average_posts_per_user;
 -- (or)--
select count(*) /  count(distinct user_id) from users u join photos p 
on u.id = p.user_id;

/* 6. A brand wants to know which hashtag to use on a post, and find the top 5 most used
hashtags.*/
SELECT t.tag_name, COUNT(*) AS hashtag_count
FROM photo_tags pt
JOIN tags t ON pt.tag_id = t.id
GROUP BY t.tag_name
ORDER BY hashtag_count DESC
LIMIT 5;

/* 7. To find out if there are bots, find users who have liked every single photo on the site.*/
SELECT l.user_id, u.username, count(*)
FROM users u
JOIN likes l ON u.id = l.user_id
JOIN photos p ON l.photo_id =p.id
GROUP BY l.user_id, u.username
HAVING COUNT(DISTINCT l.photo_id) = COUNT(DISTINCT p.id)
order by count(*) desc;

/* 7. To find out if there are bots, find users who have liked every single photo on the site.*/
SELECT l.user_id, u.username, count(*)
FROM users u
JOIN likes l ON u.id = l.user_id
JOIN photos p ON l.photo_id =p.id
GROUP BY l.user_id, u.username
HAVING COUNT(DISTINCT l.photo_id) = COUNT(DISTINCT p.id)
order by count(*) desc;

/* 8. Find the users who have created instagram_id in may and select top 5 newest joinees from it? */
select id, username, created_at from users where month(created_at) = 5 
order by created_at desc
limit 5;

/* 9. Can you help me find the users whose name starts with c and ends with any number and have
posted the photos as well as liked the photos?*/
select distinct u.id, username from users u join photos p on u.id= p.user_ID
join likes l on u.id = l.user_id where username rlike '^c.*[0-9]$';

/* 10. Demonstrate the top 30 usernames to the company who have posted photos in the range of 3
to 5. */
select u.id, username, count(*) from users u join photos p on u.id = p.user_id
group by 1, 2
having count(*) between 3 and 5
order by count(*)
limit 30;