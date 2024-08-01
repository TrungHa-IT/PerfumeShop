USE [master];
GO

DECLARE @databaseName NVARCHAR(128) = 'TPS';

IF EXISTS (
    SELECT name 
    FROM sys.databases 
    WHERE name = @databaseName
)
BEGIN
    DECLARE @kill varchar(8000) = '';
    SELECT @kill = @kill + 'KILL ' + CONVERT(varchar(5), session_id) + ';'
    FROM sys.dm_exec_sessions
    WHERE database_id  = DB_ID(@databaseName);
    EXEC(@kill);
    EXEC('DROP DATABASE ' + @databaseName);
END;

EXEC('CREATE DATABASE ' + @databaseName);
GO

USE [TPS]

USE [TPS]
GO
/* ============[Roles] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Roles];

CREATE TABLE [dbo].[Roles] (
    roleID INT PRIMARY KEY IDENTITY(1,1),
    roleName NVARCHAR(50) NOT NULL UNIQUE
)
/*======= INSERT VALUE OF [Roles] TABLE =======*/
INSERT INTO [dbo].[Roles] (roleName) VALUES
('Admin'),
('Sale'),
('Marketing'),
('Customer');
GO

/* ============[Accounts] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Accounts];

CREATE TABLE [dbo].[Accounts](
[AccountID] [int] IDENTITY(1,1) PRIMARY KEY,
[FirstName] [nvarchar](50) NOT NULL,
[LastName] [nvarchar](50) NOT NULL,
[Password] [nvarchar](512) NOT NULL,
[Image] [nvarchar](50) NULL,
[Gender] int NOT NULL,
[BirthDay] date NOT NULL,
[Email] [nvarchar](50) NULL,
[Status] int NOT NULL,
[CreateDate] date NOT NULL,
[RoleID] [int] NOT NULL,
FOREIGN KEY (roleID) REFERENCES [dbo].[Roles](roleID)
)
/*======= INSERT VALUE OF [Accounts] TABLE =======*/

INSERT INTO [dbo].[Accounts] (FirstName, LastName, Password, Image, Gender, BirthDay, Email, Status, CreateDate, RoleID) VALUES
('Nguyễn', 'Văn A', 'PasswordHash1', 'image1.png', 1, '1985-07-14', 'nguyenvana@example.com', 1, '2023-01-01', 1),
('Trần', 'Thị B', 'PasswordHash2', 'image2.png', 2, '1990-03-22', 'tranthib@example.com', 1, '2023-01-02', 2),
('Lê', 'Quang C', 'PasswordHash3', NULL, 1, '1983-11-05', 'lequangc@example.com', 1, '2023-01-03', 1),
('Phạm', 'Thị D', 'PasswordHash4', 'image4.png', 2, '1995-09-18', 'phamthid@example.com', 1, '2023-01-04', 2),
('Hoàng', 'Văn E', 'PasswordHash5', NULL, 1, '1988-04-12', 'hoangvane@example.com', 1, '2023-01-05', 1),
('Võ', 'Thị F', 'PasswordHash6', 'image6.png', 2, '1992-07-23', 'vothif@example.com', 1, '2023-01-06', 2),
('Đỗ', 'Minh G', 'PasswordHash7', NULL, 1, '1987-10-15', 'dohminhg@example.com', 1, '2023-01-07', 1),
('Vũ', 'Thị H', 'PasswordHash8', 'image8.png', 2, '1993-12-30', 'vuthih@example.com', 1, '2023-01-08', 2),
('Bùi', 'Văn I', 'PasswordHash9', NULL, 1, '1989-05-27', 'buivani@example.com', 1, '2023-01-09', 1),
('Ngô', 'Thị J', 'PasswordHash10', 'image10.png', 2, '1991-08-16', 'ngothij@example.com', 1, '2023-01-10', 2);

GO

/* ============[Vouchers] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Vouchers];

CREATE TABLE [dbo].[Vouchers] (
    VoucherID INT PRIMARY KEY IDENTITY(1,1),
    Code NVARCHAR(50) NOT NULL UNIQUE,
    Discount DECIMAL(5, 2) NOT NULL,
    ExpiryDate DATE NOT NULL,
	Quantity INT,
	CreateAt DATE,
	Status Int
)
/*======= INSERT VALUE OF [Vouchers] TABLE =======*/
INSERT INTO [dbo].[Vouchers] (Code, Discount, ExpiryDate, Quantity, CreateAt,Status) VALUES
('NEWYEAR2024', 10.00, '2024-12-31', 100, '2024-01-01',1),
('SUMMERSALE', 15.00, '2024-06-30', 50, '2024-06-01',1);
GO

/* ============[Categories] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Categories];

CREATE TABLE [dbo].[Categories](
[CategoryID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
[CategoryName] [nvarchar](50) NOT NULL,
[Description] [ntext] NULL,
[CreateAt] DATE,
[Status] [int]
)
/*======= INSERT VALUE OF [Categories] TABLE =======*/
INSERT INTO [dbo].[Categories] ([CategoryName],[Description],[CreateAt],[Status])
VALUES
('Men','What do gentlemen look for perfume for? Probably to smell good, be masculine and enhance their style, right ? Namperfume understands our gentlemen , brings to men decent, neat, attractive, sometimes overwhelmingly powerful scents, and certainly cannot forget the typical liberal dustiness of men.','2024-01-01',1),
('Women','Perfume from the early days was created to serve women, so it seems that in the world of scent, the choices for women are richer and more colorful. That"s why, namperfume always wants to bring beautiful ladies great options, from seductive, luxurious, powerful to gentle, innocent, and indispensable a bit of flirty sexiness. recline...','2024-01-01',1),
('Unisex','Unisex perfume is a perfume line suitable for all genders, whether men or women can use this product. Same perfume, but when men use it, they will become elegant. A girl who possesses adorable charms will become even more attractive.','2024-01-01',1),
('Giftset','Giftset - also known as gift set, is a collection of many different types of products. They are all highly applicable to serve work and daily life. All The products in the Giftset are all related to each other and have high aesthetics to bring satisfaction to the recipient.','2024-01-01',1);

GO


/* ============[Brands] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Brands];
CREATE TABLE [dbo].[Brands] (
    [BrandID] INT PRIMARY KEY IDENTITY(1,1),
    [BrandName] NVARCHAR(100) NOT NULL UNIQUE,
    [Description] NVARCHAR(MAX),
	[CreateAt] DATE,
	[status] [int]
)
/*======= INSERT VALUE OF [Brands] TABLE =======*/
INSERT INTO [dbo].[Brands]([BrandName],[Description],[status],[CreateAt])
VALUES
('GUCCI','Gucci perfume is one of the most revered brands in the world. Founded in the 1920s in Florence, Italy, Gucci has always understood that fashion and perfume are two inseparable things. The company offers clothes with modern, modern styles for both men and women. Gucci famous interlocking letter logo has become a fashion icon that is always seen in all of the company products, from bag collections, sportswear, seasonal high and thin heels to perfume bottles. Gucci perfumes have a variety of scents, from sensual and indulgent to sweet and fresh. Along with the company clothing and accessories lines, which have long become classic scents.',1,'2024-01-01'),
('CHANEL','Chanel is a famous perfume brand known for its elegance, sophistication and class. Chanel perfume products often have unique scents, combining natural ingredients. natural and synthetic to create unique and long-lasting scents.',1,'2024-01-01'),
('XERJOFF','Xerjoff is a famous high-end perfume brand with the perfect combination of craftsmanship and rare ingredients. Xerjoff perfume lines bring unique fragrance experiences. unique, complex and full of sophistication.',1,'2024-01-01'),
('LOUIS VUITTON', 'Louis Vuitton, famous for its luxury and class in fashion and accessories, also offers high-end perfume lines with delicate and unique scents. Louis Vuitton perfumes are Created by leading perfumers, using rare and high quality ingredients.',1,'2024-01-01'),
('DIOR','Dior is a famous brand in the field of perfume, with many iconic product lines. Dior perfume stands out with its sophisticated combination of high-quality ingredients, bringing the fragrance is diverse and rich.',1,'2024-01-01'),
('TOMMY HILFIGER','Tommy Hilfiger is a famous brand, not only in the fashion field but also in the perfume industry. Tommy Hilfiger perfumes often have a youthful, dynamic and fresh style.' ,1,'2024-01-01'),
('ISSEY MIYAKE',N'Issey Miyake is a famous brand with modern, minimalist and sophisticated perfume lines. Issey Miyake perfumes often stand out with their fresh, elegant and creative, inspired by nature and natural elements.',1,'2024-01-01'),
('CREED', 'Creed is a high-end French perfume brand, famous for its handmade, sophisticated and luxurious perfume lines. Each Creed product is usually made from quality natural ingredients. high quality, providing a unique and long-lasting fragrance.',1,'2024-01-01'),
('YVES SAINT LAURENT','Yves Saint Laurent (YSL) is a famous perfume brand, standing out with products that have a seductive, bold and modern style. YSL perfumes are often highly appreciated for the creativity in blending aromas, bringing unique and impressive scents.',1,'2024-01-01'),
('ARMAF','Armaf is a famous perfume brand with high quality products at affordable prices. Armaf perfumes often have diverse styles, from fresh to passionate, suitable for everyone. Suitable for many different tastes and occasions.',1,'2024-01-01'),
('ROJA PARFUMS', 'Roja Parfums is a high-end and luxurious perfume brand of perfume creator Roja Dove. Roja Parfums products are often known for their sophistication in the way they combine scents. materials, ensuring the highest quality and uniqueness. Each bottle of Roja Parfums perfume is often handmade and limited, creating works of art in the world of perfume.',1,'2024-01-01'),
('LE LABO','Le Labo is a high-end and unique perfume brand, famous for creating handmade and personalized products. Each bottle of Le Labo perfume is made in-house products, ensuring sophistication and quality. This brand focuses on using natural and high-quality ingredients, along with unique flavor blends.',1,'2024-01-01'),
('BVLGARI','Bvlgari is a renowned luxury brand known for its exquisite fragrances and perfumes. Founded in 1884 by jewelry manufacturer Sotirio Bulgari, the brand offers both bold and modern scents as well as timeless classics. Bvlgari’s master perfumers create high-quality fragrances that reflect elegance and refinement. Their Eau Parfumee collection includes captivating scents for both men and women, making Bvlgari a go-to choice for those seeking sophistication and allure ',1,'2024-01-01'),
('VERSACE','Versace is an Italian luxury fashion company founded by Gianni Versace in 1978. Known for its audacious and unapologetic style, Versace fuses street fashion with high-end designs, resulting in bombastic and avant-garde creations. The iconic Versace logo draws inspiration from Greek mythology, featuring the figure of Medusa. Versace produces Italian-made ready-to-wear clothing, accessories, and haute couture under its Atelier Versace brand, and licenses its name to Luxottica for eyewear. Their distinctive style combines materials like metal, mesh, and leather, often painted in bright colors, celebrating individuality and sensuality . ',1,'2024-01-01'),
('LANCOME','Lancôme is a perfume and cosmetics brand with its roots in the heart of European fashion, Paris. Founded by Armand Petitjean during a major economic crisis in the mid-1930s, Lancôme has epitomized beauty with a French accent for over 80 years. What began as a brand helmed by knowledgeable ambassadresses quickly grew to include a thousand boutiques across France. Lancôme’s legacy of expertise continues today with their team of industry-leading National Makeup Artists, led by Lisa Eldridge. ',1,'2024-01-01');
GO


