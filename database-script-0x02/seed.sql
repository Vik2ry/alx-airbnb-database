-- Extension to support uuid_generate_v4() function
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Insert locations
INSERT INTO "locations" (location_id, country, state, city, postal_code, lat, lng) VALUES
	(uuid_generate_v4(), 'Ghana', 'Greater Accra', 'Accra', '00233', 5.603717, -0.186964),
	(uuid_generate_v4(), 'South Africa', 'Gauteng', 'Johannesburg', '2000', -26.204103, 28.047305);

-- Insert users with different roles
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
    (uuid_generate_v4(), 'Daniel', 'Mensah', 'daniel.mensah@example.com', 'hashed_password_a', '+233201234567', 'host'),
    (uuid_generate_v4(), 'Linda', 'Nkosi', 'linda.nkosi@example.com', 'hashed_password_b', '+27631234567', 'guest'),
    (uuid_generate_v4(), 'George', 'Aidoo', 'george.aidoo@example.com', 'hashed_password_c', '+233509876543', 'host'),
    (uuid_generate_v4(), 'Amara', 'Chukwu', 'amara.chukwu@example.com', 'hashed_password_d', '+2347012345678', 'guest'),
    (uuid_generate_v4(), 'Thabo', 'Mokoena', 'thabo.mokoena@example.com', 'hashed_password_e', '+27839876543', 'admin');

-- Insert properties
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight) VALUES
    (uuid_generate_v4(), 
     (SELECT user_id FROM users WHERE first_name = 'Daniel'), 
     'Urban Garden Loft', 
     'Charming loft with greenery and rooftop access in Accra', 
     (SELECT location_id FROM locations WHERE city = 'Accra'), 
     6000.00),
    (uuid_generate_v4(), 
     (SELECT user_id FROM users WHERE first_name = 'George'), 
     'Johannesburg Modern Flat', 
     'Well-furnished apartment close to major attractions', 
     (SELECT location_id FROM locations WHERE city = 'Johannesburg'), 
     8500.00),
    (uuid_generate_v4(), 
     (SELECT user_id FROM users WHERE first_name = 'Daniel'), 
     'Seaside Escape Condo', 
     'Peaceful unit with sea breeze and walking distance to markets', 
     (SELECT location_id FROM locations WHERE city = 'Accra'), 
     38000.00);

-- Insert bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
    (uuid_generate_v4(), 
     (SELECT property_id FROM properties WHERE name = 'Urban Garden Loft'), 
     (SELECT user_id FROM users WHERE first_name = 'Linda'), 
     '2024-08-10', '2024-08-15', 12000.00, 'confirmed'),
    (uuid_generate_v4(), 
     (SELECT property_id FROM properties WHERE name = 'Johannesburg Modern Flat'), 
     (SELECT user_id FROM users WHERE first_name = 'Amara'), 
     '2024-08-10', '2024-08-15', 8500.00, 'confirmed');

-- Insert payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method) VALUES
    (uuid_generate_v4(), 
     (SELECT booking_id FROM bookings WHERE total_price = 12000.00), 
     12000.00, 'mobile_money'),
    (uuid_generate_v4(), 
     (SELECT booking_id FROM bookings WHERE total_price = 8500.00), 
     8500.00, 'bank_transfer');

-- Insert reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment) VALUES
    (uuid_generate_v4(), 
     (SELECT property_id FROM properties WHERE name = 'Urban Garden Loft'), 
     (SELECT user_id FROM users WHERE first_name = 'Linda'), 
     5, 'Lovely space with lots of natural light and plants!'),
    (uuid_generate_v4(), 
     (SELECT property_id FROM properties WHERE name = 'Johannesburg Modern Flat'), 
     (SELECT user_id FROM users WHERE first_name = 'Amara'), 
     4, 'Clean and convenient location, would stay again.');

-- Insert messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body) VALUES
    (uuid_generate_v4(), 
     (SELECT user_id FROM users WHERE first_name = 'Linda'), 
     (SELECT user_id FROM users WHERE first_name = 'Daniel'), 
     'Hi, is early check-in possible for my stay?'),
    (uuid_generate_v4(), 
     (SELECT user_id FROM users WHERE first_name = 'Thabo'), 
     (SELECT user_id FROM users WHERE first_name = 'George'), 
     'Can you share more images of the apartment?');
