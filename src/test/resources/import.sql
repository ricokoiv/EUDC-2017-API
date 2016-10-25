-- User data
INSERT INTO User (id, email, password, created, role) VALUES (1, 'admin@admin.kz', 'kaarliema', '1999-02-02 06:00:01', 'USER');
INSERT INTO User (id, email, password, created, role) VALUES (2, 'user@user.kz', 'siimuema', '1999-02-02 06:00:01', 'USER');
INSERT INTO User (id, email, password, created, role) VALUES (3, 'mart@mart.kz', '$2a$10$XEftKIY/9c/aiKRZNjwdouidY09XNVYgU86hgHnXwgIguCUqHOyjO', '1999-02-02 06:00:01', 'ADMIN');

INSERT INTO AuthenticatedUser (id, user_id, token) VALUES (1, 1, 'superUniqueToken');

-- Card data
INSERT INTO Card (id, title, description, created) VALUES (1, 'Lorem Ipsum', 'Sed omnium volumus voluptua te', '1999-02-02 06:00:01');
INSERT INTO Card (id, title, description, created) VALUES (2, 'Ipsum Lorem', 'At vis quis dolor inermis', '1999-02-02 06:00:01');
INSERT INTO Card (id, title, description, created) VALUES (3, 'Delirium Tremens', 'His no sensibus moderatius', '1999-02-02 06:00:01');

-- TimerCard data
INSERT INTO TimerCard (title, description, created, enddate) VALUES ('Round start notice', 'Your round will start in: ', '1999-02-02 06:00:01', '2016-05-12 19:45:00');

-- Location data
INSERT INTO Location (name, lat, lng, created) VALUES ('Tallinn Harbour', '59.443634', '24.767353', '1999-02-02 06:00:01');
INSERT INTO Location (name, lat, lng, created) VALUES ('Tallinn University of Technology', '59.395916', '24.671871', '1999-02-02 06:00:01');

INSERT INTO Card_User(card, user) VALUES (1,1);
INSERT INTO Card_User(card, user) VALUES (2,1);
INSERT INTO Card_User(card, user) VALUES (3,1);
INSERT INTO Card_User(card, user) VALUES (1,2);
INSERT INTO Card_User(card, user) VALUES (1,3);
INSERT INTO Card_User(card, user) VALUES (2,2);
INSERT INTO Card_User(card, user) VALUES (3,2);
INSERT INTO Card_User(card, user) VALUES (3,3);

-- Events

INSERT INTO Event (id, title, description) VALUES (1, 'Opening ceremony of EUDC', 'Cheers!');
INSERT INTO Event (id, title, description) VALUES (2, 'Break night social', 'Open vodka bar?');
INSERT INTO Event (id, title, description) VALUES (3, 'Open finals', 'Love wil win in the end.');