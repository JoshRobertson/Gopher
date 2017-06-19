-- -----------------------------------------------------
-- Schema gopher
-- -----------------------------------------------------
DROP DATABASE gopher;
CREATE DATABASE IF NOT EXISTS `gopher`;
USE `gopher`;

-- -----------------------------------------------------
-- Table `gopher`.`user_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
);


-- -----------------------------------------------------
-- Table `gopher`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(75) NOT NULL,
  `nameFirst` VARCHAR(50) NULL,
  `nameLast` VARCHAR(75) NULL,
  `email` VARCHAR(75) NOT NULL,
  `phoneHome` VARCHAR(20) NULL,
  `phoneWork` VARCHAR(20) NULL,
  `phoneMobile` VARCHAR(20) NULL,
  `password` CHAR(128) NULL,
  `salt` CHAR(32) NULL,
  `joinDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userTypeId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`userTypeId`)
    REFERENCES `user_types` (`id`)
);


-- -----------------------------------------------------
-- Table `gopher`.`address_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `address_types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
);


-- -----------------------------------------------------
-- Table `gopher`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addresses` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `addressLine1` VARCHAR(75) NULL,
  `addressLine2` VARCHAR(75) NULL,
  `city` VARCHAR(75) NULL,
  `province` VARCHAR(75) NULL,
  `country` VARCHAR(75) NULL,
  `zip` VARCHAR(10) NULL,
  `latitude` DOUBLE NULL,
  `longitude` DOUBLE NULL,
  `userId` INT UNSIGNED NOT NULL,
  `addressTypeId` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`userId`)
    REFERENCES `users` (`id`),
  FOREIGN KEY (`addressTypeId`)
    REFERENCES `address_types` (`id`)
);


-- -----------------------------------------------------
-- Table `gopher`.`rewards`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `rewards` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(150) NULL,
  `rewardValue` INT NULL,
  PRIMARY KEY (`id`)
);


-- -----------------------------------------------------
-- Table `gopher`.`status_types`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `status_types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
);



-- -----------------------------------------------------
-- Table `gopher`.`importance_types`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `importance_types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
);

-- -----------------------------------------------------
-- Table `gopher`.`errands`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `errands` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100),
  `description` VARCHAR(250),
  `creationDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completionDate` TIMESTAMP NULL,
  `deadline` TIMESTAMP NULL,
  `rewardId` INT UNSIGNED NOT NULL,
  `statusTypeId` INT UNSIGNED NOT NULL,
  `importanceTypeId` INT UNSIGNED NOT NULL,
  `userIdCustomer` INT UNSIGNED NOT NULL,
  `userIdGopher` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`rewardId`)
    REFERENCES `rewards` (`id`),
  FOREIGN KEY (`statusTypeId`)
    REFERENCES `status_types` (`id`),
  FOREIGN KEY (`importanceTypeId`)
    REFERENCES `importance_types` (`id`),
  FOREIGN KEY (`userIdCustomer`)
    REFERENCES `users` (`id`),
  FOREIGN KEY (`userIdGopher`)
    REFERENCES `users` (`id`)
);



-- -----------------------------------------------------
-- Table `gopher`.`categories`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `categories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
);



-- -----------------------------------------------------
-- Table `gopher`.`errand_categories`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `errand_categories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `errandId` INT UNSIGNED NOT NULL,
  `categoryId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`errandId`)
    REFERENCES `errands` (`id`),
  FOREIGN KEY (`categoryId`)
    REFERENCES `categories` (`id`)
);


-- -----------------------------------------------------
-- Table `gopher`.`tasks`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `tasks` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(250) NULL,
  `startDate` TIMESTAMP NULL DEFAULT NULL,
  `completionDate` TIMESTAMP NULL DEFAULT NULL,
  `errandId` INT UNSIGNED NOT NULL,
  `addressesId` INT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`errandId`)
    REFERENCES `errands` (`id`),
  FOREIGN KEY (`addressesId`)
    REFERENCES `addresses` (`id`)
);