/* ============[Products] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Products];
CREATE TABLE [dbo].[Products] (
     [ProductID] [INT] PRIMARY KEY IDENTITY(1,1),
    [ProductName] [NVARCHAR](255) NOT NULL,
    [ProductCreateDate] DATE NOT NULL,
    [ProductStatus] int NOT NULL,
    [ProductImageUrl] [nvarchar](255) NOT NULL,
	[BrandID] [int] NULL,
	[CategoryID][int],
	FOREIGN KEY (CategoryID) REFERENCES [dbo].[Categories](CategoryID),
	FOREIGN KEY (BrandID) REFERENCES [dbo].[Brands](BrandID),
)
/*======= INSERT VALUE OF [Products] TABLE =======*/
INSERT INTO [dbo].[Products] (
    [ProductName],
    [ProductCreateDate],
    [ProductStatus],
    [BrandID],
    [ProductImageUrl],
    [CategoryID])
VALUES
-- 20 perfumes for Men
('XERJOFF CASAMORATI MEFISTO EDP','2024-01-01',1,3,'images/Products/Men/1_0.jpg',1),
('LOUIS VUITTON MÉTÉORE EDP','2024-01-01',1,4,'images/Products/Men/2_0.jpg',1),
('TOMMY ENDLESS BLUE','2024-01-01',1,6,'images/Products/Men/3_0.jpg',1),
('ISSEY MIYAKE LEAU DISSEY INTENSE','2024-01-01',1,7,'images/Products/Men/4_0.jpg',1),
('CREED AVENTUS EDP','2024-01-01',1,8,'images/Products/Men/5_0.jpg',1),
('DIOR SAUVAGE EDP','2024-01-01',1,5,'images/Products/Men/6_0.jpg',1),
('BLEU DE CHANEL EDP','2024-01-01',1,2,'images/Products/Men/7_0.jpg',1),
('YVES SAINT LAURENT LA NUIT DE L''HOMME EDT','2024-01-01',1,9,'images/Products/Men/8_0.jpg',1),
('VERSACE DYLAN BLUE POUR HOMME','2024-01-01',1,14,'images/Products/Men/91_0.jpg',1),
('ARMAF VENTANA POUR HOMME EDP','2024-01-01',1,10,'images/Products/Men/10_0.jpg',1),
('BVLGARI WOOD NEROLI EDP','2024-01-01',1,13,'images/Products/Men/11_0.jpg',1),
('VERSACE EAU FRAICHE EDT','2024-01-01',1,14,'images/Products/Men/12_0.jpg',1),
('GUCCI GUILTY ABSOLUTE POUR HOMME','2024-01-01',1,1,'images/Products/Men/13_0.jpg',1),
('YVES SAINT LAURENT Y EDP','2024-01-01',1,9,'images/Products/Men/14_0.jpg',1),
('ROJA ENIGMA POUR HOMME','2024-01-01',1,11,'images/Products/Men/15_0.jpg',1),
('BVLGARI SPLENDIDA JASMIN NOIR EDP','2024-01-01',1,13,'images/Products/Men/16_0.jpg',1),
('CHANEL ANTAEUS POUR HOMME EDT','2024-01-01',1,2,'images/Products/Men/17_0.jpg',1),
('DIOR HOMME SPORT EDT','2024-01-01',1,5,'images/Products/Men/18_0.jpg',1),
('VERSACE EROS FLAME','2024-01-01',1,14,'images/Products/Men/19_0.jpg',1),
('ISSEY MIYAKE NUIT DISSEY EDT','2024-01-01',1,7,'images/Products/Men/20_0.jpg',1),

-- 20 perfumes for Women
('CHANEL CHANCE EDP','2024-01-01',1,2,'images/Products/Women/1_0.jpg',2),
('DIOR JOY EDP','2024-01-01',1,5,'images/Products/Women/22_0.jpg',2),
('YSL LIBRE EDP','2024-01-01',1,9,'images/Products/Women/3_0.jpg',2),
('LOUIS VUITTON SPELL ON YOU EDP','2024-01-01',1,4,'images/Products/Women/4_0.jpg',2),
('CHANEL CHANCE EAU FRAICHE EDP','2024-01-01',1,2,'images/Products/Women/5_0.jpg',2),
('LANCOME LA VIE EST BELLE EN ROSE','2024-01-01',1,15,'images/Products/Women/6_0.jpg',2),
('LANCOME TRESOR LA NUIT EDP','2024-01-01',1,15,'images/Products/Women/7_0.jpg',2),
('LANCOME LA VIE EST BELLE EDP','2024-01-01',1,15,'images/Products/Women/8_0.jpg',2),
('GUCCI BLOOM AMBROSIA DI FIORI EDP','2024-01-01',1,1,'images/Products/Women/9_0.jpg',2),
('BVLGARI ROSE GOLDEA','2024-01-01',1,13,'images/Products/Women/10_0.jpg',2),
('ARMAF CLUB DE NUIT','2024-01-01',1,10,'images/Products/Women/11_0.jpg',2),
('GUCCI FLORA GORGEOUS GARDENIA EDP','2024-01-01',1,1,'images/Products/Women/12_0.jpg',2),
('TOMMY GIRL EDT','2024-01-01',1,6,'images/Products/Women/13_0.jpg',2),
('ROJA ELIXIR POUR FEMME','2024-01-01',1,11,'images/Products/Women/14_0.jpg',2),
('CHANEL COCO MADEMOISELLE EDP','2024-01-01',1,2,'images/Products/Women/15_0.jpg',2),
('LOUIS VUITTON MATIERE NOIRE','2024-01-01',1,4,'images/Products/Women/16_0.jpg',2),
('LOUIS VUITTON CALIFORNIA DREAM','2024-01-01',1,4,'images/Products/Women/17_0.jpg',2),
('GUCCI BLOOM EDP','2024-01-01',1,1,'images/Products/Women/18_0.jpg',2),
('CHANEL COCO NOIR','2024-01-01',1,2,'images/Products/Women/19_0.jpg',2),
('VERSACE DYLAN BLUE POUR FEMME EDP','2024-01-01',1,14,'images/Products/Women/20_0.jpg',2),

-- 20 perfumes for Unisex
('XERJOFF NAXOS EDP','2024-01-01',1,3,'images/Products/Unisex/1_0.jpg',3),
('ARMAF STERLING CLUB DE NUIT MILESTONE EDP','2024-01-01',1,10,'images/Products/Unisex/2_0.jpg',3),
('GUCCI A SONG FOR THE ROSE EDP','2024-01-01',1,1,'images/Products/Unisex/3_0.jpg',3),
('LE LABO THE NOIR 29 EDP','2024-01-01',1,12,'images/Products/Unisex/4_0.jpg',3),
('LOUIS VUITTON OMBRE NOMADE EDP','2024-01-01',1,4,'images/Products/Unisex/5_0.jpg',3),
('CREED SILVER MOUNTAIN WATER','2024-01-01',1,8,'images/Products/Unisex/6_0.jpg',3),
('LE LABO BERGAMOTE 22 EDP','2024-01-01',1,12,'images/Products/Unisex/7_0.jpg',3),
('LE LABO SANTAL 33','2024-01-01',1,12,'images/Products/Unisex/8_0.jpg',3),
('ROJA DOVE AMBER AOUND PARFUM','2024-01-01',1,11,'images/Products/Unisex/9_0.jpg',3),
('LOUIS VUITTON CACTUS GARDEN EDP','2024-01-01',1,4,'images/Products/Unisex/10_0.jpg',3),
('LOUIS VUITOTN SUN SONG EDP','2024-01-01',1,4,'images/Products/Unisex/11_0.jpg',3),
('ROJA DOVE MANHATTAN EDP','2024-01-01',1,11,'images/Products/Unisex/12_0.jpg',3),
('ROJA DOVE BURLINGTON 1819 PARFUM','2024-01-01',1,11,'images/Products/Unisex/13_0.jpg',3),
('XERJOFF ALEXANDRIA II','2024-01-01',1,3,'images/Products/Unisex/14_0.jpg',3),
('BVLGARI SPLENDIDA MAGNOLIA SENSUEL EDP','2024-01-01',1,13,'images/Products/Unisex/15_0.jpg',3),
('ARMAF CLUB DE NUIT UNTOLD EDP','2024-01-01',1,10,'images/Products/Unisex/16_0.jpg',3),
('GUCCI BLOOM ACQUA DI FIORI EDT','2024-01-01',1,1,'images/Products/Unisex/17_0.jpg',3),
('CHANEL GABRIELLE ESSENCE EDP','2024-01-01',1,2,'images/Products/Unisex/18_0.jpg',3),
('VERSACE YELLOW DIAMOND INTENSE EDP','2024-01-01',1,14,'images/Products/Unisex/19_0.jpg',3),
('CHANEL ALLURE HOMME SPORT COLOGNE','2024-01-01',1,2,'images/Products/Unisex/20_0.jpg',3),

