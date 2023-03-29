USE [master]
GO
/****** Object:  Database [Bookstore]    Script Date: 29.01.2023 15:17:04 ******/
CREATE DATABASE [Bookstore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bookstore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Bookstore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bookstore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Bookstore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Bookstore] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bookstore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bookstore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bookstore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bookstore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bookstore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bookstore] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bookstore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bookstore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bookstore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bookstore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bookstore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bookstore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bookstore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bookstore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bookstore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bookstore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bookstore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bookstore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bookstore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bookstore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bookstore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bookstore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bookstore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bookstore] SET RECOVERY FULL 
GO
ALTER DATABASE [Bookstore] SET  MULTI_USER 
GO
ALTER DATABASE [Bookstore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bookstore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bookstore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bookstore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bookstore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bookstore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Bookstore', N'ON'
GO
ALTER DATABASE [Bookstore] SET QUERY_STORE = OFF
GO
USE [Bookstore]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[ProductID] [smallint] NOT NULL,
	[Pages] [smallint] NOT NULL,
	[OriginalLanguage] [varchar](30) NOT NULL,
	[ReleaseLanguage] [varchar](30) NOT NULL,
	[ISBN] [varchar](13) NOT NULL,
	[BookID] [smallint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Title] [varchar](70) NOT NULL,
	[Author] [varchar](70) NOT NULL,
	[Publisher] [varchar](70) NOT NULL,
	[Genre] [text] NOT NULL,
	[ReleaseDate] [date] NOT NULL,
	[AddedDate] [date] NOT NULL,
	[Price] [float] NOT NULL,
	[Rating] [float] NOT NULL,
	[SoldQuantity] [smallint] NOT NULL,
	[ProductID] [smallint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[BooksTableView]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BooksTableView]
AS
SELECT        dbo.Products.ProductID, dbo.Books.BookID, dbo.Products.Title, dbo.Products.Author, dbo.Products.Publisher, dbo.Products.Genre, dbo.Products.ReleaseDate, dbo.Products.AddedDate, dbo.Products.Price, dbo.Products.Rating, 
                         dbo.Products.SoldQuantity, dbo.Books.ProductID AS Expr1, dbo.Books.Pages, dbo.Books.OriginalLanguage, dbo.Books.ReleaseLanguage, dbo.Books.ISBN
FROM            dbo.Products INNER JOIN
                         dbo.Books ON dbo.Products.ProductID = dbo.Books.ProductID
GO
/****** Object:  Table [dbo].[Games]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Games](
	[ProductID] [smallint] NOT NULL,
	[PEGI] [smallint] NOT NULL,
	[Platform] [varchar](50) NOT NULL,
	[DubbingLanguage] [text] NOT NULL,
	[SubtitleLanguage] [text] NOT NULL,
	[Singleplayer] [varchar](5) NOT NULL,
	[Multiplayer] [varchar](5) NOT NULL,
	[GameID] [smallint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[GamesTableView]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[GamesTableView]
AS
SELECT        dbo.Products.ProductID, dbo.Games.GameID, dbo.Products.Title, dbo.Products.Author, dbo.Products.Publisher, dbo.Products.Genre, dbo.Products.ReleaseDate, dbo.Products.AddedDate, dbo.Products.Price, dbo.Products.Rating, 
                         dbo.Products.SoldQuantity, dbo.Games.PEGI, dbo.Games.Platform, dbo.Games.DubbingLanguage, dbo.Games.SubtitleLanguage, dbo.Games.Singleplayer, dbo.Games.Multiplayer
FROM            dbo.Games INNER JOIN
                         dbo.Products ON dbo.Games.ProductID = dbo.Products.ProductID
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Gender] [varchar](20) NOT NULL,
	[PhoneNumber] [varchar](9) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[ClientID] [smallint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[ClientID] [smallint] NOT NULL,
	[ProductID] [smallint] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[DeliveryDate] [date] NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[OrderID] [smallint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Books] ON 

INSERT [dbo].[Books] ([ProductID], [Pages], [OriginalLanguage], [ReleaseLanguage], [ISBN], [BookID]) VALUES (1, 504, N'English', N'English', N'2239768327535', 1)
INSERT [dbo].[Books] ([ProductID], [Pages], [OriginalLanguage], [ReleaseLanguage], [ISBN], [BookID]) VALUES (3, 368, N'English', N'English', N'2265571411290', 3)
INSERT [dbo].[Books] ([ProductID], [Pages], [OriginalLanguage], [ReleaseLanguage], [ISBN], [BookID]) VALUES (2, 439, N'English', N'English', N'2265566096445', 2)
INSERT [dbo].[Books] ([ProductID], [Pages], [OriginalLanguage], [ReleaseLanguage], [ISBN], [BookID]) VALUES (4, 368, N'English', N'Polish', N'8241239542304', 4)
SET IDENTITY_INSERT [dbo].[Books] OFF
GO
SET IDENTITY_INSERT [dbo].[Clients] ON 

INSERT [dbo].[Clients] ([Name], [Surname], [DateOfBirth], [Gender], [PhoneNumber], [Email], [ClientID]) VALUES (N'Jan', N'Kowalski', CAST(N'1989-12-11' AS Date), N'Male', N'732932123', N'jank@gmail.com', 1)
INSERT [dbo].[Clients] ([Name], [Surname], [DateOfBirth], [Gender], [PhoneNumber], [Email], [ClientID]) VALUES (N'Edward', N'Wysocki', CAST(N'1976-02-03' AS Date), N'Male', N'913123430', N'edward.wys@gmail.com', 2)
INSERT [dbo].[Clients] ([Name], [Surname], [DateOfBirth], [Gender], [PhoneNumber], [Email], [ClientID]) VALUES (N'Katarzyna', N'Nowak', CAST(N'2000-10-15' AS Date), N'Female', N'765123930', N'kasia2000@gmail.com', 3)
INSERT [dbo].[Clients] ([Name], [Surname], [DateOfBirth], [Gender], [PhoneNumber], [Email], [ClientID]) VALUES (N'Henryk', N'Gniewczynski', CAST(N'1999-09-09' AS Date), N'Male', N'832012394', N'henio123@o2.pl', 4)
INSERT [dbo].[Clients] ([Name], [Surname], [DateOfBirth], [Gender], [PhoneNumber], [Email], [ClientID]) VALUES (N'Antoni', N'Kowalski', CAST(N'1983-02-20' AS Date), N'Male', N'382328410', N'antek0321@gmail.com', 5)
INSERT [dbo].[Clients] ([Name], [Surname], [DateOfBirth], [Gender], [PhoneNumber], [Email], [ClientID]) VALUES (N'Zofia', N'Boska', CAST(N'1986-03-30' AS Date), N'Female', N'890129320', N'zosiabos@gmail.com', 6)
SET IDENTITY_INSERT [dbo].[Clients] OFF
GO
SET IDENTITY_INSERT [dbo].[Games] ON 

INSERT [dbo].[Games] ([ProductID], [PEGI], [Platform], [DubbingLanguage], [SubtitleLanguage], [Singleplayer], [Multiplayer], [GameID]) VALUES (5, 18, N'PC', N'English,Polish', N'English,Polish,Germany', N'True', N'False', 1)
INSERT [dbo].[Games] ([ProductID], [PEGI], [Platform], [DubbingLanguage], [SubtitleLanguage], [Singleplayer], [Multiplayer], [GameID]) VALUES (6, 18, N'PS4', N'English,Polish', N'English, Polish', N'True', N'False', 2)
INSERT [dbo].[Games] ([ProductID], [PEGI], [Platform], [DubbingLanguage], [SubtitleLanguage], [Singleplayer], [Multiplayer], [GameID]) VALUES (7, 18, N'PC', N'English,Polish', N'English, Polish', N'True', N'False', 3)
SET IDENTITY_INSERT [dbo].[Games] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([ClientID], [ProductID], [OrderDate], [DeliveryDate], [Status], [OrderID]) VALUES (2, 3, CAST(N'2022-01-10' AS Date), CAST(N'2022-01-13' AS Date), N'Delivered', 1)
INSERT [dbo].[Orders] ([ClientID], [ProductID], [OrderDate], [DeliveryDate], [Status], [OrderID]) VALUES (4, 1, CAST(N'2021-12-10' AS Date), CAST(N'2021-12-12' AS Date), N'Delivered', 2)
INSERT [dbo].[Orders] ([ClientID], [ProductID], [OrderDate], [DeliveryDate], [Status], [OrderID]) VALUES (5, 3, CAST(N'2022-01-10' AS Date), CAST(N'2022-01-13' AS Date), N'Delivered', 5)
INSERT [dbo].[Orders] ([ClientID], [ProductID], [OrderDate], [DeliveryDate], [Status], [OrderID]) VALUES (2, 6, CAST(N'2022-01-25' AS Date), CAST(N'2022-01-26' AS Date), N'Delivered', 8)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Title], [Author], [Publisher], [Genre], [ReleaseDate], [AddedDate], [Price], [Rating], [SoldQuantity], [ProductID]) VALUES (N'The Lord of the Rings: The Fellowship of the Ring', N'J. R. R. Tolkien', N'George Allen & Unwin', N'Fantasy', CAST(N'1954-07-29' AS Date), CAST(N'2022-05-24' AS Date), 30.05, 8.4, 1004, 1)
INSERT [dbo].[Products] ([Title], [Author], [Publisher], [Genre], [ReleaseDate], [AddedDate], [Price], [Rating], [SoldQuantity], [ProductID]) VALUES (N'The Lord of the Rings: The Return of the King', N'J. R. R. Tolkien', N'George Allen & Unwin', N'Fantasy', CAST(N'1955-10-20' AS Date), CAST(N'2022-05-24' AS Date), 36.8, 8.6, 765, 3)
INSERT [dbo].[Products] ([Title], [Author], [Publisher], [Genre], [ReleaseDate], [AddedDate], [Price], [Rating], [SoldQuantity], [ProductID]) VALUES (N'Stary człowiek i morze', N'Hemingway Ernest', N'Wydawnictwo Marginesy', N'Story', CAST(N'1952-01-01' AS Date), CAST(N'2022-06-11' AS Date), 39.9, 6.2, 247, 4)
INSERT [dbo].[Products] ([Title], [Author], [Publisher], [Genre], [ReleaseDate], [AddedDate], [Price], [Rating], [SoldQuantity], [ProductID]) VALUES (N'The Witcher 3: Wild Hunt', N'CD Projekt RED', N'cdp.pl', N'RPG', CAST(N'2015-05-19' AS Date), CAST(N'2022-05-24' AS Date), 72.93, 9.6, 7453, 5)
INSERT [dbo].[Products] ([Title], [Author], [Publisher], [Genre], [ReleaseDate], [AddedDate], [Price], [Rating], [SoldQuantity], [ProductID]) VALUES (N'The Last of Us: Part II', N'Naughty Dog', N'Sony Computer Entertainment', N'Survival horror', CAST(N'2020-06-19' AS Date), CAST(N'2022-05-24' AS Date), 149.99, 8.5, 3458, 6)
INSERT [dbo].[Products] ([Title], [Author], [Publisher], [Genre], [ReleaseDate], [AddedDate], [Price], [Rating], [SoldQuantity], [ProductID]) VALUES (N'Cyberpunk 2077', N'CD Projekt Red', N'CD Projekt Red', N'Action,Crime,Drama,Sci-Fi,Thriller', CAST(N'2020-12-10' AS Date), CAST(N'2022-05-24' AS Date), 119.99, 8, 6721, 7)
INSERT [dbo].[Products] ([Title], [Author], [Publisher], [Genre], [ReleaseDate], [AddedDate], [Price], [Rating], [SoldQuantity], [ProductID]) VALUES (N'The Lord of the Rings: The Two Towers', N'J. R. R. Tolkien', N'George Allen & Unwin', N'Fantasy', CAST(N'1954-11-11' AS Date), CAST(N'2022-05-24' AS Date), 30.05, 8.5, 934, 2)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_BP] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_BP]
GO
ALTER TABLE [dbo].[Games]  WITH CHECK ADD  CONSTRAINT [FK_GP] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Games] CHECK CONSTRAINT [FK_GP]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_OC] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_OC]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_OP] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_OP]
GO
/****** Object:  StoredProcedure [dbo].[DeleteBook]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteBook]
@ProductID SMALLINT
AS
BEGIN
DELETE FROM Books
WHERE ProductID = @ProductID
DELETE FROM Products
WHERE ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteClient]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteClient] (@ClientID INT)
AS
BEGIN
    DELETE FROM Clients
    WHERE ClientID = @ClientID
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteGame]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteGame] (@ProductID smallint)
AS
BEGIN
    DELETE FROM Products
    WHERE ProductID = @ProductID

    DELETE FROM Games
    WHERE ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteOrder]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteOrder] (@OrderID smallint)
AS
BEGIN
DELETE FROM Orders
WHERE OrderID = @OrderID
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteProduct]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteProduct]
@ProductID SMALLINT
AS
BEGIN
DELETE FROM Books
WHERE ProductID = @ProductID
DELETE FROM Games
WHERE ProductID = @ProductID
DELETE FROM Products
WHERE ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[InsertIntoBooks]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertIntoBooks]
    @Pages smallint,
    @OriginalLanguage varchar(30),
    @ReleaseLanguage varchar(30),
    @ISBN varchar(13),
    @Title varchar(70),
    @Author varchar(70),
    @Publisher varchar(70),
    @Genre text,
    @ReleaseDate date,
    @AddedDate date,
    @Price float,
    @Rating float,
    @SoldQuantity smallint
AS
BEGIN
    INSERT INTO Products (Title, Author, Publisher, Genre, ReleaseDate, AddedDate, Price, Rating, SoldQuantity)
    VALUES (@Title, @Author, @Publisher, @Genre, @ReleaseDate, @AddedDate, @Price, @Rating, @SoldQuantity)

    DECLARE @ProductID smallint
    SET @ProductID = SCOPE_IDENTITY()

    INSERT INTO Books (ProductID, Pages, OriginalLanguage, ReleaseLanguage, ISBN)
    VALUES (@ProductID, @Pages, @OriginalLanguage, @ReleaseLanguage, @ISBN)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertIntoClients]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertIntoClients]
(
	@Name varchar(50),
	@Surname varchar(50),
	@DateOfBirth date,
	@Gender varchar(20),
	@PhoneNumber varchar(9),
	@Email varchar(50)
)
AS
BEGIN
	INSERT INTO Clients (Name, Surname, DateOfBirth, Gender, PhoneNumber, Email)
	VALUES (@Name, @Surname, @DateOfBirth, @Gender, @PhoneNumber, @Email)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertIntoGames]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertIntoGames]
@Title VARCHAR(70),
@Author VARCHAR(70),
@Publisher VARCHAR(70),
@Genre TEXT,
@ReleaseDate DATE,
@AddedDate DATE,
@Price FLOAT,
@Rating FLOAT,
@SoldQuantity SMALLINT,
@PEGI SMALLINT,
@Platform VARCHAR(50),
@DubbingLanguage TEXT,
@SubtitleLanguage TEXT,
@Singleplayer VARCHAR(5),
@Multiplayer VARCHAR(5)
AS
BEGIN
DECLARE @ProductID SMALLINT
INSERT INTO Products (Title, Author, Publisher, Genre, ReleaseDate, AddedDate, Price, Rating, SoldQuantity)
VALUES (@Title, @Author, @Publisher, @Genre, @ReleaseDate, @AddedDate, @Price, @Rating, @SoldQuantity)
SET @ProductID = SCOPE_IDENTITY()
INSERT INTO Games (ProductID, PEGI, Platform, DubbingLanguage, SubtitleLanguage, Singleplayer, Multiplayer)
VALUES (@ProductID, @PEGI, @Platform, @DubbingLanguage, @SubtitleLanguage, @Singleplayer, @Multiplayer)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertIntoOrders]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertIntoOrders]
@ClientID smallint,
@ProductID smallint,
@OrderDate date,
@DeliveryDate date,
@Status varchar(50)
AS
BEGIN
INSERT INTO Orders (ClientID, ProductID, OrderDate, DeliveryDate, Status)
VALUES (@ClientID, @ProductID, @OrderDate, @DeliveryDate, @Status)
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateBookByProductID]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBookByProductID] (
	@ProductID smallint, 
	@Title varchar(70), 
	@Author varchar(70), 
	@Publisher varchar(70), 
	@Genre text, 
	@ReleaseDate date, 
	@AddedDate date, 
	@Price float, 
	@Rating float, 
	@SoldQuantity smallint, 
	@Pages smallint, 
	@OriginalLanguage varchar(30), 
	@ReleaseLanguage varchar(30), 
	@ISBN varchar(13)
)
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION
    UPDATE Products
    SET Title = @Title, Author = @Author, Publisher = @Publisher, Genre = @Genre, ReleaseDate = @ReleaseDate, AddedDate = @AddedDate, Price = @Price, Rating = @Rating, SoldQuantity = @SoldQuantity
    WHERE ProductID = @ProductID
    UPDATE Books
    SET Pages = @Pages, OriginalLanguage = @OriginalLanguage, ReleaseLanguage = @ReleaseLanguage, ISBN = @ISBN
    WHERE ProductID = @ProductID
    COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION
    RAISERROR ('Error updating the product and book', 16, 1)
  END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateClientByID]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateClientByID]
    @ClientID smallint,
    @Name varchar(50) = NULL,
    @Surname varchar(50) = NULL,
    @DateOfBirth date = NULL,
    @Gender varchar(20) = NULL,
    @PhoneNumber varchar(9) = NULL,
    @Email varchar(50) = NULL
AS
BEGIN
    UPDATE Clients
    SET Name = COALESCE(@Name, Name),
        Surname = COALESCE(@Surname, Surname),
        DateOfBirth = COALESCE(@DateOfBirth, DateOfBirth),
        Gender = COALESCE(@Gender, Gender),
        PhoneNumber = COALESCE(@PhoneNumber, PhoneNumber),
        Email = COALESCE(@Email, Email)
    WHERE ClientID = @ClientID
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateGameByProductID]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateGameByProductID] (
	@ProductID SMALLINT, 
	@Title VARCHAR(70), 
	@Author VARCHAR(70), 
	@Publisher VARCHAR(70), 
	@Genre TEXT, 
	@ReleaseDate DATE, 
	@AddedDate DATE, 
	@Price FLOAT, 
	@Rating FLOAT, 
	@SoldQuantity SMALLINT, 
	@PEGI SMALLINT, 
	@Platform VARCHAR(50), 
	@DubbingLanguage TEXT, 
	@SubtitleLanguage TEXT, 
	@Singleplayer VARCHAR(5), 
	@Multiplayer VARCHAR(5)
)
AS
BEGIN
UPDATE Products
SET Title = @Title, Author = @Author, Publisher = @Publisher, Genre = @Genre, ReleaseDate = @ReleaseDate, AddedDate = @AddedDate, Price = @Price, Rating = @Rating, SoldQuantity = @SoldQuantity
WHERE ProductID = @ProductID;
UPDATE Games
SET PEGI = @PEGI, Platform = @Platform, DubbingLanguage = @DubbingLanguage, SubtitleLanguage = @SubtitleLanguage, Singleplayer = @Singleplayer, Multiplayer = @Multiplayer
WHERE ProductID = @ProductID;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderByID]    Script Date: 29.01.2023 15:17:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOrderByID] (@OrderID smallint, @ClientID smallint, @ProductID smallint, @OrderDate date, @DeliveryDate date, @Status varchar(50))
AS
BEGIN
UPDATE Orders
SET ClientID = @ClientID, ProductID = @ProductID, OrderDate = @OrderDate, DeliveryDate = @DeliveryDate, Status = @Status
WHERE OrderID = @OrderID;
END;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "Books"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 429
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BooksTableView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BooksTableView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Games"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 263
               Bottom = 136
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 6
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1995
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GamesTableView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GamesTableView'
GO
USE [master]
GO
ALTER DATABASE [Bookstore] SET  READ_WRITE 
GO
