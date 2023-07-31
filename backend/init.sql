CREATE TABLE users
(
  user_email VARCHAR NOT NULL,
  name VARCHAR NOT NULL,
  phone_number VARCHAR NOT NULL,
  PRIMARY KEY (user_email)
);

CREATE TABLE locations
(
  place VARCHAR NOT NULL,
  id BIGSERIAL NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE cab_booking
(
  id BIGSERIAL NOT NULL,
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,
  capacity INT NOT NULL,
  from_loc INT,
  to_loc INT,
  owner_email VARCHAR NOT NULL,
  comments VARCHAR NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (from_loc) REFERENCES locations(id),
  FOREIGN KEY (to_loc) REFERENCES locations(id),
  FOREIGN KEY (owner_email) REFERENCES users(user_email)
);

CREATE TABLE traveller
(
  user_email VARCHAR NOT NULL,
  cab_id INT NOT NULL,
  comments VARCHAR NOT NULL,
  PRIMARY KEY (user_email, cab_id),
  FOREIGN KEY (user_email) REFERENCES users(user_email),
  FOREIGN KEY (cab_id) REFERENCES cab_booking(id) ON DELETE CASCADE
);

CREATE TYPE request_status AS ENUM ('pending', 'accepted', 'rejected');

CREATE TABLE request
(
  status request_status NOT NULL,
  booking_id INT NOT NULL,
  request_email VARCHAR NOT NULL, 
  comments VARCHAR,
  PRIMARY KEY (booking_id, request_email),
  FOREIGN KEY (booking_id) REFERENCES cab_booking(id) ON DELETE CASCADE,
  FOREIGN KEY (request_email) REFERENCES users(user_email)
);

-- status numbers and their corresponding meanings
  -- 2 - pending
  -- 1 - accepted
  -- 0 - rejected