-- 5 Giftsets 
('SET YSL BLACK OPIUM EDP','2024-01-01',1,9,'images/Products/Giftset/1_0.jpg',4),
('SET BVLGARI OMNIA','2024-01-01',1,13,'images/Products/Giftset/2_0.jpg',4),
('SET OF 5 LANCOME PARIS PERFUMES','2024-01-01',1,15,'images/Products/Giftset/3_0.jpg',4),
('BVLGARI OMNIA AMETHYSTE','2024-01-01',1,13,'images/Products/Giftset/4_0.jpg',4),
('VERSACE BRIGHT CRYSTAL ABSOLU','2024-01-01',1,14,'images/Products/Giftset/5_0.jpg',4);
GO


/* ============[ProductFullDetail] TABLE============*/
DROP TABLE IF EXISTS [dbo].[ProductFullDetail];
CREATE TABLE [dbo].[ProductFullDetail] (
    [ProductFullDetailID] [int] PRIMARY KEY IDENTITY(1,1),
    [pdProductID] [int] NOT NULL,
    [ProductDescription] [NVARCHAR](max) NULL,
    [ProductCreateDate] DATE NULL,
    [ProductStatus] int NOT NULL,
    [ProductSize] [NVARCHAR](max) NULL,
    [ProductPrice] [decimal](18, 2) NOT NULL,
    [ProductAvaiable] [int] NOT NULL,
	[image] varchar(100),
	FOREIGN KEY ([pdProductID]) REFERENCES [dbo].[Products]([ProductID])
)
/*======= INSERT VALUE OF [ProductFullDetail] TABLE =======*/
INSERT INTO [dbo].[ProductFullDetail] (
    [pdProductID],
    [ProductDescription],
    [ProductCreateDate],
    [ProductStatus],
    [ProductSize],
    [ProductPrice],
    [ProductAvaiable],
    [image]
)
VALUES
--Details full for men
( 1, 'Inspired by the Italian coast, in 2009 the Xerjoff brand launched a perfume for men called Xerjoff Casamorati Mefisto EDP. This is one of the perfume bottles located in the famous and very popular Casamorati collection.', '2024-01-01', 1, '30ml', 50.00, 100, '1_1.jpg'),
( 1, 'Inspired by the Italian coast, in 2009 the Xerjoff brand launched a perfume for men called Xerjoff Casamorati Mefisto EDP. This is one of the perfume bottles located in the famous and very popular Casamorati collection.', '2024-01-01', 1, '100ml', 120.00, 100, '1_2.jpg'),
( 2, 'Louis Vuitton Météore EDP is part of Louis Vuitton "Les Parfum" collection just launched in 2020. As soon as it was released, this perfume bottle attracted attention. The idea of boys with a luxurious and sophisticated design. Inspired by snow and ice crystals, the perfume bottle is designed with a round cylinder shape and soft rounded edges.', '2024-01-01', 1, '30ml', 60.00, 100, '2_1.jpg'),
( 2, 'Louis Vuitton Météore EDP is part of Louis Vuitton "Les Parfum" collection just launched in 2020. As soon as it was released, this perfume bottle attracted attention. The idea of boys with a luxurious and sophisticated design. Inspired by snow and ice crystals, the perfume bottle is designed with a round cylinder shape and soft rounded edges.', '2024-01-01', 1, '100ml', 134.00, 100, '2_2.jpg'),
( 3, 'Tommy Endless Blue is a perfume line of Tommy Hilfiger for men, launched in 2017. This men''s perfume bottle features a harmonious scent between sweetness of Tonka Beans, the spiciness of black pepper and the peaceful scent of herbs with a spicy kick of cognac.', '2024-01-01', 1, '30ml', 30.00, 100, '3_1.jpg'),
( 3, 'Tommy Endless Blue is a perfume line of Tommy Hilfiger for men, launched in 2017. This men''s perfume bottle features a harmonious scent between sweetness of Tonka Beans, the spiciness of black pepper and the peaceful scent of herbs with a spicy kick of cognac.', '2024-01-01', 1, '100ml', 95.00, 100, '3_2.jpg'),
( 4, 'Issey Miyake L EAU D ISSEY Intense is a work of art as a men perfume by Issey Miyake, launched to create a fragrant experience. This fragrance is full of charm and depth. This is not simply a perfume, but also a story about emotions and the beauty of contrasts.', '2024-01-01', 1, '30ml', 46.00, 100, '4_1.jpg'),
( 4, 'Issey Miyake L EAU D ISSEY Intense is a work of art as a men perfume by Issey Miyake, launched to create a fragrant experience. This fragrance is full of charm and depth. This is not simply a perfume, but also a story about emotions and the beauty of contrasts.', '2024-01-01', 1, '100ml', 137.00, 100, '4_2.jpg'),
( 5, 'Creed Aventus - A name that is no longer strange to trendy scent followers. Appointed as the king of men perfume. For being at the forefront of creating a scent Citrus, easy to use but indescribably unique. Attractive with a luxurious and attractive scent, adding a bit of generosity and bravery. The perfume line is inspired by the dramatic life of King Napoleon symbolizes war, peace and romance.', '2024-01-01', 1, '30ml', 29.00, 100, '5_1.jpg'),
( 5, 'Creed Aventus - A name that is no longer strange to trendy scent followers. Appointed as the king of men perfume. For being at the forefront of creating a scent Citrus, easy to use but indescribably unique. Attractive with a luxurious and attractive scent, adding a bit of generosity and bravery. The perfume line is inspired by the dramatic life of King Napoleon symbolizes war, peace and romance.', '2024-01-01', 1, '100ml', 63.00, 100, '5_2.jpg'),
( 6, 'Dior Sauvage EDP men''s perfume of the Christian Dior brand was launched in 2018, known as the version that continues the resounding success of the 2015 product line that made men "suffer". The scent of Dior Sauvage EDP is masculine, strong, attractive from everyday scents and conquers the most demanding people.', '2024-01-01', 1, '30ml', 75.00, 100, '6_1.jpg'),
( 6, 'Dior Sauvage EDP men''s perfume of the Christian Dior brand was launched in 2018, known as the version that continues the resounding success of the 2015 product line that made men "suffer". The scent of Dior Sauvage EDP is masculine, strong, attractive from everyday scents and conquers the most demanding people.', '2024-01-01', 1, '100ml', 155.00, 100, '6_2.jpg'),
( 7, 'Bleu De Chanel EDP men''s perfume is extremely popular, the scent is perfect and an absolute hit in that it suits all men and can be used at any time.', '2024-01-01', 1, '30ml', 85.00, 100, '7_1.jpg'),
( 7, 'Bleu De Chanel EDP men''s perfume is extremely popular, the scent is perfect and an absolute hit in that it suits all men and can be used at any time.', '2024-01-01', 1, '100ml', 170.00, 100, '7_2.jpg'),
( 8, 'Yves Saint Laurent La Nuit de L''Homme EDT offers a seductive and enchanting fragrance. The blend of spice notes such as cardamom, cedarwood, and lavender creates a masculine, strong scent that retains sophistication and elegance.', '2024-01-01', 1, '30ml', 34.70, 100, '8_1.jpg'),
( 8, 'Yves Saint Laurent La Nuit de L''Homme EDT offers a seductive and enchanting fragrance. The blend of spice notes such as cardamom, cedarwood, and lavender creates a masculine, strong scent that retains sophistication and elegance.', '2024-01-01', 1, '100ml', 104.50, 100, '8_2.jpg'),
( 9, 'Versace Dylan Blue Pour Homme is the perfect choice for those who love freshness and dynamism. The top notes of grapefruit, bergamot and seawater provide a refreshing feel, while the middle notes of fig leaves and the end notes of wood and aromatic resin make for the perfect and lasting balance.', '2024-01-01', 1, '30ml', 45.00, 100, '9_1.jpg'),
( 9, 'Versace Dylan Blue Pour Homme is the perfect choice for those who love freshness and dynamism. The top notes of grapefruit, bergamot and seawater provide a refreshing feel, while the middle notes of fig leaves and the end notes of wood and aromatic resin make for the perfect and lasting balance.', '2024-01-01', 1, '100ml', 130.00, 100, '9_2.jpg'),
( 10, 'Armaf Ventana Pour Homme EDP is a passionate and attractive fragrance, ideal for special occasions. With early notes of bergamot, lemon and tangerine, combined with woody midst notes and end notes of vanilla and musk, this perfume gives confidence and charm to men.', '2024-01-01', 1, '30ml', 52.00, 100, '10_1.jpg'),
( 10, 'Armaf Ventana Pour Homme EDP is a passionate and attractive fragrance, ideal for special occasions. With early notes of bergamot, lemon and tangerine, combined with woody midst notes and end notes of vanilla and musk, this perfume gives confidence and charm to men.', '2024-01-01', 1, '100ml', 160.00, 100, '10_2.jpg'),
( 11, 'Wood Neroli is a floral scent, wood, musk for men, launched by perfume company Bvlgari in 2019. This is also the second scent in Bvlgari''s new collection, with the first edition entitled Wood Essence.', '2024-01-01', 1, '30ml', 36.00, 100, '11_1.jpg'),
( 11, 'Wood Neroli is a floral scent, wood, musk for men, launched by perfume company Bvlgari in 2019. This is also the second scent in Bvlgari''s new collection, with the first edition entitled Wood Essence.', '2024-01-01', 1, '100ml', 94.00, 100, '11_2.jpg'),
( 12, 'Versace Man Eau Fraiche for men is suitable for daytime, especially in summer when the weather is hot. Help boys stay fresh and refreshed with a cool and masculine scent.', '2024-01-01', 1, '30ml', 32.00, 100, '12_1.jpg'),
( 12, 'Versace Man Eau Fraiche for men is suitable for daytime, especially in summer when the weather is hot. Help boys stay fresh and refreshed with a cool and masculine scent.', '2024-01-01', 1, '100ml', 103.00, 100, '12_2.jpg'),
( 13, 'Gucci Guilty Absolute Pour Homme is a powerful and masculine fragrance that offers charm and mystery. With a combination of woody, amber and leather notes, this perfume creates a sense of charm and power.', '2024-01-01', 1, '30ml', 25.50, 100, '13_1.jpg'),
( 13, 'Gucci Guilty Absolute Pour Homme is a powerful and masculine fragrance that offers charm and mystery. With a combination of woody, amber and leather notes, this perfume creates a sense of charm and power.', '2024-01-01', 1, '100ml', 82.50, 100, '13_2.jpg'),
( 14, 'Yves Saint Laurent Y EDP is a modern and powerful fragrance that is ideal for confident and stylish men. The refreshing tip notes of citrus and ginger, combined with the middle notes from sage and the end notes from wood and amber, create a unique and lasting scent.', '2024-01-01', 1, '30ml', 49.99, 100, '14_1.jpg'),
( 14, 'Yves Saint Laurent Y EDP is a modern and powerful fragrance that is ideal for confident and stylish men. The refreshing tip notes of citrus and ginger, combined with the middle notes from sage and the end notes from wood and amber, create a unique and lasting scent.', '2024-01-01', 1, '100ml', 139.99, 100, '14_2.jpg'),
( 15, 'Roja Enigma Pour Homme is a complex and mysterious fragrance, ideal for special occasions. With a blend of bergamot, ginger, and cognac, combined with woody and tobacco notes, this perfume offers elegance and charm.', '2024-01-01', 1, '30ml', 35.70, 100, '15_1.jpg'),
( 15, 'Roja Enigma Pour Homme is a complex and mysterious fragrance, ideal for special occasions. With a blend of bergamot, ginger, and cognac, combined with woody and tobacco notes, this perfume offers elegance and charm.', '2024-01-01', 1, '100ml', 103.20, 100, '15_2.jpg'),
( 16, 'Bvlgari Splendida Jasmin Noir EDP is an elegant and delicate fragrance, with early notes of jasmine and almond, middle notes of wood and end notes of musk and vanilla, creating a masculine, luxurious and attractive scent.', '2024-01-01', 1, '30ml', 27.30, 100, '16_1.jpg'),
( 16, 'Bvlgari Splendida Jasmin Noir EDP is an elegant and delicate fragrance, with early notes of jasmine and almond, middle notes of wood and end notes of musk and vanilla, creating a masculine, luxurious and attractive scent.', '2024-01-01', 1, '100ml', 92.50, 100, '16_2.jpg'),
( 17, 'Chanel Antaeus Pour Homme EDT is a strong and masculine fragrance, with a combination of woody, amber and spice notes. This fragrance gives confidence and strength, ideal for important occasions and special evenings.', '2024-01-01', 1, '30ml', 43.20, 100, '17_1.jpg'),
( 17, 'Chanel Antaeus Pour Homme EDT is a strong and masculine fragrance, with a combination of woody, amber and spice notes. This fragrance gives confidence and strength, ideal for important occasions and special evenings.', '2024-01-01', 1, '100ml', 139.99, 100, '17_2.jpg'),
( 18, 'Dior Homme Sport EDT is a fresh and active fragrance, ideal for active and sporting days. The top notes of citrus and ginger, combined with the middle notes from sage and the last notes from wood and musk, create a masculine and refreshing scent.', '2024-01-01', 1, '30ml', 28.90, 100, '18_1.jpg'),
( 18, 'Dior Homme Sport EDT is a fresh and active fragrance, ideal for active and sporting days. The top notes of citrus and ginger, combined with the middle notes from sage and the last notes from wood and musk, create a masculine and refreshing scent.', '2024-01-01', 1, '100ml', 94.90, 100, '18_2.jpg'),
( 19, 'Versace Eros Flame is a passionate and seductive fragrance, with a blend of bergamot, lemon and tangerine notes, combined with woody and final notes from vanilla and musk. This perfume gives confidence and charisma, ideal for special occasions.', '2024-01-01', 1, '30ml', 35.60, 100, '19_1.jpg'),
( 19, 'Versace Eros Flame is a passionate and seductive fragrance, with a blend of bergamot, lemon and tangerine notes, combined with woody and final notes from vanilla and musk. This perfume gives confidence and charisma, ideal for special occasions.', '2024-01-01', 1, '100ml', 135.00, 100, '19_2.jpg'),
( 20, 'Issey Miyake Nuit d''Issey EDT is a mysterious and enchanting fragrance, with a combination of woody, amber and spice notes. This fragrance gives confidence and charm, ideal for evenings and important occasions.', '2024-01-01', 1, '30ml', 34.00, 100, '20_1.jpg'),
( 20, 'Issey Miyake Nuit d''Issey EDT is a mysterious and enchanting fragrance, with a combination of woody, amber and spice notes. This fragrance gives confidence and charm, ideal for evenings and important occasions.', '2024-01-01', 1, '100ml', 104.00, 100, '20_2.jpg'),

