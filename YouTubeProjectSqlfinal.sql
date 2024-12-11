create database YouTubeDB
use YouTubeDB
CREATE TABLE "User" (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    DateCreated DATE NOT NULL,
    Status VARCHAR(20)
);
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Description TEXT
);
CREATE TABLE Video (
    VideoID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(100) NOT NULL,
    Description TEXT,
    UploadDate DATE NOT NULL,
    Views INT DEFAULT 0,
    UserID INT,
    CategoryID INT,
    FOREIGN KEY (UserID) REFERENCES "User"(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);
CREATE TABLE Comment (
    CommentID INT PRIMARY KEY IDENTITY(1,1),
    Text TEXT NOT NULL,
    DatePosted DATE NOT NULL,
    UserID INT,
    VideoID INT,
    FOREIGN KEY (UserID) REFERENCES "User"(UserID),
    FOREIGN KEY (VideoID) REFERENCES Video(VideoID)
);
CREATE TABLE Channel (
    ChannelID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    UserID INT UNIQUE,
    FOREIGN KEY (UserID) REFERENCES "User"(UserID)
);
CREATE TABLE Subscription (
    SubscriptionID INT PRIMARY KEY IDENTITY(1,1),
    SubscriberUserID INT,
    ChannelID INT,
    FOREIGN KEY (SubscriberUserID) REFERENCES "User"(UserID),
    FOREIGN KEY (ChannelID) REFERENCES Channel(ChannelID)
);
CREATE TABLE Likes (
    LikeID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    VideoID INT,
    DateLiked DATE,
    FOREIGN KEY (UserID) REFERENCES "User"(UserID),
    FOREIGN KEY (VideoID) REFERENCES Video(VideoID)
);

INSERT INTO "User" (Username, Email, DateCreated, Status)
VALUES ('Alice', 'alice@example.com', '2023-01-01', 'Active'),
       ('Bob', 'bob@example.com', '2023-02-01', 'Active'),
	   ('Charlie', 'charlie@example.com', '2023-03-01', 'Active'),
       ('Diana', 'diana@example.com', '2023-04-01', 'Inactive'),
       ('Eve', 'eve@example.com', '2023-05-01', 'Active'),
       ('Frank', 'frank@example.com', '2023-06-01', 'Inactive'),
       ('Grace', 'grace@example.com', '2023-07-01', 'Active');


INSERT INTO Category (Name, Description)
VALUES ('Education', 'Educational content'),
       ('Gaming', 'Gaming-related content'),
	   ('Music', 'Music videos and performances'),
       ('Technology', 'Tech reviews and tutorials'),
       ('Vlogs', 'Personal vlogging content'),
       ('Comedy', 'Funny skits and stand-up comedy'),
       ('Travel', 'Travel experiences and guides');


INSERT INTO Video (Title, Description, UploadDate, Views, UserID, CategoryID)
VALUES ('SQL Tutorial', 'Learn SQL basics', '2023-01-15', 500, 1, 1),
       ('Gaming Walkthrough', 'Level 1 to 5 gameplay', '2023-02-20', 1500, 2, 2),
	   ('JavaScript Basics', 'Introduction to JavaScript', '2023-03-15', 200, 3, 1),
('How to Build a PC', 'Step-by-step guide for building a PC', '2023-03-20', 1000, 3, 4),
('Funny Cat Compilation', 'Hilarious cat videos', '2023-04-10', 5000, 4, 4),
('My Europe Trip', 'Highlights from my travel to Europe', '2023-05-05', 1500, 5, 5),
('React Tutorial', 'Learn React step-by-step', '2023-06-10', 800, 1, 1),
('Top 10 Songs of 2023', 'A countdown of the top hits of the year', '2023-07-15', 3000, 2, 3),
('Gaming Speedrun', 'Fastest completion of a popular game', '2023-07-20', 2500, 4, 2),
('Traveling in Asia', 'A guide to the best destinations in Asia', '2023-08-01', 1800, 5, 5),
('Stand-up Comedy Night', 'Full show of hilarious jokes', '2023-08-15', 2200, 2, 4),
('Tech News Roundup', 'Latest news in the world of technology', '2023-09-01', 1200, 3, 4);


INSERT INTO Channel (Name, Description, UserID)
VALUES ('Alice Channel', 'Educational videos by Alice', 1),
       ('Bob Channel', 'Gaming content by Bob', 2),
	   ('Charlie Reviews', 'Tech and gadget reviews by Charlie', 3),
('Diana’s Adventures', 'Travel and lifestyle by Diana', 4),
('Eve’s Comedy', 'Stand-up and funny content by Eve', 5),
('Frank the Gamer', 'Gaming content by Frank', 6),
('Grace’s Music', 'Music covers and performances by Grace', 7);


INSERT INTO Comment (Text, DatePosted, UserID, VideoID)
VALUES ('Great tutorial!', '2023-01-20', 2, 1),
       ('Awesome gameplay!', '2023-02-22', 1, 2),
	   ('Great tutorial on JavaScript!', '2023-03-16', 1, 3),
('Loved the PC building guide!', '2023-03-21', 2, 4),
('Cats are hilarious!', '2023-04-12', 3, 5),
('Awesome travel video!', '2023-05-07', 4, 6),
('React is so cool, thanks for this!', '2023-06-12', 5, 7),
('The songs are amazing!', '2023-07-16', 1, 8),
('Speedrun was incredible!', '2023-07-21', 3, 9),
('Great tips for Asia travel!', '2023-08-03', 2, 10),
('Can’t stop laughing at this comedy!', '2023-08-16', 4, 11),
('Loved the tech news roundup!', '2023-09-02', 5, 12);


INSERT INTO Subscription (SubscriberUserID, ChannelID)
VALUES (2, 1),
(1, 3),
(2, 4),
(3, 5),
(4, 2),
(5, 1),
(3, 2),
(4, 3),
(1, 5),
(2, 1),
(5, 4);


INSERT INTO Likes (UserID, VideoID, DateLiked)
VALUES (1, 2, '2023-02-23'), 
       (2, 1, '2023-01-21'),  
	   (1, 3, '2023-03-16'),
(2, 4, '2023-03-22'),
(3, 5, '2023-04-13'),
(4, 6, '2023-05-08'),
(5, 7, '2023-06-13'),
(1, 8, '2023-07-17'),
(2, 9, '2023-07-22'),
(3, 10, '2023-08-04'),
(4, 11, '2023-08-17'),
(5, 12, '2023-09-03');

CREATE PROCEDURE GetPopularVideos
    @MinViews INT 
AS
BEGIN
    SELECT VideoID, Title, Views, UploadDate
    FROM Video
    WHERE Views >= @MinViews
    ORDER BY Views DESC;
END;

CREATE FUNCTION GetTotalLikes (@VideoID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalLikes INT;
    
    SELECT @TotalLikes = COUNT(*)
    FROM Likes
    WHERE VideoID = @VideoID;
    
    RETURN @TotalLikes;
END;
SELECT dbo.GetTotalLikes(1) AS TotalLikes;

CREATE TRIGGER UpdateUserStatusOnUpload
ON Video
AFTER INSERT
AS
BEGIN
   
    UPDATE "User"
    SET "Status" = 'Active'
    WHERE UserID IN (SELECT DISTINCT UserID FROM inserted);
END;