-- -----------------------------------------------------
-- Table `gopher`.`ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ratings` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ratingValue` INT NOT NULL,
  `comments` VARCHAR(150) NULL,
  `creationDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userIdRated` INT UNSIGNED NOT NULL,
  `userIdRater` INT UNSIGNED NOT NULL,
  `errandId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`userIdRated`)
    REFERENCES `users` (`id`),
  FOREIGN KEY (`userIdRater`)
    REFERENCES `users` (`id`),
  FOREIGN KEY (`errandId`)
    REFERENCES `errands` (`id`)
);



-- -----------------------------------------------------
-- Table `gopher`.`notification_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `notification_types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
);


-- -----------------------------------------------------
-- Table `gopher`.`notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NOT NULL,
  `message` VARCHAR(150) NULL,
  `userId` INT UNSIGNED NOT NULL,
  `notificationTypeId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`userId`)
    REFERENCES `users` (`id`),
  FOREIGN KEY (`notificationTypeId`)
    REFERENCES `notification_types` (`id`)
);
INSERT INTO `user_types` (name) VALUES("Gopher"),("Admin"),("Customer");

INSERT INTO `users` (`id`,`username`,`nameFirst`,`nameLast`,`email`,`phoneHome`,`phoneWork`,`phoneMobile`,`password`,`salt`,`joinDate`,`userTypeId`) VALUES 
(1,"ImYourGopher","Lisandra","Baldwin","non@rutrumjustoPraesent.com","(866) 746-4300","(671) 847-4332","(129) 316-3777","WZV18LBD2VZ","XMF20IBU9VB","2016-02-20 02:47:14",1),
(2,"busy_bee","Nichole","Bell","at.auctor@est.ca","(407) 113-2519","(996) 333-8832","(652) 237-6492","WOX67DFD5QO","LKR43BFV1MF","2015-11-29 15:13:22",1),
(3,"count_On_Me","Judith","Cooke","semper.cursus@Integereu.com","(845) 473-5370","(207) 778-4224","(202) 201-2275","EVV69JJW2EA","KUQ90JRE0JA","2016-01-08 13:06:00",3),
(4,"GetErDone","Ellis","Smith","accumsan.interdum.libero@hendrerita.co.uk","(904) 517-5673","(193) 202-8573","(314) 248-4130","VTP55XOL1YQ","ZNI46CIT8JA","2016-03-29 12:07:06",1),
(5,"happy_toad","Larissa","Gaines","ligula@loremeumetus.com","(429) 679-8241","(888) 266-0570","(514) 613-0337","ISX53DEL7XX","WRD26AHZ6HD","2016-01-18 08:08:58",2);

INSERT INTO `importance_types` (name) VALUES ("Very Low"), ("Low"),("Normal"),("High"),("Very High");

INSERT INTO `status_types` (name) VALUES ("Completed"),("Not Started"),("In Progress");

INSERT INTO `rewards` (`id`,`name`,`description`,`rewardValue`) VALUES 
(1,"$50.00 cash","I will give you $50.00 cash to complete this errand for me.",50),
(2,"Money","I will pay you $10.00 in cash",10),
(3,"Keurig Machine","I will give you my extra Keurig Machine (brand new)",100),
(4,"Gift Card","I will pay you a $50.00 gift card to Walmart",50),
(5,"Money","I will pay you $25.00 in cash",25);