--Details full for women
	(21, 'Chanel Chance EDP has been famous for many years, Chanel is sought after and used by many people because of its classy scent. Chanel Chance Eau De Parfum is one of the perfume lines most sought after by women, including me.', '2024-01-01', 1, '30ml', 70.00, 100, '1_1.jpg'), 
(21, 'Chanel Chance EDP has been famous for many years, Chanel is sought after and used by many people because of its classy scent. Chanel Chance Eau De Parfum is one of the perfume lines most sought after by women, including me.', '2024-01-01', 1, '100ml', 235.00, 100, '1_2.jpg'), 
(22, 'Dior Joy is a work that Dior has cherished for a long time, but has just released it. A new scent, completely different from previous perfumes. If these scents The previous scent was classic and elegant. Dior Joy is a scent full of joy and happiness that Dior wants to send to women.', '2024-01-01', 1, '30ml', 25.00, 100, '2_1.jpg'), 
(22, 'Dior Joy is a work that Dior has cherished for a long time, but has just released it. A new scent, completely different from previous perfumes. If these scents The previous scent was classic and elegant. Dior Joy is a scent full of joy and happiness that Dior wants to send to women.', '2024-01-01', 1, '100ml', 73.00, 100, '2_2.jpg'), 
(23, 'YSL Libre is a women perfume product line of high-end fashion house Yves Saint Laurent launched in 2019. YSL Libre belongs to the oriental scent group for women and is Created by two mixologists Anne Flipo and Carlos Benaim, Libre means "freedom" in French, inspired by the desire for freedom of independent, luxurious and sexy women.', '2024-01-01', 1, '30ml', 60.00, 100, '3_1.jpg'), 
(23, 'YSL Libre is a women perfume product line of high-end fashion house Yves Saint Laurent launched in 2019. YSL Libre belongs to the oriental scent group for women and is Created by two mixologists Anne Flipo and Carlos Benaim, Libre means "freedom" in French, inspired by the desire for freedom of independent, luxurious and sexy women.', '2024-01-01', 1, '100ml', 118.00, 100, '3_2.jpg'), 
(24, 'Louis Vuitton Spell On You EDP is a high-end women perfume product from the famous fashion brand Louis Vuitton. Launched in 2021, Spell On You promises is a safe choice for every girl because of its fresh, delicate, gentle scent.', '2024-01-01', 1, '30ml', 52.00, 100, '4_1.jpg'), 
(24, 'Louis Vuitton Spell On You EDP is a high-end women perfume product from the famous fashion brand Louis Vuitton. Launched in 2021, Spell On You promises is a safe choice for every girl because of its fresh, delicate, gentle scent.', '2024-01-01', 1, '100ml', 149.00, 100, '4_2.jpg'), 
(25, 'Chance Eau Fraiche captivates the world with its playful, lively and sparkling fragrance. Recently, Chanel launched a new line of women perfume Chance Eau Fraiche - brilliant Brilliant and elegant. A new opportunity is at hand.', '2024-01-01', 1, '30ml', 83.00, 100, '5_1.jpg'), 
(25, 'Chance Eau Fraiche captivates the world with its playful, lively and sparkling fragrance. Recently, Chanel launched a new line of women perfume Chance Eau Fraiche - brilliant Brilliant and elegant. A new opportunity is at hand.', '2024-01-01', 1, '100ml', 235.00, 100, '5_2.jpg'), 
(26, 'Lancome La Vie Est Belle En Rose is a fresh and radiant fragrance for women. The top notes of red berries and bergamot provide freshness, while the middle notes from rose and peony add femininity and tenderness. The last scent of musk and wood creates a warm and lasting feeling, helping you always feel confident and happy.', '2024-01-01', 1, '30ml', 56.60, 100, '6_1.jpg'), 
(26, 'Lancome La Vie Est Belle En Rose is a fresh and radiant fragrance for women. The top notes of red berries and bergamot provide freshness, while the middle notes from rose and peony add femininity and tenderness. The last scent of musk and wood creates a warm and lasting feeling, helping you always feel confident and happy.', '2024-01-01', 1, '100ml', 167.90, 100, '6_2.jpg'), 
(27, 'Lancome Tresor La Nuit EDP is a seductive and mysterious fragrance for women. With top notes from raspberries and pears, middle notes from black roses and vanilla orchids, along with final notes of woody and resinous, this perfume offers an enchanting charm, ideal for special evenings.', '2024-01-01', 1, '30ml', 52.00, 100, '7_1.jpg'), 
(27, 'Lancome Tresor La Nuit EDP is a seductive and mysterious fragrance for women. With top notes from raspberries and pears, middle notes from black roses and vanilla orchids, along with final notes of woody and resinous, this perfume offers an enchanting charm, ideal for special evenings.', '2024-01-01', 1, '100ml', 149.00, 100, '7_2.jpg'), 
(28, 'Lancome La Vie Est Belle EDP is a sweet and elegant fragrance for women. The top notes of pears and black currants, combined with mid-notes from irises, jasmine and orange blossoms, and the final notes of nougat beans, tonka beans and vanilla, create a perfect and enticing scent that brings a sense of happiness and fulfillment.', '2024-01-01', 1, '30ml', 52.00, 100, '8_1.jpg'), 
(28, 'Lancome La Vie Est Belle EDP is a sweet and elegant fragrance for women. The top notes of pears and black currants, combined with mid-notes from irises, jasmine and orange blossoms, and the final notes of nougat beans, tonka beans and vanilla, create a perfect and enticing scent that brings a sense of happiness and fulfillment.', '2024-01-01', 1, '100ml', 149.00, 100, '8_2.jpg'), 
(29, 'Gucci Bloom Ambrosia di Fiori EDP is a fresh and luxurious floral fragrance. The top notes of jasmine and lily, combined with the middle notes from magnolia and the end notes of Damascena roses, create a feminine and seductive scent, ideal for special occasions.', '2024-01-01', 1, '30ml', 52.00, 100, '9_1.jpg'), 
(29, 'Gucci Bloom Ambrosia di Fiori EDP is a fresh and luxurious floral fragrance. The top notes of jasmine and lily, combined with the middle notes from magnolia and the end notes of Damascena roses, create a feminine and seductive scent, ideal for special occasions.', '2024-01-01', 1, '100ml', 149.00, 100, '9_2.jpg'), 
(30, 'Bvlgari Rose Goldea EDP is a passionate and noble fragrance for women. With a combination of rose, musk and amber notes, this perfume offers a feminine, elegant and seductive scent, ideal for romantic evenings or important events.', '2024-01-01', 1, '30ml', 52.00, 100, '10_1.jpg'), 
(30, 'Bvlgari Rose Goldea EDP is a passionate and noble fragrance for women. With a combination of rose, musk and amber notes, this perfume offers a feminine, elegant and seductive scent, ideal for romantic evenings or important events.', '2024-01-01', 1, '100ml', 149.00, 100, '10_2.jpg'), 
(31, 'Armaf Club de Nuit for Women is a sweet and seductive fragrance, with early notes from bergamot, grapefruit and peach, middle notes from rose, geranium and jasmine, and final notes of vanilla, musk and amber. This perfume gives confidence and charisma, ideal for every occasion.', '2024-01-01', 1, '30ml', 52.00, 100, '11_1.jpg'), 
(31, 'Armaf Club de Nuit for Women is a sweet and seductive fragrance, with early notes from bergamot, grapefruit and peach, middle notes from rose, geranium and jasmine, and final notes of vanilla, musk and amber. This perfume gives confidence and charisma, ideal for every occasion.', '2024-01-01', 1, '100ml', 149.00, 100, '11_2.jpg'), 
(32, 'Carolina Herrera Good Girl EDP is a luxurious and seductive fragrance for women. The top notes of almonds and coffee beans, combined with the middle notes of jasmine and tuberose, and the last notes from tonka beans and cocoa, create a perfect and unique scent, suitable for special evenings or important events.', '2024-01-01', 1, '30ml', 52.00, 100, '12_1.jpg'), 
(32, 'Carolina Herrera Good Girl EDP is a luxurious and seductive fragrance for women. The top notes of almonds and coffee beans, combined with the middle notes of jasmine and tuberose, and the last notes from tonka beans and cocoa, create a perfect and unique scent, suitable for special evenings or important events.', '2024-01-01', 1, '100ml', 149.00, 100, '12_2.jpg'), 
(33, 'Versace Bright Crystal EDT is a fresh and radiant fragrance for women. With early notes from pomegranate, yuzu and ice, middle notes from peony, magnolia and lotus, and the last notes from musk and amber, this perfume brings an elegant, charming and seductive scent, ideal for daily use or special occasions.', '2024-01-01', 1, '30ml', 52.00, 100, '13_1.jpg'), 
(33, 'Versace Bright Crystal EDT is a fresh and radiant fragrance for women. With early notes from pomegranate, yuzu and ice, middle notes from peony, magnolia and lotus, and the last notes from musk and amber, this perfume brings an elegant, charming and seductive scent, ideal for daily use or special occasions.', '2024-01-01', 1, '100ml', 149.00, 100, '13_2.jpg'), 
(34, 'Calvin Klein Euphoria EDP is a luxurious and seductive fragrance for women. With top notes from pomegranate, persimmon and green leaves, middle notes from black orchids, lotuses and champaca, and the final notes from amber, black violets and mahogany, this perfume offers a unique and captivating scent.', '2024-01-01', 1, '30ml', 52.00, 100, '14_1.jpg'), 
(34, 'Calvin Klein Euphoria EDP is a luxurious and seductive fragrance for women. With top notes from pomegranate, persimmon and green leaves, middle notes from black orchids, lotuses and champaca, and the final notes from amber, black violets and mahogany, this perfume offers a unique and captivating scent.', '2024-01-01', 1, '100ml', 149.00, 100, '14_2.jpg'), 
(35, 'Narciso Rodriguez for Her EDT is a sweet and elegant fragrance for women. With top notes from peach and rose, middle notes from musk and amber, and the final notes from sandalwood and patchouli, this perfume offers a perfect and enticing scent, ideal for special occasions or daily use.', '2024-01-01', 1, '30ml', 52.00, 100, '15_1.jpg'), 
(35, 'Narciso Rodriguez for Her EDT is a sweet and elegant fragrance for women. With top notes from peach and rose, middle notes from musk and amber, and the final notes from sandalwood and patchouli, this perfume offers a perfect and enticing scent, ideal for special occasions or daily use.', '2024-01-01', 1, '100ml', 149.00, 100, '15_2.jpg'), 
(36, 'Jo Malone Peony & Blush Suede is a fresh and luxurious floral fragrance. With top notes from red apples, middle notes from peonies and roses, and the final notes from suede and amber, this perfume offers a feminine, elegant and seductive scent, ideal for special occasions.', '2024-01-01', 1, '30ml', 52.00, 100, '16_1.jpg'), 
(36, 'Jo Malone Peony & Blush Suede is a fresh and luxurious floral fragrance. With top notes from red apples, middle notes from peonies and roses, and the final notes from suede and amber, this perfume offers a feminine, elegant and seductive scent, ideal for special occasions.', '2024-01-01', 1, '100ml', 149.00, 100, '16_2.jpg'), 
(37, 'Tom Ford Black Orchid EDP is a luxurious and mysterious fragrance for women. With top notes from black truffles, ylang-ylang and bergamot, middle notes from black orchids, lotuses and champaca, and the final notes from patchouli, sandalwood and vanilla, this perfume offers a unique and captivating scent.', '2024-01-01', 1, '30ml', 52.00, 100, '17_1.jpg'), 
(37, 'Tom Ford Black Orchid EDP is a luxurious and mysterious fragrance for women. With top notes from black truffles, ylang-ylang and bergamot, middle notes from black orchids, lotuses and champaca, and the final notes from patchouli, sandalwood and vanilla, this perfume offers a unique and captivating scent.', '2024-01-01', 1, '100ml', 149.00, 100, '17_2.jpg'), 
(38, 'Burberry Her EDP is a sweet and radiant fragrance for women. With top notes from black currants, raspberries and cherries, middle notes from jasmine and violets, and the final notes from musk and amber, this perfume offers a feminine, elegant and seductive scent, ideal for special occasions.', '2024-01-01', 1, '30ml', 52.00, 100, '18_1.jpg'), 
(38, 'Burberry Her EDP is a sweet and radiant fragrance for women. With top notes from black currants, raspberries and cherries, middle notes from jasmine and violets, and the final notes from musk and amber, this perfume offers a feminine, elegant and seductive scent, ideal for special occasions.', '2024-01-01', 1, '100ml', 149.00, 100, '18_2.jpg'), 
(39, 'Givenchy L’Interdit EDP is a luxurious and mysterious fragrance for women. With top notes from black berries, pears and bergamot, middle notes from tuberose, jasmine and orange blossoms, and the final notes from patchouli, vetiver and vanilla, this perfume offers a unique and captivating scent.', '2024-01-01', 1, '30ml', 52.00, 100, '19_1.jpg'), 
(39, 'Givenchy L’Interdit EDP is a luxurious and mysterious fragrance for women. With top notes from black berries, pears and bergamot, middle notes from tuberose, jasmine and orange blossoms, and the final notes from patchouli, vetiver and vanilla, this perfume offers a unique and captivating scent.', '2024-01-01', 1, '100ml', 149.00, 100, '19_2.jpg'), 
(40, 'Hermes Twilly d’Hermes EDP is a fresh and luxurious fragrance for women. With top notes from ginger, middle notes from tuberose and jasmine, and the final notes from sandalwood and vanilla, this perfume offers a feminine, elegant and seductive scent, ideal for special occasions.', '2024-01-01', 1, '30ml', 52.00, 100, '20_1.jpg'), 
(40, 'Hermes Twilly d’Hermes EDP is a fresh and luxurious fragrance for women. With top notes from ginger, middle notes from tuberose and jasmine, and the final notes from sandalwood and vanilla, this perfume offers a feminine, elegant and seductive scent, ideal for special occasions.', '2024-01-01', 1, '100ml', 149.00, 100, '20_2.jpg'),
	--Details full for unisex
