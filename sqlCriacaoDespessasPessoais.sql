--USE [DespesasPessoais]
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 11/04/2019 14:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[idTipo] [int] NULL,
	[descricao] [varchar](20) NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Despesa]    Script Date: 11/04/2019 14:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Despesa](
	[idDespesa] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[data] [date] NULL,
	[idCategoria] [int] NULL,
	[dataVencimento] [date] NULL,
	[descrcao] [varchar](100) NULL,
	[valor] [money] NULL,
 CONSTRAINT [PK_Despesa] PRIMARY KEY CLUSTERED 
(
	[idDespesa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LancamentoConsolidado]    Script Date: 11/04/2019 14:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LancamentoConsolidado](
	[idLancamento] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[idDespesa] [int] NULL,
	[idReceita] [int] NULL,
	[mes] [int] NULL,
	[ano] [int] NULL,
	[valor] [money] NULL,
	[dataLancamento] [date] NULL,
 CONSTRAINT [PK_LancamentoConsolidado] PRIMARY KEY CLUSTERED 
(
	[idLancamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Receita]    Script Date: 11/04/2019 14:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Receita](
	[idReceita] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NULL,
	[idCategoria] [int] NULL,
	[data] [date] NULL,
	[descricao] [varchar](100) NULL,
	[valor] [money] NULL,
 CONSTRAINT [PK_Receita] PRIMARY KEY CLUSTERED 
(
	[idReceita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoCategoria]    Script Date: 11/04/2019 14:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCategoria](
	[idTipoCategoria] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [varchar](8) NULL,
 CONSTRAINT [PK_TipoCategoria] PRIMARY KEY CLUSTERED 
(
	[idTipoCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 11/04/2019 14:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nome] [char](90) NOT NULL,
	[email] [varchar](45) NOT NULL,
	[senha] [varchar](8) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categoria]  WITH CHECK ADD  CONSTRAINT [FK_Categoria_TipoCategoria] FOREIGN KEY([idTipo])
REFERENCES [dbo].[TipoCategoria] ([idTipoCategoria])
GO
ALTER TABLE [dbo].[Categoria] CHECK CONSTRAINT [FK_Categoria_TipoCategoria]
GO
ALTER TABLE [dbo].[Despesa]  WITH CHECK ADD  CONSTRAINT [FK_Despesa_Categoria] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categoria] ([idCategoria])
GO
ALTER TABLE [dbo].[Despesa] CHECK CONSTRAINT [FK_Despesa_Categoria]
GO
ALTER TABLE [dbo].[Despesa]  WITH CHECK ADD  CONSTRAINT [FK_Despesa_Usuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Despesa] CHECK CONSTRAINT [FK_Despesa_Usuario]
GO
ALTER TABLE [dbo].[LancamentoConsolidado]  WITH CHECK ADD  CONSTRAINT [FK_LancamentoConsolidado_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[LancamentoConsolidado] CHECK CONSTRAINT [FK_LancamentoConsolidado_Usuario]
GO
ALTER TABLE [dbo].[Receita]  WITH CHECK ADD  CONSTRAINT [FK_Receita_Categoria] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categoria] ([idCategoria])
GO
ALTER TABLE [dbo].[Receita] CHECK CONSTRAINT [FK_Receita_Categoria]
GO
ALTER TABLE [dbo].[Receita]  WITH CHECK ADD  CONSTRAINT [FK_Receita_Usuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Receita] CHECK CONSTRAINT [FK_Receita_Usuario]
GO