INSERT INTO `errands` (`name`,`description`,`creationDate`,`completionDate`,`deadline`,`rewardId`,`statusTypeId`,`importanceTypeId`,`userIdCustomer`,`userIdGopher`) VALUES 
("Pick up Groceries","Buy groceries for me according to my grocery list, and drop them off at my house","2016-04-01 09:46:38","2016-04-01 12:46:38","2016-04-02 09:46:38",1,2,3,1,5),
("Pick up dry cleaning","Pick up my dry cleaning from the cleaners, and drop it off at my office","2016-04-03 08:00:38","2016-04-03 11:00:38","2016-04-04 11:00:38",2,2,3,2,1),
("Help me Move","If you have a pick up truck, I need someone to help me move a large dresser to my new place.","2016-04-03 09:46:38","2016-04-09 12:46:38","2016-04-08 12:30:38",3,2,3,3,4),
("Pharmacy Run","Please get the following items for me, and drop them off at my house.","2016-04-04 09:46:38","2016-04-04 10:46:38","2016-04-04 12:00:38",5,2,4,4,3),
("Cut My Lawn","I broke me leg, and need someone to cut my lawn once a week for one month","2015-04-05 09:46:38","2015-05-01 12:46:38","2015-05-01 17:00:38",4,2,3,5,2);

INSERT INTO `address_types` (name) VALUES ("Home"),("Work"),("Pickup Location"),("Dropoff Location"),("Custom Type");

INSERT INTO `notification_types` (name) VALUES ("System Message"),("Private Message"),("Errand Completed"),("Errand Accepted");

INSERT INTO `notifications` (`id`,`title`,`message`,`userId`,`notificationTypeId`) VALUES 
(1,"Errand Accepted","Welcome to Gopher! View our FAQ section for how to get started.",1,1),
(2,"Errand Accepted","Welcome to Gopher! View our FAQ section for how to get started.",2,1),
(3,"Errand Accepted","Welcome to Gopher! View our FAQ section for how to get started.",3,1),
(4,"Errand Accepted","Welcome to Gopher! View our FAQ section for how to get started.",4,1),
(5,"Errand Accepted","Welcome to Gopher! View our FAQ section for how to get started.",5,1),
(6,"Errand Accepted","Your errand has been accepted by a Gopher!",1,3),
(7,"Errand Accepted","Your errand has been accepted by a Gopher!",2,3),
(8,"Errand Accepted","Your errand has been accepted by a Gopher!",3,3),
(9,"Errand Accepted","Your errand has been accepted by a Gopher!",4,3),
(10,"Errand Accepted","Your errand has been accepted by a Gopher!",5,3),
(11,"Errand Accepted","Your gopher has sent you a private message!",2,2),
(12,"Errand Accepted","Your gopher has sent you a private message!",1,2),
(13,"Errand Accepted","Your gopher has sent you a private message!",3,2),
(14,"Errand Accepted","Your customer has sent you a private message!",4,2),
(15,"Errand Accepted","Your customer has sent you a private message!",5,2),
(16,"Errand Accepted","Your errand has been completed!",1,3),
(17,"Errand Accepted","Your errand has been completed!",2,3),
(18,"Errand Accepted","Your errand has been completed!",3,3),
(19,"Errand Accepted","Your errand has been completed!",4,3),
(20,"Errand Accepted","Your errand has been completed!",5,3);

INSERT INTO `addresses` (`id`,`addressLine1`,`addressLine2`,`city`,`province`,`country`,`zip`,`userId`,`addressTypeId`) VALUES 
(1,"P.O. Box 528, 6930 Est Rd.","352-8128 Iaculis Rd.","Badajoz","Extremadura","Russian Federation","L2L 1G9",1,1),
(2,"P.O. Box 161, 8672 Gravida Street","355 Tortor St.","San JosÃ© de Maipo","Metropolitana de Santiago","Syria","74613-989",2,3),
(3,"350-6164 Neque Rd.","817-7294 In Rd.","Buckingham","Buckinghamshire","Isle of Man","20704",2,2),
(4,"P.O. Box 501, 4219 Neque. St.","379-5994 Lorem, Avenue","SuwaÅ‚ki","PD","CÃ´te D'Ivoire (Ivory Coast)","75-584",3,1),
(5,"332 Proin Street","Ap #620-3755 Ornare Avenue","Awka","Anambra","Tajikistan","N0K 1G1",3,1),
(6,"P.O. Box 112, 5239 Nunc, Rd.","926-9905 Suspendisse Av.","Alloa","CL","Afghanistan","33670",3,1),
(7,"1585 Tellus. St.","Ap #751-4085 At Street","Dublin","Leinster","Bahrain","2017",5,1);