(41, 'Xerjoff Naxos EDP perfume is a unisex perfume line in the special collection of the Xerjoff brand. Launched in 2015, inspired by the essence of beauty. An island located in the middle of the Mediterranean Sea, Sicily.', '2024-01-01', 1, '30ml', 47.00, 100, '1_1.jpg'),
(41, 'Xerjoff Naxos EDP perfume is a unisex perfume line in the special collection of the Xerjoff brand. Launched in 2015, inspired by the essence of beauty. An island located in the middle of the Mediterranean Sea, Sicily.', '2024-01-01', 1, '100ml', 134.00, 100, '1_2.jpg'),
(42, 'Armaf Sterling Club De Nuit Milestone EDP perfume is the best-selling product line of Armaf perfume with a sweet and modern scent, a delicate blend of unique scent notes.', '2024-01-01', 1, '30ml', 39.00, 100, '2_1.jpg'),
(42, 'Armaf Sterling Club De Nuit Milestone EDP perfume is the best-selling product line of Armaf perfume with a sweet and modern scent, a delicate blend of unique scent notes.', '2024-01-01', 1, '100ml', 119.00, 100, '2_2.jpg'),
(43, 'In 2019, the Gucci brand launched the Gucci A Song For The Rose EDP perfume line, this is a unisex perfume for both men and women. Distilled scent From the floral scent group thyme creates a sweet and seductive scent.', '2024-01-01', 1, '30ml', 17.00, 100, '3_1.jpg'),
(43, 'In 2019, the Gucci brand launched the Gucci A Song For The Rose EDP perfume line, this is a unisex perfume for both men and women. Distilled scent From the floral scent group thyme creates a sweet and seductive scent.', '2024-01-01', 1, '100ml', 59.00, 100, '3_2.jpg'),
(44, 'Like other perfume lines of the Le Labo brand, the Le Labo The Noir 29 EDP perfume line has a minimalist, stylish bottle design. to a luxurious, sophisticated feeling. The perfume bottle is made of transparent glass, the color of the perfume inside can be seen. In particular, the owner of this perfume bottle can print his or her name on it sticker, this represents the personalization of the product, bringing a new and unique experience to customers.', '2024-01-01', 1, '30ml', 73.00, 100, '4_1.jpg'),
(44, 'Like other perfume lines of the Le Labo brand, the Le Labo The Noir 29 EDP perfume line has a minimalist, stylish bottle design. to a luxurious, sophisticated feeling. The perfume bottle is made of transparent glass, the color of the perfume inside can be seen. In particular, the owner of this perfume bottle can print his or her name on it sticker, this represents the personalization of the product, bringing a new and unique experience to customers.', '2024-01-01', 1, '100ml', 225.00, 100, '4_2.jpg'),
(45, 'Are you looking for a perfume line for both women and men with a truly luxurious scent as well as making an impression at the first moment? Then Louis Vuitton Ombre Nomade EDP is the right choice right now. This is a unisex perfume line from the luxury brand Louis Vuitton.', '2024-01-01', 1, '30ml', 36.00, 100, '5_1.jpg'),
(45, 'Are you looking for a perfume line for both women and men with a truly luxurious scent as well as making an impression at the first moment? Then Louis Vuitton Ombre Nomade EDP is the right choice right now. This is a unisex perfume line from the luxury brand Louis Vuitton.', '2024-01-01', 1, '100ml', 106.00, 100, '5_2.jpg'),
(46, 'Creed Silver Mountain Water is a fresh and pure fragrance for both men and women. The top notes from bergamot and black currants provide refreshment, while the middle notes from green tea and violets create elegance and sophistication. The last incense from musk and sandalwood helps retain the scent for a long time, giving it a feeling of freshness and energy.', '2024-01-01', 1, '30ml', 36.00, 100, '6_1.jpg'),
(46, 'Creed Silver Mountain Water is a fresh and pure fragrance for both men and women. The top notes from bergamot and black currants provide refreshment, while the middle notes from green tea and violets create elegance and sophistication. The last incense from musk and sandalwood helps retain the scent for a long time, giving it a feeling of freshness and energy.', '2024-01-01', 1, '100ml', 106.00, 100, '6_2.jpg'),
(47, 'Le Labo Bergamote 22 is a fresh and radiant fragrance with early notes from bergamot and grapefruit. The middle notes from orange blossom and vetiver add subtlety, while the final notes from musk and cedarwood provide a warm and pleasant feeling. This is perfect for both men and women on every occasion, from work to dates.', '2024-01-01', 1, '30ml', 36.00, 100, '7_1.jpg'),
(47, 'Le Labo Bergamote 22 is a fresh and radiant fragrance with early notes from bergamot and grapefruit. The middle notes from orange blossom and vetiver add subtlety, while the final notes from musk and cedarwood provide a warm and pleasant feeling. This is perfect for both men and women on every occasion, from work to dates.', '2024-01-01', 1, '100ml', 106.00, 100, '7_2.jpg'),
(48, 'Le Labo Santal 33 is a distinctive and seductive fragrance with heads from sandalwood and pepper. The middle notes from violets and cardamom make it unique, while the final notes from musk and amber provide warmth and appeal. This is the ideal choice for both men and women on special occasions.', '2024-01-01', 1, '30ml', 36.00, 100, '8_1.jpg'),
(48, 'Le Labo Santal 33 is a distinctive and seductive fragrance with heads from sandalwood and pepper. The middle notes from violets and cardamom make it unique, while the final notes from musk and amber provide warmth and appeal. This is the ideal choice for both men and women on special occasions.', '2024-01-01', 1, '100ml', 106.00, 100, '8_2.jpg'),
(49, 'Roja Dove Amber Aoud Parfum is a luxurious and noble fragrance with notes from lemon and bergamot. The middle notes from rose and saffron stigmas combine with final notes from agarwood and amber, providing warmth and charm. This is a great choice for both men and women on important occasions.', '2024-01-01', 1, '30ml', 36.00, 100, '9_1.jpg'),
(49, 'Roja Dove Amber Aoud Parfum is a luxurious and noble fragrance with notes from lemon and bergamot. The middle notes from rose and saffron stigmas combine with final notes from agarwood and amber, providing warmth and charm. This is a great choice for both men and women on important occasions.', '2024-01-01', 1, '100ml', 106.00, 100, '9_2.jpg'),
(50, 'Louis Vuitton Cactus Garden EDP is a refreshing and liberal fragrance with notes from bergamot and green tea. The middle notes from vetiver and ginger provide freshness and refreshment, while the final notes from musk create a sense of freedom and dynamism. This is perfect for summer days.', '2024-01-01', 1, '30ml', 36.00, 100, '10_1.jpg'),
(50, 'Louis Vuitton Cactus Garden EDP is a refreshing and liberal fragrance with notes from bergamot and green tea. The middle notes from vetiver and ginger provide freshness and refreshment, while the final notes from musk create a sense of freedom and dynamism. This is perfect for summer days.', '2024-01-01', 1, '100ml', 106.00, 100, '10_2.jpg'),
(51, 'Tom Ford Lost Cherry is a fruity and delicious fragrance with early notes from cherry and almond. The middle notes from Turkish rose and jasmine combine with the final notes from Peru balsam and tonka bean, creating a luxurious and passionate feeling. This is the ideal choice for romantic occasions.', '2024-01-01', 1, '30ml', 36.00, 100, '11_1.jpg'),
(51, 'Tom Ford Lost Cherry is a fruity and delicious fragrance with early notes from cherry and almond. The middle notes from Turkish rose and jasmine combine with the final notes from Peru balsam and tonka bean, creating a luxurious and passionate feeling. This is the ideal choice for romantic occasions.', '2024-01-01', 1, '100ml', 106.00, 100, '11_2.jpg'),
(52, 'Chanel EDP No.5 is the legendary fragrance of the Chanel brand, known for its timeless elegance and sophistication. The top notes of rose and jasmine provide a luxurious feeling, while the middle notes of aldehydes add sparkle and freshness. The final notes from vanilla and vetiver add warmth and depth. This is a must-have item for every woman.', '2024-01-01', 1, '30ml', 36.00, 100, '12_1.jpg'),
(52, 'Chanel EDP No.5 is the legendary fragrance of the Chanel brand, known for its timeless elegance and sophistication. The top notes of rose and jasmine provide a luxurious feeling, while the middle notes of aldehydes add sparkle and freshness. The final notes from vanilla and vetiver add warmth and depth. This is a must-have item for every woman.', '2024-01-01', 1, '100ml', 106.00, 100, '12_2.jpg'),
(53, 'Christian Dior Oud Ispahan is a luxurious and mysterious fragrance, made from the rarest oud wood. The top notes of labdanum and patchouli create a deep and enchanting scent, while the middle notes of rose and sandalwood add sophistication and refinement. The final notes from benzoin and amber provide warmth and depth, making this a perfect choice for special occasions.', '2024-01-01', 1, '30ml', 36.00, 100, '13_1.jpg'),
(53, 'Christian Dior Oud Ispahan is a luxurious and mysterious fragrance, made from the rarest oud wood. The top notes of labdanum and patchouli create a deep and enchanting scent, while the middle notes of rose and sandalwood add sophistication and refinement. The final notes from benzoin and amber provide warmth and depth, making this a perfect choice for special occasions.', '2024-01-01', 1, '100ml', 106.00, 100, '13_2.jpg'),
(54, 'Chanel EDP Coco Mademoiselle is a fresh and modern fragrance with top notes of orange and bergamot. The middle notes from rose and jasmine add femininity, while the final notes from vanilla and patchouli provide warmth and depth. This is the ideal choice for every woman.', '2024-01-01', 1, '30ml', 36.00, 100, '14_1.jpg'),
(54, 'Chanel EDP Coco Mademoiselle is a fresh and modern fragrance with top notes of orange and bergamot. The middle notes from rose and jasmine add femininity, while the final notes from vanilla and patchouli provide warmth and depth. This is the ideal choice for every woman.', '2024-01-01', 1, '100ml', 106.00, 100, '14_2.jpg'),
(55, 'Creed Aventus EDP is a fruity and rich fragrance for both men and women. The top notes from black currants and apples provide freshness, while the middle notes from birch and jasmine add sophistication. The final notes from musk and vanilla provide warmth and depth, making this a perfect choice for any occasion.', '2024-01-01', 1, '30ml', 36.00, 100, '15_1.jpg'),
(55, 'Creed Aventus EDP is a fruity and rich fragrance for both men and women. The top notes from black currants and apples provide freshness, while the middle notes from birch and jasmine add sophistication. The final notes from musk and vanilla provide warmth and depth, making this a perfect choice for any occasion.', '2024-01-01', 1, '100ml', 106.00, 100, '15_2.jpg'),
(56, 'Armani EDP Code is a masculine and elegant fragrance with top notes of bergamot and lemon. The middle notes from star anise and olive blossom add sophistication, while the final notes from tonka bean and guaiac wood provide warmth and depth. This is the ideal choice for confident and modern men.', '2024-01-01', 1, '30ml', 36.00, 100, '16_1.jpg'),
(56, 'Armani EDP Code is a masculine and elegant fragrance with top notes of bergamot and lemon. The middle notes from star anise and olive blossom add sophistication, while the final notes from tonka bean and guaiac wood provide warmth and depth. This is the ideal choice for confident and modern men.', '2024-01-01', 1, '100ml', 106.00, 100, '16_2.jpg'),
(57, 'Bleu de Chanel EDP is a masculine and aromatic fragrance with top notes from grapefruit and pink pepper. The middle notes from ginger and mint add freshness and sophistication, while the final notes from sandalwood and cedarwood provide warmth and depth. This is the ideal choice for every man.', '2024-01-01', 1, '30ml', 36.00, 100, '17_1.jpg'),
(57, 'Bleu de Chanel EDP is a masculine and aromatic fragrance with top notes from grapefruit and pink pepper. The middle notes from ginger and mint add freshness and sophistication, while the final notes from sandalwood and cedarwood provide warmth and depth. This is the ideal choice for every man.', '2024-01-01', 1, '100ml', 106.00, 100, '17_2.jpg'),
(58, 'Tom Ford Noir Anthracite EDP is a masculine and powerful fragrance with top notes of bergamot and spicy notes. The middle notes from jasmine and ginger add sophistication, while the final notes from sandalwood and cedarwood provide warmth and depth. This is the ideal choice for modern and confident men.', '2024-01-01', 1, '30ml', 36.00, 100, '18_1.jpg'),
(58, 'Tom Ford Noir Anthracite EDP is a masculine and powerful fragrance with top notes of bergamot and spicy notes. The middle notes from jasmine and ginger add sophistication, while the final notes from sandalwood and cedarwood provide warmth and depth. This is the ideal choice for modern and confident men.', '2024-01-01', 1, '100ml', 106.00, 100, '18_2.jpg'),
(59, 'Creed Green Irish Tweed EDP is a fresh and classic fragrance with top notes of lemon and verbena. The middle notes from violet leaves and iris add sophistication, while the final notes from ambergris and sandalwood provide warmth and depth. This is the ideal choice for every man.', '2024-01-01', 1, '30ml', 36.00, 100, '19_1.jpg'),
(59, 'Creed Green Irish Tweed EDP is a fresh and classic fragrance with top notes of lemon and verbena. The middle notes from violet leaves and iris add sophistication, while the final notes from ambergris and sandalwood provide warmth and depth. This is the ideal choice for every man.', '2024-01-01', 1, '100ml', 106.00, 100, '19_2.jpg'),
(60, 'Creed Viking EDP is a bold and masculine fragrance with top notes of lemon and pink pepper. The middle notes from rose and peppermint add sophistication, while the final notes from sandalwood and vetiver provide warmth and depth. This is the ideal choice for modern and adventurous men.', '2024-01-01', 1, '30ml', 36.00, 100, '20_1.jpg'),
(60, 'Creed Viking EDP is a bold and masculine fragrance with top notes of lemon and pink pepper. The middle notes from rose and peppermint add sophistication, while the final notes from sandalwood and vetiver provide warmth and depth. This is the ideal choice for modern and adventurous men.', '2024-01-01', 1, '100ml', 106.00, 100, '20_2.jpg'),
--Details full for gift set
(61, 'YSL Black Opium Eau De Parfum Christmas 2021 gift set, the new perfume line was announced as a classic rocknroll performance highlighting the magical, mysterious aspect of the YSL brand. Perfumers Nathalie Lorson and MarieSalamagne, collaborated with Olivier Cresp and Honorine Blanc to create this scent. YSL Black Opium is Yves Saint Laurent first coffee-flower scent. The energy of black coffee dominates the entire fragrance of white flowers with assertive femininity accented by pink pepper and pear in the background.', '2024-01-01', 1, NULL, 100.00, 50, '1_1.jpg'),
(62, 'BVLGari set of 3 bottles of 15ml includes 3 typical fragrances of the Bvlgari Omnia collection with 3 different styles and personalities gathered in the Bvlgari Omnia gift set so girls can experience the feelings about different scents. Bvlgari Omnia Coral EDT perfume 15ml Bvlgari Omnia Crystalline EDT perfume 15ml Bvlgari Omnia Amethyste EDT Perfume 15ml With a sophisticated, seductive and easy-to-use style, this collection will be a great choice when girls go to work or go out or picnic.', '2024-01-01', 1, NULL, 150.00, 50, '2_1.jpg'),
(63, 'Set of 5 Lancome perfumes includes: Lancome Hypnose Eau de Parfum 5ml Lancome Tresor Eau de Parfum 7.5ml Lancome La vie est belle Eau de Parfum 4ml Lancome Miracle Eau de Parfum 5ml Lancome Tresor in Love Eau de Parfum 5ml', '2024-01-01', 1, NULL, 185.00, 50, '3_1.jpg'),
(64, 'BVLGARI Omnia Amethyste Gift Set', '2024-01-01', 1, NULL, 212.00, 50, '4_1.jpg'),
(65, 'Versace Absolute Gift Set 4 items: Versace Bright Crystal Absolu EDP 90ml perfume Versace Bright Crystal Absolu EDP 10ml Versace Perfumed Body Lotion 100ml Versace Perfumed Shower Gel 100ml', '2024-01-01', 1, NULL, 139.00, 50, '5_1.jpg');


