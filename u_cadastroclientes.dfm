object f_cadastroclientes: Tf_cadastroclientes
  Left = 578
  Top = 173
  Width = 675
  Height = 372
  Caption = 'Cadastro de clientes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pg_cadastro: TPageControl
    Left = 0
    Top = 0
    Width = 667
    Height = 341
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Listagem'
      object grid: TDBGrid
        Left = 0
        Top = 64
        Width = 659
        Height = 249
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = ds_grid
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = gridDblClick
      end
      object btnInserir: TBitBtn
        Left = 32
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Inserir'
        TabOrder = 1
        OnClick = btnInserirClick
      end
      object btnAlterar: TBitBtn
        Left = 136
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Alterar'
        TabOrder = 2
        OnClick = btnAlterarClick
      end
      object btnExcluir: TBitBtn
        Left = 248
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Excluir'
        TabOrder = 3
        OnClick = btnExcluirClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object Label1: TLabel
        Left = 24
        Top = 8
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Nome: TLabeledEdit
        Left = 80
        Top = 24
        Width = 241
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        TabOrder = 0
      end
      object cpf: TLabeledEdit
        Left = 24
        Top = 69
        Width = 137
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'CPF'
        TabOrder = 1
      end
      object telefone: TLabeledEdit
        Left = 168
        Top = 69
        Width = 153
        Height = 21
        EditLabel.Width = 42
        EditLabel.Height = 13
        EditLabel.Caption = 'Telefone'
        TabOrder = 2
      end
      object numero: TLabeledEdit
        Left = 272
        Top = 112
        Width = 49
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero'
        TabOrder = 4
      end
      object endereco: TLabeledEdit
        Left = 24
        Top = 112
        Width = 241
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        TabOrder = 3
      end
      object bairro: TLabeledEdit
        Left = 24
        Top = 157
        Width = 137
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        TabOrder = 5
      end
      object Complemento: TLabeledEdit
        Left = 168
        Top = 157
        Width = 153
        Height = 21
        EditLabel.Width = 64
        EditLabel.Height = 13
        EditLabel.Caption = 'Complemento'
        TabOrder = 6
      end
      object cep: TLabeledEdit
        Left = 24
        Top = 205
        Width = 137
        Height = 21
        EditLabel.Width = 21
        EditLabel.Height = 13
        EditLabel.Caption = 'CEP'
        TabOrder = 7
      end
      object cidade: TLabeledEdit
        Left = 168
        Top = 205
        Width = 153
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        TabOrder = 8
      end
      object btn_salvar: TBitBtn
        Left = 24
        Top = 264
        Width = 75
        Height = 25
        Caption = 'Salvar'
        TabOrder = 9
        OnClick = btn_salvarClick
      end
      object codigo: TEdit
        Left = 24
        Top = 24
        Width = 46
        Height = 21
        Enabled = False
        TabOrder = 10
        Text = '0'
      end
    end
  end
  object Conn: TZConnection
    ControlsCodePage = cGET_ACP
    AutoEncodeStrings = False
    HostName = 'localhost'
    Port = 0
    Database = 'macro'
    User = 'postgres'
    Password = '123'
    Protocol = 'postgresql-9'
    Left = 388
    Top = 24
  end
  object qry: TZQuery
    Connection = Conn
    Params = <>
    Left = 396
    Top = 80
  end
  object qry_grid: TZQuery
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
    Params = <>
    Left = 252
    Top = 104
  end
  object ds_grid: TDataSource
    DataSet = qry_grid
    Left = 180
    Top = 88
  end
end
