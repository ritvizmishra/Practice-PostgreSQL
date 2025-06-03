--  Creating product table & using FK
CREATE TABLE product (
	type_id INT REFERENCES product_type(id),
	name VARCHAR(30) NOT NULL,
	supplier VARCHAR(30) NOT NULL,
	description VARCHAR(40) NOT NULL,
	id SERIAL PRIMARY KEY
);

-- Modifying description's datatype:
ALTER TABLE product
ALTER COLUMN description TYPE TEXT;

-- Clearing the table and adding data again:
TRUNCATE TABLE product CASCADE;

-- Resetting the PK back to 1
SELECT pg_get_serial_sequence('product', 'id');
ALTER SEQUENCE product_id_seq RESTART WITH 1;

-- Making entries to the product table:
INSERT INTO product (type_id, name, supplier, description)
VALUES
	(1, 'Grandview', 'Allen Edmonds', 'Classic broguing adds texture to a charming longwing derby crafted in America from lustrous leather'),
	(1, 'Clarkston', 'Allen Edmonds', 'Sharp broguing touches up a charming, American-made derby fashioned from finely textured leather'),
	(1, 'Derby', 'John Varvatos', 'Leather upper, manmade sole'),
	(1, 'Ramsey', 'Johnston & Murphy', 'Leather upper, manmade sole'),
	(1, 'Hollis', 'Johnston & Murphy', 'Leather upper, manmade sole'),
	(2, 'Venetian Loafer', 'Mezlan', 'Suede upper, leather sole'),
	(2, 'Malek', 'Johnston & Murphy', 'Contrast insets at the toe and sides bring updated attitude to a retro-inspired sneaker set on a sporty foam sole and triangle-lugged tread.'),
	(3, 'Air Max 270 React', 'Nike', 'The reggae-inspired Nike Air 270 React fuses forest green with shades of tan to reveal your righteous spirit'),
	(3, 'Joyride', 'Nike', 'Tiny foam beads underfoot conform to your foot for cushioning that stands up to your mileage'),
	(2, 'Air Force 1', 'Nike', 'A modern take on the icon that blends classic style and fresh, crisp details'),
	(3, 'Ghost 12', 'Brooks', 'Just know that it still strikes a just-right balance of DNA LOFT softness and BioMoGo DNA responsiveness'),
	(3, 'Revel 3', 'Brooks', 'Style to spare, now even softer.'),
	(3, 'Glycerin 17', 'Brooks', 'A plush fit and super soft transitions make every stride luxurious'),
	(3, 'Elite Brogues', 'ShoeMart', 'Moment head determine leader cell.'),
	(3, 'Stride Walkers', 'UrbanSole', 'Well election floor least Democrat side. Development yes can live war.'),
	(4, 'Peak Trainers', 'ShoeMart', 'While color war teacher. Word about once concern should physical position.'),
	(2, 'Urban Loafers', 'UrbanSole', 'Like fill produce support air concern former. Amount east thing happen between.'),
	(4, 'Metro Sneakers', 'StepUp Inc.', 'Hear wall professor apply. Arm upon run take soon you. Consider by never wait.'),
	(1, 'Trek Boots', 'StepUp Inc.', 'Represent public edge land suffer his media especially. News when myself move.'),
	(5, 'Classic Oxfords', 'ComfyKicks', 'Population myself place dinner go structure.'),
	(4, 'Comfy Slides', 'UrbanSole', 'Pm five way benefit order population.'),
	(1, 'Rugged Runners', 'FootWorld', 'Bag rate why result. Officer upon sea those memory yourself.'),
	(1, 'Flex Sandals', 'FootWorld', 'Pass threat employee room decade. Best meeting always before song final.'),
	(6, 'Economy Kicks', 'FootWorld', 'Account choice mission which total. Power Congress second especially firm.'),
	(4, 'Determine Looms', 'StepUp Inc.', 'Plant last quickly project control.'),
	(2, 'Bed Gliders', 'StepUp Inc.', 'Step firm fall when. Sure piece country trial his cost term moment.'),
	(1, 'News Dashers', 'StepUp Inc.', 'Born paper present hundred. Size travel pull coach class writer rich.'),
	(6, 'Management Walkers', 'FootWorld', 'Middle first none mind. Exist market free pull worry quality operation.'),
	(2, 'Protect Walkers', 'UrbanSole', 'Push past my music. Support operation population fire beautiful his.'),
	(5, 'Sport Kicks', 'UrbanSole', 'South free attention. Remember church push could describe.'),
	(4, 'Bill Dashers', 'ComfyKicks', 'Compare should type song war. Put concern another left think.'),
	(1, 'Fire Dashers', 'FootWorld', 'Reveal soon take assume piece.'),
	(5, 'Produce Gliders', 'FootWorld', 'Age meet record yes side across law reality. Environmental fear look same.');

-- Viewing the product table:
SELECT * FROM product;
	