GO

/* ============[Cart] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Cart];
CREATE TABLE [dbo].[Cart] (
    CartID INT PRIMARY KEY IDENTITY(1,1),
    ProductFullDetailID INT NOT NULL,
	AccountID int NOT NULL,
    Quantity INT NOT NULL,
	productName [NVARCHAR](255),
	FOREIGN KEY (AccountID) REFERENCES [dbo].[Accounts]([AccountID]),
    FOREIGN KEY (ProductFullDetailID) REFERENCES [dbo].[ProductFullDetail]([ProductFullDetailID]),
)
/*======= INSERT VALUE OF [Cart] TABLE =======*/

GO
/* ============[WishList] TABLE============*/
DROP TABLE IF EXISTS [dbo].[WishList];
CREATE TABLE [dbo].[Wishlist] (
    [WishlistID] [INT] PRIMARY KEY IDENTITY(1,1),
    [AccountID] [INT] NOT NULL,
    [ProductID] [INT] NOT NULL,
    [DateAdded] DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Accounts]([AccountID]),
    FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products]([ProductID])
);
/*======= INSERT VALUE OF [WishList] TABLE =======*/
INSERT INTO [dbo].[Wishlist] (AccountID,ProductID) VALUES
(1,1);
/* ============[StatusOrder] TABLE============*/
DROP TABLE IF EXISTS [dbo].[StatusOrder];
CREATE TABLE [dbo].[StatusOrder] (
    SOID INT PRIMARY KEY IDENTITY(1,1),
    SOName NVARCHAR(255) NOT NULL
)
/*======= INSERT VALUE OF [StatusOrder] TABLE =======*/
INSERT INTO [dbo].[StatusOrder] (SOName) VALUES
('Processing'),
('Done'),
('Cancelled');
GO


