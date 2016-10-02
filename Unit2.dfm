object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1074#1086#1076' '#1082#1072#1087#1095#1080
  ClientHeight = 103
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 300
    Height = 57
    AutoSize = True
    Stretch = True
  end
  object Label1: TLabel
    Left = 8
    Top = 76
    Width = 69
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1076':'
  end
  object Memo1: TMemo
    Left = 8
    Top = 168
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    Visible = False
  end
  object Memo2: TMemo
    Left = 8
    Top = 280
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo2')
    TabOrder = 1
    Visible = False
  end
  object Edit1: TEdit
    Left = 83
    Top = 73
    Width = 118
    Height = 21
    TabOrder = 2
    OnChange = Edit1Change
  end
  object Button1: TButton
    Left = 207
    Top = 71
    Width = 101
    Height = 25
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 384
    Top = 136
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 400
    Top = 264
  end
end
