CREATE DATABASE IF NOT EXISTS gopher;

USE gopher;

CREATE TABLE IF NOT EXISTS countries (
	id INT unsigned NOT NULL AUTO_INCREMENT,
	country VARCHAR(50),
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS addresses (
	id INT unsigned NOT NULL AUTO_INCREMENT,
	countryId INT unsigned,
	city VARCHAR(50),
	streetAddress1 VARCHAR(50),
	streetAddress2 VARCHAR(50),
	postalCode VARCHAR(6),
	province VARCHAR(20),
	PRIMARY KEY (id),
	FOREIGN KEY (countryId)
		REFERENCES countries (id)
);

CREATE TABLE IF NOT EXISTS users (
    id INT unsigned NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
	nameFirst VARCHAR(50),
	nameLast VARCHAR(50),
	email VARCHAR(50),
	addressIdHome INT unsigned,
	addressIdWork INT unsigned,
	phoneHome VARCHAR(20),
	phoneMobile VARCHAR(20),
	phoneWork VARCHAR(20),
	password VARCHAR(50),
	dateJoined TIMESTAMP,
    isAdmin BOOLEAN default false,
    PRIMARY KEY (id),
	FOREIGN KEY (addressIdHome)
		REFERENCES addresses (id),
	FOREIGN KEY (addressIdWork)
		REFERENCES addresses (id)
);

CREATE TABLE IF NOT EXISTS errands (
	id INT unsigned NOT NULL AUTO_INCREMENT,
	userIdCustomer INT unsigned,
	userIdGopher INT unsigned,
	dateCreated TIMESTAMP,
	dateCompleted TIMESTAMP,
    rewardId INT unsigned,
    deadline TIMESTAMP,
    status VARCHAR(200),
	importance VARCHAR(50),
	category VARCHAR(50),
	PRIMARY KEY (id),
	FOREIGN KEY (userIdCustomer)
		REFERENCES users (id),
	FOREIGN KEY (userIdGopher)
		REFERENCES users (id),
	FOREIGN KEY (rewardId)
		REFERENCES ratings (id)
);

CREATE TABLE IF NOT EXISTS rewards(
	id INT unsigned NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    rewardValue numeric(15,2) default NULL,
    addressId INT unsigned,
    description VARCHAR(2000),
    PRIMARY KEY (id),
    FOREIGN KEY (addressId)
		REFERENCES addresses (id)
);

CREATE TABLE IF NOT EXISTS notifications (
	id INT unsigned NOT NULL AUTO_INCREMENT,
    title VARCHAR(50),
    userId INT unsigned,
    type INT,
    PRIMARY KEY (id),
    FOREIGN KEY (userId) 
    	REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS tasks (
	id INT unsigned NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
	errandId INT unsigned,
    dateCreated TIMESTAMP,
	dateInitiated TIMESTAMP,
	dateCompleted TIMESTAMP,
	addressId INT unsigned,
	isActive boolean,
    description VARCHAR(2000),
	PRIMARY KEY (id),
	FOREIGN KEY (addressId)
		REFERENCES addresses (id),
	FOREIGN KEY (errandId)
		REFERENCES errands (id)
);

CREATE TABLE IF NOT EXISTS ratings (
	id INT unsigned NOT NULL AUTO_INCREMENT,
	userRatedId INT unsigned,
	userRaterId INT unsigned,
    errandId INT unsigned,
	rating INT,
	comments VARCHAR(200),
	dateCreated TIMESTAMP,
	PRIMARY KEY (id),
	FOREIGN KEY (userRatedId)
		REFERENCES users (id),
	FOREIGN KEY (userRaterId)
		REFERENCES users (id),
	FOREIGN KEY (errandId) 
		REFERENCES errands(id)
);