/* ============[Orders] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Orders];
CREATE TABLE [dbo].[Orders] (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderTotalPrice FLOAT NOT NULL,
    OrderContactName NVARCHAR(255) NOT NULL,
    OrderPhone NVARCHAR(255) NOT NULL,
    OrderAddress NVARCHAR(255) NOT NULL,
    OrderStatus INT NOT NULL,
    OrderReceiveDate DATE NULL,
    OrderNote NVARCHAR(255) NULL,
    OrderSoID INT NOT NULL,
	VoucherID INT NOT NULL,
	 FOREIGN KEY (VoucherID) REFERENCES [dbo].[Vouchers](VoucherID),
    FOREIGN KEY (AccountID) REFERENCES [dbo].[Accounts](AccountID),
    FOREIGN KEY (OrderSoID) REFERENCES [dbo].[StatusOrder](SOID)
)
/*======= INSERT VALUE OF [Orders] TABLE =======*/
INSERT INTO [dbo].[Orders] (AccountID, OrderDate, OrderTotalPrice, OrderContactName, OrderPhone, OrderAddress, OrderStatus, OrderReceiveDate, OrderNote, OrderSoID, VoucherID) VALUES
(1, '2024-07-01', 200.00, 'John Doe', '1234567890', 'N 123 Nguyễn Văn Trỗi - Hà Nội', 1, '2024-07-05', 'Please deliver in the morning', 1, 1),
(2, '2024-07-01', 150.00, 'Jane Smith', '0987654321', 'N 456 Tố Hữu - Thanh Xuân - Hà Nội', 2, '2024-07-05', 'Leave at the front door', 2, 2),
(3, '2024-07-01', 300.00, 'Alice Johnson', '1122334455', 'N 789 Trần Duy Hưng - Hà Nội', 1, '2024-07-05', 'Ring the bell', 1, 1),
(4, '2024-07-01', 250.00, 'Bob Brown', '2233445566', 'N 101 Đội Cấn - Hà Nội', 2, '2024-07-05', 'Call upon arrival', 2, 1),
(5, '2024-05-01', 180.00, 'Charlie White', '3344556677', 'N 202 Kim Mã - Hà Nội', 1, '2024-05-05', 'Deliver to reception', 1, 1),
(6, '2024-06-01', 220.00, 'David Green', '4455667788', 'N 303 Hoàng Hoa Thám - Hà Nội', 2, '2024-06-05', 'No special instructions', 2, 1),
(7, '2024-07-01', 275.00, 'Eva Black', '5566778899', 'N 404 Bà Triệu - Hà Nội', 1, '2024-07-05', 'Deliver before noon', 1, 1),
(8, '2024-07-01', 190.00, 'Frank Blue', '6677889900', 'N 505 Tôn Đức Thắng - Hà Nội', 2, '2024-07-05', 'Contact before delivery', 2, 1),
(9, '2024-08-01', 210.00, 'Grace Yellow', '7788990011', 'N 606 Hàng Bài - Hà Nội', 1, '2024-08-05', 'Deliver after 2 PM', 1, 1),
(10, '2024-05-01', 230.00, 'Henry Red', '8899001122', 'N 707 Cầu Giấy - Hà Nội', 2, '2024-05-05', 'No specific time', 2, 1);

