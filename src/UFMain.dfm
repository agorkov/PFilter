object FMain: TFMain
  Left = 0
  Top = 0
  Caption = #1043#1086#1088#1100#1082#1086#1074' '#1040'. - '#1060#1080#1083#1100#1090#1088#1072#1094#1080#1103
  ClientHeight = 497
  ClientWidth = 969
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF009999
    9999999999999999999999999999999999999999999999999999999999999900
    0000000000000000000000000099990000009999999999999999000000999900
    0000999999999999999900000099990000009999999999999999000000999900
    0000999999999999999900000099990000009999900000009999000000999900
    0000999990000000999900000099990000009999900000009999000000999900
    0000999990000000999900000099990000009999900099999999000000999900
    0000999990009999999900000099990000009999900099999999000000999900
    0000999990009999999900000099990000009999900099999999000000999900
    0000999990000000000000000099990000009999900000000000000000999900
    0000999990000000000000000099990000009999900000000000000000999900
    0000999990000000000000000099990000009999900000009999000000999900
    0000999990000000999900000099990000009999900000009999000000999900
    0000999990000000999900000099990000009999999999999999000000999900
    0000999999999999999900000099990000009999999999999999000000999900
    0000999999999999999900000099990000000000000000000000000000999999
    9999999999999999999999999999999999999999999999999999999999990000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCanResize = FormCanResize
  PixelsPerInch = 96
  TextHeight = 13
  object IIn: TImage
    Left = 8
    Top = 8
    Width = 345
    Height = 345
    Center = True
    Proportional = True
    Stretch = True
    OnDblClick = IInDblClick
  end
  object IOut: TImage
    Left = 615
    Top = 8
    Width = 345
    Height = 345
    Center = True
    ParentShowHint = False
    Proportional = True
    ShowHint = False
    Stretch = True
    OnDblClick = IOutDblClick
  end
  object LTime: TLabel
    Left = 8
    Top = 421
    Width = 102
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1080': '
  end
  object BFilter: TButton
    Left = 8
    Top = 359
    Width = 952
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1102
    TabOrder = 0
    OnClick = BFilterClick
  end
  object GBFilterParams: TGroupBox
    Left = 359
    Top = 8
    Width = 250
    Height = 74
    Caption = #1040#1087#1077#1088#1090#1091#1088#1072' '#1092#1080#1083#1100#1090#1088#1072
    TabOrder = 1
    object LEFilterN: TLabeledEdit
      Left = 11
      Top = 40
      Width = 30
      Height = 21
      EditLabel.Width = 35
      EditLabel.Height = 13
      EditLabel.Caption = #1057#1090#1088#1086#1082':'
      TabOrder = 0
      Text = '1'
      OnChange = LEFilterNChange
    end
    object UDFilterN: TUpDown
      Left = 41
      Top = 40
      Width = 16
      Height = 21
      Associate = LEFilterN
      Position = 1
      TabOrder = 1
    end
    object UDFilterM: TUpDown
      Left = 133
      Top = 40
      Width = 16
      Height = 21
      Associate = LEFilterM
      Position = 1
      TabOrder = 2
    end
    object LEFilterM: TLabeledEdit
      Left = 103
      Top = 40
      Width = 30
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = #1057#1090#1086#1083#1073#1094#1086#1074':'
      TabOrder = 3
      Text = '1'
      OnChange = LEFilterMChange
    end
    object LEFilterd: TLabeledEdit
      Left = 195
      Top = 40
      Width = 30
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = #1054#1090#1089#1077#1082#1072#1090#1100':'
      TabOrder = 4
      Text = '3'
      Visible = False
    end
    object UDFilterD: TUpDown
      Left = 225
      Top = 40
      Width = 16
      Height = 21
      Associate = LEFilterd
      Position = 3
      TabOrder = 5
      Visible = False
    end
    object CBAddToOriginal: TCheckBox
      Left = 171
      Top = 35
      Width = 70
      Height = 31
      Caption = #1055#1086#1074#1099#1089#1080#1090#1100' '#1088#1077#1079#1082#1086#1089#1090#1100
      TabOrder = 6
      Visible = False
      WordWrap = True
    end
  end
  object GBLinear: TGroupBox
    Left = 562
    Top = 390
    Width = 129
    Height = 99
    Caption = #1051#1080#1085#1077#1081#1085#1072#1103' '#1082#1086#1088#1088#1077#1082#1094#1080#1103':'
    TabOrder = 2
    object BLinear: TButton
      Left = 16
      Top = 59
      Width = 104
      Height = 25
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = BLinearClick
    end
    object LELinearK: TLabeledEdit
      Left = 16
      Top = 32
      Width = 33
      Height = 21
      EditLabel.Width = 9
      EditLabel.Height = 13
      EditLabel.Caption = 'k:'
      TabOrder = 1
      Text = '-1'
    end
    object LELinearb: TLabeledEdit
      Left = 71
      Top = 32
      Width = 33
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'b:'
      TabOrder = 2
      Text = '255'
    end
  end
  object RGFilterSelect: TRadioGroup
    Left = 359
    Top = 88
    Width = 250
    Height = 265
    Caption = #1042#1099#1073#1086#1088' '#1092#1080#1083#1100#1090#1088#1072':'
    ItemIndex = 0
    Items.Strings = (
      #1059#1089#1088#1077#1076#1085#1103#1102#1097#1080#1081' ('#1089#1088#1077#1076#1085#1077#1077' '#1072#1088#1080#1092#1084#1077#1090#1080#1095#1077#1089#1082#1086#1077')'
      #1059#1089#1088#1077#1076#1085#1103#1102#1097#1080#1081' ('#1074#1079#1074#1077#1096#1077#1085#1085#1072#1103' '#1089#1091#1084#1084#1072')'
      #1059#1089#1088#1077#1076#1085#1103#1102#1097#1080#1081' ('#1089#1088#1077#1076#1085#1077#1077' '#1075#1077#1086#1084#1077#1090#1088#1080#1095#1077#1089#1082#1086#1077')'
      #1055#1086#1088#1103#1076#1082#1086#1074#1099#1081' ('#1084#1077#1076#1080#1072#1085#1085#1099#1081')'
      #1055#1086#1088#1103#1076#1082#1086#1074#1099#1081' ('#1084#1072#1082#1089#1080#1084#1091#1084')'
      #1055#1086#1088#1103#1076#1082#1086#1074#1099#1081' ('#1084#1080#1085#1080#1084#1091#1084')'
      #1050#1086#1084#1073#1080#1085#1080#1088#1086#1074#1072#1085#1085#1099#1081' ('#1089#1088#1077#1076#1080#1085#1085#1072#1103' '#1090#1086#1095#1082#1072')'
      #1050#1086#1084#1073#1080#1085#1080#1088#1086#1074#1072#1085#1085#1099#1081' ('#1091#1089#1077#1095#1105#1085#1085#1086#1077' '#1089#1088#1077#1076#1085#1077#1077')'
      #1055#1088#1077#1074#1080#1090#1090
      #1057#1086#1073#1077#1083#1100
      #1065#1072#1088#1088
      #1051#1072#1087#1083#1072#1089#1080#1072#1085)
    TabOrder = 3
    OnClick = RGFilterSelectClick
  end
  object GBLog: TGroupBox
    Left = 697
    Top = 390
    Width = 129
    Height = 99
    Caption = #1051#1086#1075'. '#1082#1086#1088#1088#1077#1082#1094#1080#1103':'
    TabOrder = 4
    object BLog: TButton
      Left = 16
      Top = 59
      Width = 104
      Height = 25
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = BLogClick
    end
    object LELogC: TLabeledEdit
      Left = 48
      Top = 32
      Width = 33
      Height = 21
      EditLabel.Width = 9
      EditLabel.Height = 13
      EditLabel.Caption = 'c:'
      TabOrder = 1
      Text = '15'
    end
  end
  object GBGamma: TGroupBox
    Left = 832
    Top = 390
    Width = 129
    Height = 99
    Caption = #1043#1072#1084#1084#1072' '#1082#1086#1088#1088#1077#1082#1094#1080#1103
    TabOrder = 5
    object BGamma: TButton
      Left = 16
      Top = 59
      Width = 104
      Height = 25
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = BGammaClick
    end
    object LEGammaC: TLabeledEdit
      Left = 16
      Top = 32
      Width = 33
      Height = 21
      EditLabel.Width = 9
      EditLabel.Height = 13
      EditLabel.Caption = 'c:'
      TabOrder = 1
      Text = '1'
    end
    object LEGammaGamma: TLabeledEdit
      Left = 71
      Top = 32
      Width = 33
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = 'Gamma:'
      TabOrder = 2
      Text = '1,7'
    end
  end
  object BHist: TButton
    Left = 8
    Top = 390
    Width = 153
    Height = 25
    Caption = #1069#1082#1074#1072#1083#1080#1079#1072#1094#1080#1103' '#1075#1080#1089#1090#1086#1075#1088#1072#1084#1084#1099
    TabOrder = 6
    OnClick = BHistClick
  end
  object OPD1: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 16
    Top = 16
  end
end
