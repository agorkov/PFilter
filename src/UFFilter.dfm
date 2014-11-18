object FFilter: TFFilter
  Left = 0
  Top = 0
  Caption = #1043#1086#1088#1100#1082#1086#1074' '#1040'. - '#1060#1080#1083#1100#1090#1088#1072#1094#1080#1103' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1081
  ClientHeight = 539
  ClientWidth = 1356
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
  object IOut: TImage
    Left = 848
    Top = 8
    Width = 497
    Height = 497
    Center = True
    ParentShowHint = False
    Proportional = True
    ShowHint = False
    Stretch = True
    OnDblClick = IOutDblClick
    OnMouseDown = IOutMouseDown
  end
  object IIn: TImage
    Left = 8
    Top = 8
    Width = 497
    Height = 497
    Center = True
    Proportional = True
    Stretch = True
    OnDblClick = IInDblClick
    OnMouseDown = IInMouseDown
  end
  object PCOperations: TPageControl
    Left = 511
    Top = 8
    Width = 331
    Height = 501
    ActivePage = TSFilter
    TabOrder = 0
    object TSFilter: TTabSheet
      Caption = #1060#1080#1083#1100#1090#1088#1099
      object GBFilterParams: TGroupBox
        Left = 16
        Top = 15
        Width = 289
        Height = 65
        Caption = #1040#1087#1077#1088#1090#1091#1088#1072' '#1092#1080#1083#1100#1090#1088#1072
        TabOrder = 0
        object LEFilterN: TLabeledEdit
          Left = 11
          Top = 35
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
          Top = 35
          Width = 16
          Height = 21
          Associate = LEFilterN
          Position = 1
          TabOrder = 1
        end
        object UDFilterM: TUpDown
          Left = 149
          Top = 35
          Width = 16
          Height = 21
          Associate = LEFilterM
          Position = 1
          TabOrder = 2
        end
        object LEFilterM: TLabeledEdit
          Left = 119
          Top = 35
          Width = 30
          Height = 21
          EditLabel.Width = 53
          EditLabel.Height = 13
          EditLabel.Caption = #1057#1090#1086#1083#1073#1094#1086#1074':'
          TabOrder = 3
          Text = '1'
          OnChange = LEFilterMChange
        end
        object LEFilterD: TLabeledEdit
          Left = 223
          Top = 35
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
          Left = 253
          Top = 35
          Width = 16
          Height = 21
          Associate = LEFilterD
          Position = 3
          TabOrder = 5
          Visible = False
        end
        object CBAddToOriginal: TCheckBox
          Left = 79
          Top = 22
          Width = 122
          Height = 31
          Caption = #1055#1086#1074#1099#1089#1080#1090#1100' '#1088#1077#1079#1082#1086#1089#1090#1100
          TabOrder = 6
          Visible = False
          WordWrap = True
        end
      end
      object RGFilterSelect: TRadioGroup
        Left = 16
        Top = 86
        Width = 289
        Height = 353
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
        TabOrder = 1
        OnClick = RGFilterSelectClick
      end
      object BFilter: TButton
        Left = 16
        Top = 445
        Width = 289
        Height = 25
        Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1102
        TabOrder = 2
        OnClick = BFilterClick
      end
    end
    object TSGradation: TTabSheet
      Caption = #1043#1088#1072#1076#1072#1094#1080#1086#1085#1085#1099#1077' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
      ImageIndex = 1
      object GBLinear: TGroupBox
        Left = 18
        Top = 13
        Width = 129
        Height = 99
        Caption = #1051#1080#1085#1077#1081#1085#1072#1103' '#1082#1086#1088#1088#1077#1082#1094#1080#1103':'
        TabOrder = 0
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
          Text = '1'
        end
      end
      object GBLog: TGroupBox
        Left = 178
        Top = 13
        Width = 129
        Height = 99
        Caption = #1051#1086#1075'. '#1082#1086#1088#1088#1077#1082#1094#1080#1103':'
        TabOrder = 1
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
          Text = '1,5'
        end
      end
      object GBGamma: TGroupBox
        Left = 19
        Top = 118
        Width = 286
        Height = 99
        Caption = #1043#1072#1084#1084#1072' '#1082#1086#1088#1088#1077#1082#1094#1080#1103
        TabOrder = 2
        object BGamma: TButton
          Left = 104
          Top = 59
          Width = 104
          Height = 25
          Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100
          TabOrder = 0
          OnClick = BGammaClick
        end
        object LEGammaC: TLabeledEdit
          Left = 104
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
          Left = 159
          Top = 32
          Width = 33
          Height = 21
          EditLabel.Width = 39
          EditLabel.Height = 13
          EditLabel.Caption = 'Gamma:'
          TabOrder = 2
          Text = '0,5'
        end
      end
      object BConvertToGrayscale: TButton
        Left = 16
        Top = 223
        Width = 289
        Height = 25
        Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' '#1075#1088#1072#1076#1072#1094#1080#1080' '#1089#1077#1088#1086#1075#1086
        TabOrder = 3
        OnClick = BConvertToGrayscaleClick
      end
      object GBBinarization: TGroupBox
        Left = 7
        Top = 254
        Width = 306
        Height = 199
        Caption = #1041#1080#1085#1072#1088#1080#1079#1072#1094#1080#1103
        TabOrder = 4
        object PCBinarizatoin: TPageControl
          Left = 11
          Top = 20
          Width = 289
          Height = 113
          ActivePage = TSThresoldBinarization
          MultiLine = True
          TabOrder = 0
          TabPosition = tpBottom
          object TSThresoldBinarization: TTabSheet
            Caption = #1055#1086#1088#1086#1075#1086#1074#1072#1103' '#1073#1080#1085#1072#1088#1080#1079#1072#1094#1080#1103
            object LThresoldBinarization: TLabel
              Left = 3
              Top = 10
              Width = 102
              Height = 13
              Caption = #1055#1086#1088#1086#1075' '#1073#1080#1085#1072#1088#1080#1079#1072#1094#1080#1080':'
            end
            object TBBinarizationThresold: TTrackBar
              Left = 3
              Top = 29
              Width = 275
              Height = 23
              Max = 100
              Position = 50
              TabOrder = 0
            end
          end
          object TSBernsenBinarization: TTabSheet
            Caption = #1041#1080#1085#1072#1088#1080#1079#1072#1094#1080#1103' '#1041#1077#1088#1085#1089#1077#1085#1072
            ImageIndex = 1
            object Label1: TLabel
              Left = 80
              Top = 10
              Width = 90
              Height = 13
              Caption = #1055#1086#1088#1086#1075' '#1082#1086#1085#1090#1088#1072#1089#1090#1072':'
            end
            object LEBersenR: TLabeledEdit
              Left = 3
              Top = 24
              Width = 46
              Height = 21
              EditLabel.Width = 66
              EditLabel.Height = 13
              EditLabel.Caption = #1056#1072#1079#1084#1077#1088' '#1086#1082#1085#1072':'
              TabOrder = 0
              Text = '1'
            end
            object UDBersenR: TUpDown
              Left = 49
              Top = 24
              Width = 16
              Height = 21
              Associate = LEBersenR
              Min = 1
              Position = 1
              TabOrder = 1
            end
            object TBBersenContrastThresold: TTrackBar
              Left = 71
              Top = 26
              Width = 207
              Height = 23
              Max = 100
              Position = 15
              TabOrder = 2
            end
          end
          object TSThresoldIntervalBinarization: TTabSheet
            Caption = #1055#1086#1088#1086#1075#1086#1074#1072#1103' '#1073#1080#1085#1072#1088#1080#1079#1072#1094#1080#1103' '#1087#1086' '#1080#1085#1090#1077#1088#1074#1072#1083#1091
            ImageIndex = 2
            object Label2: TLabel
              Left = 3
              Top = 7
              Width = 75
              Height = 13
              Caption = #1053#1080#1078#1085#1080#1081' '#1087#1086#1088#1086#1075':'
            end
            object Label3: TLabel
              Left = 160
              Top = 7
              Width = 78
              Height = 13
              Caption = #1042#1077#1088#1093#1085#1080#1081' '#1087#1086#1088#1086#1075':'
            end
            object TBThresoldDown: TTrackBar
              Left = 3
              Top = 26
              Width = 118
              Height = 23
              Max = 100
              Position = 30
              TabOrder = 0
              OnChange = TBThresoldDownChange
            end
            object TBThresoldUp: TTrackBar
              Left = 160
              Top = 26
              Width = 118
              Height = 23
              Max = 100
              Position = 50
              TabOrder = 1
              OnChange = TBThresoldUpChange
            end
          end
        end
        object CBInvertResult: TCheckBox
          Left = 11
          Top = 139
          Width = 289
          Height = 17
          Caption = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
          TabOrder = 1
        end
        object BConvertToBinary: TButton
          Left = 11
          Top = 157
          Width = 289
          Height = 25
          Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' '#1073#1080#1085#1072#1088#1085#1086#1077
          TabOrder = 2
          OnClick = BConvertToBinaryClick
        end
      end
    end
    object TSHistogram: TTabSheet
      Caption = #1043#1080#1089#1090#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 2
      OnShow = TSHistogramShow
      object IHistR: TImage
        Left = 3
        Top = 54
        Width = 317
        Height = 123
        Center = True
        Stretch = True
      end
      object IHistG: TImage
        Left = 3
        Top = 199
        Width = 317
        Height = 123
        Center = True
        Stretch = True
      end
      object IHistB: TImage
        Left = 3
        Top = 347
        Width = 317
        Height = 123
        Center = True
        Stretch = True
      end
      object BHistogramEqualization: TButton
        Left = 3
        Top = 12
        Width = 317
        Height = 25
        Caption = #1069#1082#1074#1072#1083#1080#1079#1072#1094#1080#1103' '#1075#1080#1089#1090#1086#1075#1088#1072#1084#1084#1099
        TabOrder = 0
        OnClick = BHistogramEqualizationClick
      end
    end
  end
  object Button1: TButton
    Left = 8
    Top = 511
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object OPD: TOpenPictureDialog
    Filter = 'All|*.bmp;*.jpg;*.jpeg'
    Left = 16
    Top = 16
  end
  object SPD: TSaveDialog
    Filter = 'bmp|*.bmp'
    Left = 856
    Top = 16
  end
end
