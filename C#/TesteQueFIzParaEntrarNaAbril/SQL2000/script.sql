if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Cart_Product]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Cart] DROP CONSTRAINT FK_Cart_Product
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Cart_User]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Cart] DROP CONSTRAINT FK_Cart_User
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DelCart]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_DelCart]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DelProduct]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_DelProduct]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_DelUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_DelUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_GetCart]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_GetCart]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_GetProduct]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_GetProduct]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_GetUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_GetUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_SaveCart]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_SaveCart]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_SaveProduct]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_SaveProduct]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_SaveUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_SaveUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Cart]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Cart]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Product]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Product]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[User]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[User]
GO

CREATE TABLE [dbo].[Cart] (
	[CartId] [bigint] IDENTITY (1, 1) NOT NULL ,
	[UserId] [bigint] NOT NULL ,
	[ProductId] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Product] (
	[ProductId] [int] IDENTITY (1, 1) NOT NULL ,
	[Description] [varchar] (255) COLLATE Latin1_General_CI_AS NULL ,
	[Category] [tinyint] NOT NULL ,
	[Price] [float] NOT NULL ,
	[CreationDate] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[User] (
	[UserId] [bigint] IDENTITY (1, 1) NOT NULL ,
	[Name] [varchar] (80) COLLATE Latin1_General_CI_AS NOT NULL ,
	[Description] [varchar] (255) COLLATE Latin1_General_CI_AS NULL ,
	[Theme] [varchar] (30) COLLATE Latin1_General_CI_AS NOT NULL ,
	[CreationDate] [datetime] NOT NULL 
) ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc [dbo].[usp_DelCart]
@CartId bigint = null,
@ProductId int = null,
@UserId bigint = null
as
set nocount on
delete from Cart 
where Cartid = isNull(@CartId, [CartId]) and 
UserId = isNull(@UserId, [UserId]) and 
ProductId = isNull(@ProductId, [ProductId])
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc [dbo].[usp_DelProduct]
@ProductId int = null
as
set nocount on
delete from Product 
where ProductId = isNull(@ProductId, ProductId)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc [dbo].[usp_DelUser]
@UserId bigint = null
as
set nocount on
delete from [User] 
where UserId = isNull(@UserId, UserId)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc [dbo].[usp_GetCart]
@CartId bigint = null,
@ProductId int = null,
@UserId bigint = null
as
set nocount on
select cartId, userId, productId from Cart 
where Cartid = isNull(@CartId, [CartId]) and 
UserId = isNull(@UserId, [UserId]) and 
ProductId = isNull(@ProductId, [ProductId])
order by cartId desc
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc [dbo].[usp_GetProduct]
@ProductId int = null,
@Description varchar(255)  = null,
@Category tinyint = null
as
set nocount on
if(@Description is null) set @Description = ''

select ProductId, Description, Category, Price, CreationDate  
from Product 
where Productid = isNull(@ProductId, ProductId) and 
Description like '%' + @Description + '%' and 
Category = isNull(@Category, Category)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc [dbo].[usp_GetUser]
@UserId bigint = null,
@Name varchar(80)  = null,
@Description varchar(255)  = null,
@Theme varchar(30)  = null
as
set nocount on
select UserId, Name, Description, Theme, CreationDate from [User]
where UserId = isNull(@UserId, UserId) and 
Name = isNull(@Name, Name) and 
(Description = @Description or @Description is null) and 
Theme = isNull(@Theme, Theme)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc [dbo].[usp_SaveCart]
@CartId bigint = null,
@ProductId int = null,
@UserId bigint = null
as
set nocount on
if(not exists(select 1 from Cart where UserId = @UserId and ProductId = @ProductId))
	insert into Cart (UserId, ProductId) 
	values (@UserId, @ProductId)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc [dbo].[usp_SaveProduct]
@ProductId int = null,
@Description varchar(255)  = null,
@Category tinyint = null,
@Price float = null
as
set nocount on
if( @ProductId is null or @ProductId = 0 )
begin
	insert into Product (Description, Category, Price) 
	values (@Description, @Category, @Price) 
	select SCOPE_IDENTITY() as 'identity'
end
else 
begin
	update Product set 
	Description = @Description, 
	Category = @Category, 
	Price = @Price
	Where ProductId = @ProductId 
	select @ProductId
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc [dbo].[usp_SaveUser]
@UserId bigint = null,
@Name varchar(80)  = null,
@Description varchar(255)  = null,
@Theme varchar(30)  = null
as
set nocount on
if( @UserId is null or @UserId = 0 )
begin
	insert into [User] (Name, Description, Theme) 
	values (@Name, @Description, @Theme) 
	select SCOPE_IDENTITY() as 'identity'
end
else 
begin
	update [User] set Name = @Name, 
	Description = @Description, 
	Theme = @Theme
	Where UserId = @UserId 
	select @UserId
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