INSERT INTO `categories` (`name`) VALUES 
("Laundry"),("Grocery"),("Manual Labour"),("Personal Assistance"),("Shopping"),("Delivery"),("Pick Up"),("Quick"),("Heavy Lifting"),("Vehicle Required");

INSERT INTO `errand_categories` (`errandId`,`categoryId`) VALUES 
(1,2),(2,1),(3,9),(4,8),(5,3);

INSERT INTO `ratings` (`id`,`ratingValue`,`comments`,`creationDate`,`userIdRated`,`userIdRater`,`errandId`) VALUES 
(1,3,"Not bad, would probably use again. My ice cream melted on their way to drop off my groceries, so gave them 3 stars.","2016-04-01 12:46:38",5,1,1),
(2,4,"Really nice to have as a customer","2016-04-01 18:47:36",1,5,1),
(3,5,"Great service! They were very fast.","2016-04-01 12:46:38",2,1,2),
(4,5,"Nice easy errand, gave good instructions, no hassel trying to get a hold of them.","2016-04-01 12:46:38",1,2,2),
(6,3,"Was on time, but a little rough with the merchandise. Mostly OK!","2016-04-09 12:46:38",4,3,3),
(7,5,"Easy, quick errand, nice guy.","2016-04-09 12:46:38",3,4,3),
(8,4,"Delivered on time and correct item.","2016-04-04 10:46:38",3,4,4),
(9,2,"Gave bad instructions!! Almost picked up the wrong thing.","2016-04-04 10:46:38",4,3,4),
(10,3,"they were supposed to cut my lawn, but didn't do the best job. Would have liked more attention to detail.","2015-05-01 12:46:38",2,5,5),
(11,5,"Really liked completing this errand!","2015-05-01 12:46:38",5,2,5);

INSERT INTO `tasks` (`name`,`description`,`startDate`,`completionDate`,`errandId`,`addressesId`) VALUES 
("Get grocery list","Send me your email so I can give you the list","2016-04-01 12:46:38","2016-04-01 12:46:38",1,NULL),
("Get items","Go to grocery store (of your choice) to pick up items on my list","2016-04-01 12:46:38","2016-04-01 12:46:38",1,NULL),
("Drop off","Drop off the groceries at my house","2016-04-01 12:46:38","2016-04-01 12:46:38",1,1),
("Pick up","Head to dry cleaners to pick up my laundry","2016-04-03 11:00:38","2016-04-03 11:00:38",2,2),
("Drop off","Drop it off at my office","2016-04-03 11:00:38","2016-04-03 11:00:38",2,3),
("Meet at my house","Meet me at my house so we can load up the furniture into your truck","2016-04-09 12:46:38","2016-04-09 12:46:38",3,4),
("Drop off furniture","We'll then head to my new place to drop it off. Will need help with unloading it.","2016-04-09 12:46:38","2016-04-09 12:46:38",3,5),
("Pick Up","Please pick up some Advil Cold and Sinus X-Strength from any pharmacy","2016-04-04 10:46:38","2016-04-04 10:46:38",4, NULL),
("Drop Up","Drop it off at my house","2016-04-04 10:46:38","2016-04-04 10:46:38",4, 6),
("First Cut","Come to my house to cut my lawn between 9am-5pm on April 10","2015-04-10 12:46:38","2015-04-10 12:46:38",5,7),
("Second Cut","Come to my house to cut my lawn between 9am-5pm on April 17","2015-04-17 12:46:38","2015-04-17 12:46:38",5,7),
("Third Cut","Come to my house to cut my lawn between 9am-5pm on April 24","2015-04-24 12:46:38","2015-04-24 12:46:38",5,7),
("Fourth Cut","Come to my house to cut my lawn between 9am-5pm on May 1","2015-05-01 12:46:38","2015-05-01 12:46:38",5,7);