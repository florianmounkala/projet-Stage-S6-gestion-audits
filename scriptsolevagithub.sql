USE [master]
GO
/****** Object:  Database [soleva]    Script Date: 05/09/2024 12:40:33 ******/
CREATE DATABASE [soleva]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'soleva', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\soleva.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'soleva_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\soleva_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [soleva] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [soleva].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [soleva] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [soleva] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [soleva] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [soleva] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [soleva] SET ARITHABORT OFF 
GO
ALTER DATABASE [soleva] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [soleva] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [soleva] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [soleva] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [soleva] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [soleva] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [soleva] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [soleva] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [soleva] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [soleva] SET  DISABLE_BROKER 
GO
ALTER DATABASE [soleva] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [soleva] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [soleva] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [soleva] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [soleva] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [soleva] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [soleva] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [soleva] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [soleva] SET  MULTI_USER 
GO
ALTER DATABASE [soleva] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [soleva] SET DB_CHAINING OFF 
GO
ALTER DATABASE [soleva] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [soleva] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [soleva] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [soleva] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [soleva] SET QUERY_STORE = OFF
GO
USE [soleva]
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AnswerText] [varchar](max) NULL,
	[Rating] [int] NULL,
	[QuestionId] [int] NULL,
	[AuditId] [int] NULL,
 CONSTRAINT [PK_Answer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Criteria] [varchar](10) NOT NULL,
	[Label] [varchar](max) NOT NULL,
	[Visible] [bit] NOT NULL,
	[ThemeId] [int] NOT NULL,
	[TargetId] [int] NOT NULL,
	[RequiredLevelId] [int] NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwQuestionAnswer]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwQuestionAnswer]
AS
SELECT q.Label, a.AnswerText, a.Rating, a.AuditId
FROM     dbo.Answer AS a INNER JOIN
                  dbo.Question AS q ON a.QuestionId = q.Id
GO
/****** Object:  Table [dbo].[Attachment]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attachment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [int] NOT NULL,
	[AuditId] [int] NOT NULL,
 CONSTRAINT [PK_Attachment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Audit]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[SubmittedDate] [datetime] NULL,
	[ClientId] [int] NOT NULL,
 CONSTRAINT [PK_Audit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditQuestion]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditQuestion](
	[QuestionId] [int] NOT NULL,
	[AuditId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_AuditQuestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Phone] [varchar](max) NULL,
	[Email] [varchar](max) NULL,
	[Adress] [varchar](max) NULL,
	[City] [varchar](max) NULL,
	[Country] [varchar](max) NULL,
	[Name] [varchar](max) NOT NULL,
	[ContactName] [varchar](max) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Goal]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Goal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Goal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequiredLevel]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequiredLevel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](50) NOT NULL,
 CONSTRAINT [PK_RequiredLevel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Target]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Target](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Target] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Theme]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Theme](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Theme] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](254) NULL,
	[LastName] [varchar](250) NULL,
	[Email] [varchar](250) NOT NULL,
	[Phone] [varchar](50) NULL,
	[UserGroupId] [int] NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Pseudo] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAudit]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAudit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuditId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_UserAudit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGroupe]    Script Date: 05/09/2024 12:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGroupe](
	[Id] [int] NOT NULL,
	[Name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_UserGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_Visible]  DEFAULT ((1)) FOR [Visible]
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Audit] FOREIGN KEY([AuditId])
REFERENCES [dbo].[Audit] ([Id])
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Audit]
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([Id])
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Question]
GO
ALTER TABLE [dbo].[Attachment]  WITH CHECK ADD  CONSTRAINT [FK_Attachment_Audit] FOREIGN KEY([AuditId])
REFERENCES [dbo].[Audit] ([Id])
GO
ALTER TABLE [dbo].[Attachment] CHECK CONSTRAINT [FK_Attachment_Audit]
GO
ALTER TABLE [dbo].[Audit]  WITH CHECK ADD  CONSTRAINT [FK_Audit_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[Audit] CHECK CONSTRAINT [FK_Audit_Client]
GO
ALTER TABLE [dbo].[AuditQuestion]  WITH CHECK ADD  CONSTRAINT [FK_AuditQuestion_Audit] FOREIGN KEY([AuditId])
REFERENCES [dbo].[Audit] ([Id])
GO
ALTER TABLE [dbo].[AuditQuestion] CHECK CONSTRAINT [FK_AuditQuestion_Audit]
GO
ALTER TABLE [dbo].[AuditQuestion]  WITH CHECK ADD  CONSTRAINT [FK_AuditQuestion_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([Id])
GO
ALTER TABLE [dbo].[AuditQuestion] CHECK CONSTRAINT [FK_AuditQuestion_Question]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_RequiredLevel] FOREIGN KEY([RequiredLevelId])
REFERENCES [dbo].[RequiredLevel] ([Id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_RequiredLevel]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Target] FOREIGN KEY([TargetId])
REFERENCES [dbo].[Target] ([Id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Target]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Theme] FOREIGN KEY([ThemeId])
REFERENCES [dbo].[Theme] ([Id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Theme]
GO
ALTER TABLE [dbo].[UserAudit]  WITH CHECK ADD  CONSTRAINT [FK_UserAudit_Audit] FOREIGN KEY([AuditId])
REFERENCES [dbo].[Audit] ([Id])
GO
ALTER TABLE [dbo].[UserAudit] CHECK CONSTRAINT [FK_UserAudit_Audit]
GO
ALTER TABLE [dbo].[UserAudit]  WITH CHECK ADD  CONSTRAINT [FK_UserAudit_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[UserAudit] CHECK CONSTRAINT [FK_UserAudit_User]
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
         Begin Table = "q"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 7
               Left = 298
               Bottom = 170
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
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
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwQuestionAnswer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwQuestionAnswer'
GO
USE [master]
GO
ALTER DATABASE [soleva] SET  READ_WRITE 
GO