GO

/* ============[Orders] TABLE============*/
DROP TABLE IF EXISTS [dbo].[OrderDetail];
CREATE TABLE [dbo].[OrderDetail] (
    odID INT PRIMARY KEY IDENTITY(1,1),
    odOrderID INT NOT NULL,
    odProductDetail INT NOT NULL,
    odQuantity INT NOT NULL,
    odPrice FLOAT NOT NULL,
	odName Nvarchar,
    FOREIGN KEY (odOrderID) REFERENCES [dbo].[Orders](OrderID),
    FOREIGN KEY (odProductDetail) REFERENCES [dbo].[ProductFullDetail]([ProductFullDetailID])
)

/*======= INSERT VALUE OF [OrderDetail] TABLE =======*/
INSERT INTO [dbo].[OrderDetail] (odOrderID, odProductDetail, odQuantity, odPrice, odName) VALUES
(1, 1, 2, 100.00, 'Chanel No. 5'),
(1, 2, 1, 100.00, 'Dior Sauvage'),
(2, 1, 3, 30.00, 'Chanel No. 5'),
(2, 1, 2, 45.00, 'Chanel No. 5'),
(3, 3, 1, 300.00, 'Gucci Bloom'),
(3, 2, 2, 150.00, 'Dior Sauvage'),
(4, 1, 1, 250.00, 'Chanel No. 5'),
(4, 2, 2, 125.00, 'Dior Sauvage'),
(5, 4, 2, 90.00, 'Tom Ford Black Orchid'),
(5, 5, 1, 180.00, 'YSL Black Opium'),
(6, 5, 3, 73.33, 'YSL Black Opium'),
(6, 4, 2, 110.00, 'Tom Ford Black Orchid'),
(7, 3, 1, 275.00, 'Gucci Bloom'),
(7, 1, 2, 137.50, 'Chanel No. 5'),
(8, 2, 1, 190.00, 'Dior Sauvage'),
(8, 1, 2, 95.00, 'Chanel No. 5'),
(9, 2, 1, 210.00, 'Dior Sauvage'),
(9, 3, 2, 105.00, 'Gucci Bloom'),
(10, 4, 2, 115.00, 'Tom Ford Black Orchid'),
(10, 5, 1, 230.00, 'YSL Black Opium');

GO




/* ============[Blog] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Blog];
CREATE TABLE [dbo].[Blog](
	[blog_id] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NULL,
	[brief_infor] [nvarchar](max) NULL,
	[content_blog] [nvarchar](max) NULL,
	[thumbnail] [nvarchar](max) NULL,
	[createdAt] [datetime] NULL,
	[updateAt] [datetime] NULL,
	[author_id] [int] NULL,
	[status] [int] NULL,
	FOREIGN KEY ([author_id]) REFERENCES [dbo].[Accounts]([AccountID])
)
/*======= INSERT VALUE OF [Blog] TABLE =======*/

GO

/* ============[Address] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Address];
CREATE TABLE [dbo].[Address] (
    [address_id] INT PRIMARY KEY IDENTITY(1,1),
    [account_id] INT,
	[phone] varchar(11),
    [address_line] NVARCHAR(MAX),
    [city] NVARCHAR(MAX),
    [district] NVARCHAR(MAX),
	[wards] NVARCHAR(MAX),
    [status] INT,
	[create_at] DATE,
    FOREIGN KEY ([account_id]) REFERENCES [dbo].[Accounts]([AccountID])
)
/*======= INSERT VALUE OF [Address] TABLE =======*/
INSERT INTO [dbo].[Address] (account_id, phone, address_line, city, district, wards, status, create_at) VALUES
(1, '1234567890', 'N 123 Ba Đình', 'Hà Nội', 'Đống Đa', 'Ward A', 1, '2024-01-01'),
(2, '0987654321', 'N 456 Hai Bà Trưng ', 'Hà Nội', 'Đống Đa', 'Ward B', 1, '2024-02-01');
GO

/* ============[Feedbacks] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Feedbacks];
CREATE TABLE [dbo].[Feedbacks] (
    fbID INT PRIMARY KEY IDENTITY(1,1),
    fbAccountID INT NOT NULL,
    fbProductID INT NOT NULL,
    fbStar INT NOT NULL,
    fbContent NVARCHAR(255) NULL,
    fbImage NVARCHAR(255) NULL,
    fbDate DATE NOT NULL,
    fbStatus INT NOT NULL,
	[reply] nvarchar (250) NULL,
	FOREIGN KEY (fbProductID) REFERENCES [dbo].[Products]([ProductID]),
    FOREIGN KEY (fbAccountID) REFERENCES [dbo].[Accounts]([AccountID])
)
/*======= INSERT VALUE OF [Feedbacks] TABLE =======*/
INSERT INTO [dbo].[Feedbacks] (fbAccountID, fbProductID, fbStar, fbContent, fbImage, fbDate, fbStatus, reply) VALUES
(1, 1, 5, 'Great product!', 'feedback1.png', '2024-01-01', 1, 'Thank you!'),
(2, 2, 4, 'Good quality', 'feedback2.png', '2024-02-01', 1, 'Glad you liked it!');
GO

/* ============[HistoriesChange] TABLE============*/
DROP TABLE IF EXISTS [dbo].[HistoriesChange];
CREATE TABLE [dbo].[HistoriesChange] (
	[account_id] INT IDENTITY(1,1),
	[date] DATE,
	[text_change] NVARCHAR (MAX),
	[local_change] VARCHAR (MAX),
    FOREIGN KEY ([account_id]) REFERENCES [dbo].[Accounts](AccountID)
)
/*======= INSERT VALUE OF [[HistoriesChange]] TABLE =======*/

GO
/* ============[Sliders] TABLE============*/
DROP TABLE IF EXISTS [dbo].[Sliders];
CREATE TABLE [dbo].[Sliders](
[SliderID] int PRIMARY KEY IDENTITY(1,1),
[SliderImage] nvarchar(255) NOT NULL,
[SliderStatus] int NOT NULL,
[SliderTitle] nvarchar(max) NOT NULL,
[UpdateAt] date,
[AccountID] [int],
FOREIGN KEY ([AccountID]) REFERENCES [dbo].[Accounts]([AccountID]
))
/*======= INSERT VALUE OF [Sliders] TABLE =======*/
INSERT INTO [dbo].[Sliders] ([SliderImage],[SliderTitle],[UpdateAt],[SliderStatus],[AccountID])
VALUES
('images/Sliders/slider1.jpg','Men Collections','2024-01-01',1,5),
('images/Sliders/slider2.jpg','Women Collections','2024-01-01',1,5),
('images/Sliders/slider3.jpg','Unisex Collections','2024-01-01',1,3),
('images/Sliders/slider4.jpg','Men Collections','2024-01-01',0,5),
('images/Sliders/slider5.jpg','Women Collections','2024-01-01',0,5),
('images/Sliders/slider6.jpg','Unisex Collections','2024-01-01',0,3)
