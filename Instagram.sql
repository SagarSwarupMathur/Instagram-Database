-- We want to reward the user who has been around the longest, Find the 5 oldest users.
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

-- To target inactive users in an email ad campaign, find the users who have never posted a photo.
SELECT username, image_url FROM users AS us
LEFT JOIN photos AS p 
ON us.id = p.user_id
WHERE p.image_url IS NULL; -- option 1

SELECT * FROM users 
WHERE id NOT IN (SELECT user_id FROM photos); -- option 2 

-- Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
SELECT username, photos.id, image_url, count(*) AS total_likes FROM users
INNER JOIN photos 
ON photos.user_id=users.id
INNER JOIN likes 
ON likes.photo_id=photos.id
GROUP BY photo_id
ORDER BY total_likes DESC
LIMIT 1; 

-- The investors want to know how many times does the average user post.
SELECT ROUND((SELECT COUNT(*) FROM photos)/(SELECT count(*) FROM users),2) AS average;

-- A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
SELECT tag_name, COUNT(tag_name) AS total 
FROM tags 
INNER JOIN photo_tags 
ON tags.id=photo_tags.tag_id
GROUP BY tag_id
ORDER BY total DESC 
LIMIT 5; 

-- To find out if there are bots, find users who have liked every single photo on the site.
SEELCT username, COUNT(*) liked_photos FROM users
INNER JOIN likes 
ON users.id=likes.user_id
GROUP BY likes.user_id
HAVING liked_photos = (SELECT COUNT(*) FROM photos); 

-- Find the users who have created instagramid in may and select top 5 newest joinees from it?
SELECT username, created_at FROM users 
WHERE monthname(created_at)='may' 
ORDER BY created_at DESC
LIMIT 5;

-- Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?
SELECT username, users.id FROM users
INNER JOIN photos 
ON photos.user_id=users.id
INNER JOIN likes 
ON likes.photo_id=photos.id
GROUP BY username 
HAVING username regexp'^[C]' AND username regexp '[0-9]+';

-- Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
SELECT username, user_id,COUNT(*) AS num_photos 
FROM users
INNER JOIN photos 
ON photos.user_id=users.id
GROUP BY username
HAVING num_photos BETWEEN 3 AND 5
ORDER BY num_photos DESC
LIMIT 30;