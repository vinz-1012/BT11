CREATE DATABASE DB_De05;
GO

USE DB_De05;
GO

CREATE TABLE UserRoles (
    roleId INT IDENTITY(1,1) PRIMARY KEY,
    roleName NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE Seller (
    sellerId INT IDENTITY(1,1) PRIMARY KEY,
    sellername NVARCHAR(50) NOT NULL,
    images NVARCHAR(500) NULL,
    status INT NULL
);
GO

CREATE TABLE Users (
    userId INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) NULL,
    fullname NVARCHAR(50) NULL,
    password NVARCHAR(50) NOT NULL,
    images NVARCHAR(500) NULL,
    phone NVARCHAR(20) NULL,
    status INT NULL,
    code NVARCHAR(50) NULL,
    roleId INT NULL,
    sellerId INT NULL,
    CONSTRAINT FK_Users_UserRoles FOREIGN KEY (roleId) REFERENCES UserRoles(roleId),
    CONSTRAINT FK_Users_Seller FOREIGN KEY (sellerId) REFERENCES Seller(sellerId)
);
GO

CREATE TABLE Category (
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    categoryName NVARCHAR(200) NOT NULL,
    images NVARCHAR(500) NULL,
    status INT NULL
);
GO

CREATE TABLE Product (
    productId INT IDENTITY(1,1) PRIMARY KEY,
    productName NVARCHAR(200) NOT NULL,
    productCode BIGINT NULL,
    categoryId INT NULL,
    description NVARCHAR(500) NULL,
    price FLOAT NULL,
    amount INT NULL,
    stock INT NULL,
    images NVARCHAR(500) NULL,
    wishlist INT NULL,
    status INT NULL,
    createDate DATE NULL,
    sellerId INT NULL,
    CONSTRAINT FK_Product_Category FOREIGN KEY (categoryId) REFERENCES Category(categoryId),
    CONSTRAINT FK_Product_Seller FOREIGN KEY (sellerId) REFERENCES Seller(sellerId)
);
GO

CREATE TABLE Cart (
    cartId NVARCHAR(50) PRIMARY KEY,
    userId INT NULL,
    buyDate DATETIME NULL,
    status INT NULL,
    CONSTRAINT FK_Cart_Users FOREIGN KEY (userId) REFERENCES Users(userId)
);
GO

CREATE TABLE CartItem (
    cartItemId NVARCHAR(50) PRIMARY KEY,
    quantity INT NULL,
    unitPrice FLOAT NULL,
    productId INT NULL,
    cartId NVARCHAR(50) NULL,
    CONSTRAINT FK_CartItem_Product FOREIGN KEY (productId) REFERENCES Product(productId),
    CONSTRAINT FK_CartItem_Cart FOREIGN KEY (cartId) REFERENCES Cart(cartId)
);
GO

INSERT INTO UserRoles (roleName) VALUES 
(N'Admin'), 
(N'User'), 
(N'Seller');

INSERT INTO Seller (sellername, images, status) VALUES 
(N'Shop Công Nghệ ABC', N'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=300', 1),
(N'Cửa Hàng Gia Dụng XYZ', N'https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=300', 1);

INSERT INTO Category (categoryName, images, status) VALUES 
(N'Điện thoại - Phụ kiện', N'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300', 1),
(N'Laptop - Máy tính', N'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300', 1),
(N'Thời trang nam', N'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=300', 1);

INSERT INTO Users (username, email, fullname, password, images, phone, status, code, roleId, sellerId) VALUES 
(N'admin', N'admin@gmail.com', N'Quản Trị Viên', N'123456', NULL, N'0901234567', 1, NULL, 1, NULL),
(N'seller1', N'seller1@gmail.com', N'Chủ Shop ABC', N'123456', NULL, N'0902345678', 1, NULL, 3, 1),
(N'user1', N'user1@gmail.com', N'Nguyễn Văn A', N'123456', NULL, N'0903456789', 1, NULL, 2, NULL);

INSERT INTO Product (productName, productCode, categoryId, description, price, amount, stock, images, wishlist, status, createDate, sellerId) VALUES 
(N'iPhone 15 Pro Max', 1001, 1, N'Điện thoại flagship cao cấp vỏ titan siêu bền', 29000000, 10, 50, N'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500', 5, 1, GETDATE(), 1),
(N'Tai nghe AirPods Pro 2', 1002, 1, N'Tai nghe chống ồn chủ động đỉnh cao', 5500000, 20, 100, N'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=500', 12, 1, GETDATE(), 1),
(N'Laptop Dell XPS 13', 2001, 2, N'Laptop mỏng nhẹ sang trọng cho văn phòng', 24000000, 5, 20, N'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500', 8, 1, GETDATE(), 1),
(N'Áo Thun Nam Cotton', 3001, 3, N'Áo thun phong cách trẻ trung thoáng mát', 180000, 50, 200, N'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=500', 25, 1, GETDATE(), 2),
(N'Quần Jeans Nam Slimfit', 3002, 3, N'Quần jean co giãn cao cấp tôn dáng chuẩn form', 350000, 30, 80, N'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=500', 15, 1, GETDATE(), 2);
GO
