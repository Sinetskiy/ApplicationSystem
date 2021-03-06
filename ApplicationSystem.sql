USE [master]
GO
/****** Object:  Database [ApplicationsSystem]    Script Date: 16.10.2016 3:16:15 ******/
CREATE DATABASE [ApplicationsSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ApplicationsSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ApplicationsSystem.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ApplicationsSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ApplicationsSystem_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ApplicationsSystem] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ApplicationsSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ApplicationsSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ApplicationsSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ApplicationsSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ApplicationsSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ApplicationsSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ApplicationsSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [ApplicationsSystem] SET  MULTI_USER 
GO
ALTER DATABASE [ApplicationsSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ApplicationsSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ApplicationsSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ApplicationsSystem] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ApplicationsSystem', N'ON'
GO
USE [ApplicationsSystem]
GO
/****** Object:  User [ApplicationUser]    Script Date: 16.10.2016 3:16:15 ******/
CREATE USER [ApplicationUser] FOR LOGIN [ApplicationUser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ApplicationUser]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [ApplicationUser]
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 16.10.2016 3:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_Applications_Id]  DEFAULT (newid()),
	[ClientName] [nvarchar](50) NULL,
	[ClientEmail] [nvarchar](50) NULL,
	[Text] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[Status] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 16.10.2016 3:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SystemUsers]    Script Date: 16.10.2016 3:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemUsers](
	[SystemUserId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK_SystemUsers] PRIMARY KEY CLUSTERED 
(
	[SystemUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SystemUsersRole]    Script Date: 16.10.2016 3:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemUsersRole](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SystemUserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SystemUsersRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_Id]  DEFAULT (newid()) FOR [RoleId]
GO
ALTER TABLE [dbo].[SystemUsers] ADD  CONSTRAINT [DF_SystemUsers_SystemUserId]  DEFAULT (newid()) FOR [SystemUserId]
GO
ALTER TABLE [dbo].[SystemUsersRole] ADD  CONSTRAINT [DF_SystemUsersRoles_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[SystemUsersRole] ADD  CONSTRAINT [DF_SystemUsersRoles_SystemUserId]  DEFAULT (newid()) FOR [SystemUserId]
GO
ALTER TABLE [dbo].[SystemUsersRole] ADD  CONSTRAINT [DF_SystemUsersRoles_RolesId]  DEFAULT (newid()) FOR [RoleId]
GO
ALTER TABLE [dbo].[SystemUsersRole]  WITH CHECK ADD  CONSTRAINT [FK_SystemUsersRoles_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[SystemUsersRole] CHECK CONSTRAINT [FK_SystemUsersRoles_Roles]
GO
ALTER TABLE [dbo].[SystemUsersRole]  WITH CHECK ADD  CONSTRAINT [FK_SystemUsersRoles_SystemUsers] FOREIGN KEY([SystemUserId])
REFERENCES [dbo].[SystemUsers] ([SystemUserId])
GO
ALTER TABLE [dbo].[SystemUsersRole] CHECK CONSTRAINT [FK_SystemUsersRoles_SystemUsers]
GO
USE [master]
GO
ALTER DATABASE [ApplicationsSystem] SET  READ_WRITE 
GO
