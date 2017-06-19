ALTER TABLE addresses 
ADD column `lat` FLOAT(10, 6) DEFAULT null after `zip`,
ADD column `long` FLOAT(10,6) DEFAULT null after `lat`;

SELECT * FROM addresses;