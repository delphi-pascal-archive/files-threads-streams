object Form1: TForm1
  Left = 231
  Top = 130
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1060#1072#1081#1083#1099', '#1087#1086#1090#1086#1082#1080
  ClientHeight = 465
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 608
    Top = 16
    Width = 76
    Height = 16
    Caption = #1042#1080#1076' '#1089#1087#1080#1089#1082#1072':'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 473
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1088' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103' '#1092#1072#1081#1083#1086#1074' (TFileStream) '#1074' '#1087#1086#1090#1086#1082#1077' (TThread)'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 40
    Width = 473
    Height = 25
    Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1081' '#1089' '#1087#1086#1076#1076#1080#1088#1077#1082#1090#1086#1088#1080#1103#1084#1080
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 72
    Width = 473
    Height = 25
    Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1086#1074' '#1089#1086' '#1089#1090#1072#1085#1076#1072#1088#1090#1085#1099#1084' '#1076#1080#1072#1083#1086#1075#1086#1074#1099#1084' '#1086#1082#1086#1096#1082#1086#1084
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 104
    Width = 473
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1102', '#1089#1086#1076#1077#1088#1078#1072#1097#1091#1102' '#1092#1072#1081#1083#1099' '#1080' '#1087#1086#1076#1076#1080#1088#1077#1082#1090#1086#1088#1080#1080' '
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 200
    Width = 473
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1088' 1 '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' TFileStream '#1076#1083#1103' '#1095#1090#1077#1085#1080#1103' '#1092#1072#1081#1083#1086#1074
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 136
    Width = 473
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1080' '#1079#1072' 1 '#1087#1088#1086#1093#1086#1076
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 168
    Width = 473
    Height = 25
    TabOrder = 6
    OnClick = Button7Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 264
    Width = 473
    Height = 161
    ScrollBars = ssBoth
    TabOrder = 7
  end
  object Button8: TButton
    Left = 8
    Top = 232
    Width = 473
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1088' 2 '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' TFileStream '#1076#1083#1103' '#1095#1090#1077#1085#1080#1103' '#1092#1072#1081#1083#1086#1074
    TabOrder = 8
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 8
    Top = 432
    Width = 473
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1088#1099' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1092#1091#1085#1082#1094#1080#1080' SHFileOperation'
    TabOrder = 9
    OnClick = Button9Click
  end
  object ListView1: TListView
    Left = 488
    Top = 200
    Width = 297
    Height = 257
    Columns = <>
    GridLines = True
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    RowSelect = True
    TabOrder = 10
    ViewStyle = vsReport
  end
  object ComboBox1: TComboBox
    Left = 704
    Top = 8
    Width = 81
    Height = 24
    ItemHeight = 16
    TabOrder = 11
    Text = 'Table'
    OnClick = ComboBox1Click
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 488
    Top = 40
    Width = 297
    Height = 153
    ItemHeight = 16
    TabOrder = 12
    OnChange = DirectoryListBox1Change
  end
  object DriveComboBox1: TDriveComboBox
    Left = 488
    Top = 8
    Width = 105
    Height = 22
    TabOrder = 13
  end
end
