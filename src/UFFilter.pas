unit UFFilter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFFilter = class(TForm)
    IIn: TImage;
    IOut: TImage;
    OPD: TOpenPictureDialog;
    BFilter: TButton;
    RGFilterSelect: TRadioGroup;
    GBFilterParams: TGroupBox;
    LEFilterN: TLabeledEdit;
    UDFilterN: TUpDown;
    UDFilterM: TUpDown;
    LEFilterM: TLabeledEdit;
    LTime: TLabel;
    LEFilterD: TLabeledEdit;
    UDFilterD: TUpDown;
    CBAddToOriginal: TCheckBox;
    BLinear: TButton;
    GBLinear: TGroupBox;
    LELinearK: TLabeledEdit;
    LELinearb: TLabeledEdit;
    GBLog: TGroupBox;
    BLog: TButton;
    LELogC: TLabeledEdit;
    BHistogramEqualization: TButton;
    SPD: TSaveDialog;
    BConvertToGrayscale: TButton;
    PCOperations: TPageControl;
    TSFilter: TTabSheet;
    TSGradation: TTabSheet;
    TSHistogram: TTabSheet;
    GBGamma: TGroupBox;
    BGamma: TButton;
    LEGammaC: TLabeledEdit;
    LEGammaGamma: TLabeledEdit;
    IHistR: TImage;
    IHistG: TImage;
    IHistB: TImage;
    procedure FormActivate(Sender: TObject);
    procedure IInDblClick(Sender: TObject);
    procedure BFilterClick(Sender: TObject);
    procedure IOutDblClick(Sender: TObject);
    procedure LEFilterNChange(Sender: TObject);
    procedure LEFilterMChange(Sender: TObject);
    procedure RGFilterSelectClick(Sender: TObject);
    procedure BLinearClick(Sender: TObject);
    procedure FormCanResize(
      Sender: TObject;
      var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure BLogClick(Sender: TObject);
    procedure BGammaClick(Sender: TObject);
    procedure BHistogramEqualizationClick(Sender: TObject);
    procedure IOutMouseDown(
      Sender: TObject;
      Button: TMouseButton;
      Shift: TShiftState;
      X, Y: Integer);
    procedure BConvertToGrayscaleClick(Sender: TObject);
    procedure TSHistogramShow(Sender: TObject);
    procedure IInMouseDown(
      Sender: TObject;
      Button: TMouseButton;
      Shift: TShiftState;
      X, Y: Integer);
    procedure GetHistogram;
    procedure StartFiltration;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFilter: TFFilter;

implementation

{$R *.dfm}

uses
  Math, JPEG, UColorImages, UGrayscaleImages, UPixelConvert, UFileConvert, ShellAPI;

var
  TStart: TDateTime;
  FilterH, FilterW: byte;

function GetWinPath(const Macro: string): string;
var
  P: array [0 .. 4096] of Char;
begin
  Result := Macro;
  ExpandEnvironmentStrings(
    PChar(Result),
    P,
    SizeOf(P));
  Result := P;
end;

procedure TFFilter.StartFiltration;
begin
  TStart := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FFilter.Repaint;
end;

procedure TFFilter.GetHistogram;
var
  RGBI: TCColorImage;
  BM: Tbitmap;
begin
  StartFiltration;
  RGBI := TCColorImage.CreateandLoadFromBitMap(IIn.Picture.Bitmap);
  BM := RGBI.Histogram(ccRed);
  IHistR.Picture.Assign(BM);
  BM.Free;
  BM := RGBI.Histogram(ccGreen);
  IHistG.Picture.Assign(BM);
  BM.Free;
  BM := RGBI.Histogram(ccBlue);
  IHistB.Picture.Assign(BM);
  BM.Free;
  RGBI.FreeColorImage;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - TStart);
end;

procedure TFFilter.BFilterClick(Sender: TObject);
var
  RGB: TCColorImage;
  BM: Tbitmap;
begin
  StartFiltration;

  RGB := TCColorImage.CreateandLoadFromBitMap(IIn.Picture.Bitmap);

  case RGFilterSelect.ItemIndex of
    0:
      begin
        RGB.AVGFilter(
          ccRed,
          FilterH,
          FilterW);
        RGB.AVGFilter(
          ccGreen,
          FilterH,
          FilterW);
        RGB.AVGFilter(
          ccBlue,
          FilterH,
          FilterW);
      end;
    1:
      begin
        RGB.WeightedAVGFilter(
          ccRed,
          FilterH,
          FilterW);
        RGB.WeightedAVGFilter(
          ccGreen,
          FilterH,
          FilterW);
        RGB.WeightedAVGFilter(
          ccBlue,
          FilterH,
          FilterW);
      end;
    2:
      begin
        RGB.GeometricMeanFilter(
          ccRed,
          FilterH,
          FilterW);
        RGB.GeometricMeanFilter(
          ccGreen,
          FilterH,
          FilterW);
        RGB.GeometricMeanFilter(
          ccBlue,
          FilterH,
          FilterW);
      end;
    3:
      begin
        RGB.MedianFilter(
          ccRed,
          FilterH,
          FilterW);
        RGB.MedianFilter(
          ccGreen,
          FilterH,
          FilterW);
        RGB.MedianFilter(
          ccBlue,
          FilterH,
          FilterW);
      end;
    4:
      begin
        RGB.MaxFilter(
          ccRed,
          FilterH,
          FilterW);
        RGB.MaxFilter(
          ccGreen,
          FilterH,
          FilterW);
        RGB.MaxFilter(
          ccBlue,
          FilterH,
          FilterW);
      end;
    5:
      begin
        RGB.MinFilter(
          ccRed,
          FilterH,
          FilterW);
        RGB.MinFilter(
          ccGreen,
          FilterH,
          FilterW);
        RGB.MinFilter(
          ccBlue,
          FilterH,
          FilterW);
      end;
    6:
      begin
        RGB.MiddlePointFilter(
          ccRed,
          FilterH,
          FilterW);
        RGB.MiddlePointFilter(
          ccGreen,
          FilterH,
          FilterW);
        RGB.MiddlePointFilter(
          ccBlue,
          FilterH,
          FilterW);
      end;
    7:
      begin
        RGB.TruncatedAVGFilter(
          ccRed,
          FilterH,
          FilterW,
          StrToInt(LEFilterD.Text));
        RGB.TruncatedAVGFilter(
          ccGreen,
          FilterH,
          FilterW,
          StrToInt(LEFilterD.Text));
        RGB.TruncatedAVGFilter(
          ccBlue,
          FilterH,
          FilterW,
          StrToInt(LEFilterD.Text));
      end;
    8:
      begin
        RGB.PrevittFilter(
          ccRed,
          CBAddToOriginal.Checked);
        RGB.PrevittFilter(
          ccGreen,
          CBAddToOriginal.Checked);
        RGB.PrevittFilter(
          ccBlue,
          CBAddToOriginal.Checked);
      end;
    9:
      begin
        RGB.SobelFilter(
          ccRed,
          CBAddToOriginal.Checked);
        RGB.SobelFilter(
          ccGreen,
          CBAddToOriginal.Checked);
        RGB.SobelFilter(
          ccBlue,
          CBAddToOriginal.Checked);
      end;
    10:
      begin
        RGB.SharrFilter(
          ccRed,
          CBAddToOriginal.Checked);
        RGB.SharrFilter(
          ccGreen,
          CBAddToOriginal.Checked);
        RGB.SharrFilter(
          ccBlue,
          CBAddToOriginal.Checked);
      end;
    11:
      begin
        RGB.LaplaceFilter(
          ccRed,
          CBAddToOriginal.Checked);
        RGB.LaplaceFilter(
          ccGreen,
          CBAddToOriginal.Checked);
        RGB.LaplaceFilter(
          ccBlue,
          CBAddToOriginal.Checked);
      end;
  end;
  BM := RGB.SaveToBitMap;
  IOut.Picture.Assign(BM);
  BM.Free;
  RGB.FreeColorImage;

  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - TStart);
end;

procedure TFFilter.BLinearClick(Sender: TObject);
var
  RGB: TCColorImage;
  BM: Tbitmap;
  k, B: double;
begin
  StartFiltration;
  RGB := TCColorImage.CreateandLoadFromBitMap(IIn.Picture.Bitmap);
  k := strtofloat(LELinearK.Text);
  B := strtofloat(LELinearb.Text);
  RGB.LinearTransform(
    ccRed,
    k,
    B);
  RGB.LinearTransform(
    ccGreen,
    k,
    B);
  RGB.LinearTransform(
    ccBlue,
    k,
    B);
  BM := RGB.SaveToBitMap;
  IOut.Picture.Assign(BM);
  BM.Free;
  RGB.FreeColorImage;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - TStart);
end;

procedure TFFilter.BLogClick(Sender: TObject);
var
  c: double;
  RGB: TCColorImage;
  BM: Tbitmap;
begin
  StartFiltration;
  RGB := TCColorImage.CreateandLoadFromBitMap(IIn.Picture.Bitmap);
  c := strtofloat(LELogC.Text);
  RGB.LogTransform(
    ccRed,
    c);
  RGB.LogTransform(
    ccGreen,
    c);
  RGB.LogTransform(
    ccBlue,
    c);
  BM := RGB.SaveToBitMap;
  IOut.Picture.Assign(BM);
  BM.Free;
  RGB.FreeColorImage;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - TStart);
end;

procedure TFFilter.BGammaClick(Sender: TObject);
var
  c, gamma: double;
  RGB: TCColorImage;
  BM: Tbitmap;
begin
  StartFiltration;
  RGB := TCColorImage.CreateandLoadFromBitMap(IIn.Picture.Bitmap);
  c := strtofloat(LEGammaC.Text);
  gamma := strtofloat(LEGammaGamma.Text);
  RGB.GammaTransform(
    ccRed,
    c,
    gamma);
  RGB.GammaTransform(
    ccGreen,
    c,
    gamma);
  RGB.GammaTransform(
    ccBlue,
    c,
    gamma);
  BM := RGB.SaveToBitMap;
  IOut.Picture.Assign(BM);
  BM.Free;
  RGB.FreeColorImage;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - TStart);
end;

procedure TFFilter.BConvertToGrayscaleClick(Sender: TObject);
var
  GS: TCGrayscaleImage;
  BM: Tbitmap;
begin
  StartFiltration;
  GS := TCGrayscaleImage.CreateandLoadFromBitMap(IIn.Picture.Bitmap);
  BM := GS.SaveToBitMap;
  IOut.Picture.Assign(BM);
  BM.Free;
  GS.FreeGrayscaleImage;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - TStart);
end;

procedure TFFilter.BHistogramEqualizationClick(Sender: TObject);
var
  RGB: TCColorImage;
  BM: Tbitmap;
begin
  StartFiltration;
  RGB := TCColorImage.CreateandLoadFromBitMap(IIn.Picture.Bitmap);
  RGB.HistogramEqualization(ccRed);
  RGB.HistogramEqualization(ccGreen);
  RGB.HistogramEqualization(ccBlue);
  BM := RGB.SaveToBitMap;
  IOut.Picture.Assign(BM);
  BM.Free;
  RGB.FreeColorImage;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - TStart);
end;

procedure TFFilter.FormActivate(Sender: TObject);
begin
  IIn.Canvas.Rectangle(
    1,
    1,
    IIn.Width,
    IIn.Height);
  IOut.Canvas.Rectangle(
    1,
    1,
    IOut.Width,
    IOut.Height);
end;

procedure TFFilter.FormCanResize(
  Sender: TObject;
  var NewWidth, NewHeight: Integer;
  var Resize: Boolean);
begin
  Resize := false;
end;

procedure TFFilter.IInDblClick(Sender: TObject);
begin
  if OPD.Execute then
  begin
    IIn.Picture.Assign(UFileConvert.LoadFile(OPD.FileName));
    if PCOperations.TabIndex = 2 then
      GetHistogram;
  end;
end;

procedure TFFilter.IInMouseDown(
  Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X, Y: Integer);
var
  tmpFileName: string;
begin
  if ssShift in Shift then
    if SPD.Execute then
      IIn.Picture.SaveToFile(SPD.FileName);
  if ssCtrl in Shift then
  begin
    tmpFileName := GetWinPath('%Temp%') + '\' + 'Filter_tmp.bmp';
    IIn.Picture.SaveToFile(tmpFileName);
    ShellExecute(
      handle,
      'open',
      PWideChar(tmpFileName),
      nil,
      nil,
      SW_SHOWNORMAL);
  end;
end;

procedure TFFilter.IOutDblClick(Sender: TObject);
begin
  IIn.Picture.Assign(IOut.Picture.Bitmap);
  if PCOperations.TabIndex = 2 then
    GetHistogram;
end;

procedure TFFilter.IOutMouseDown(
  Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X, Y: Integer);
var
  tmpFileName: string;
begin
  if ssShift in Shift then
    if SPD.Execute then
      IOut.Picture.SaveToFile(SPD.FileName);
  if ssCtrl in Shift then
  begin
    tmpFileName := GetWinPath('%Temp%') + '\' + 'Filter_tmp.bmp';
    IOut.Picture.SaveToFile(tmpFileName);
    ShellExecute(
      handle,
      'open',
      PWideChar(tmpFileName),
      nil,
      nil,
      SW_SHOWNORMAL);
  end;
end;

procedure TFFilter.LEFilterMChange(Sender: TObject);
var
  FilterN, FilterM: word;
begin
  FilterN := StrToInt(LEFilterN.Text);
  FilterM := StrToInt(LEFilterM.Text);
  FilterN := 2 * FilterN + 1;
  FilterM := 2 * FilterM + 1;
  LEFilterD.Text := inttostr(FilterN * FilterM div 3);
  UDFilterD.Max := (FilterN * FilterM - 1) div 2;
end;

procedure TFFilter.LEFilterNChange(Sender: TObject);
begin
  FilterH := StrToInt(LEFilterN.Text);
  FilterW := StrToInt(LEFilterM.Text);
  LEFilterD.Text := inttostr(((2 * FilterH + 1) * (2 * FilterW + 1)) div 3);
  UDFilterD.Max := ((2 * FilterH + 1) * (2 * FilterW + 1) - 1) div 2;
end;

procedure TFFilter.RGFilterSelectClick(Sender: TObject);
begin
  LEFilterN.Visible := true;
  UDFilterN.Visible := true;
  LEFilterM.Visible := true;
  UDFilterM.Visible := true;
  LEFilterD.Visible := false;
  UDFilterD.Visible := false;
  CBAddToOriginal.Visible := false;
  if RGFilterSelect.ItemIndex = 7 then
  begin
    LEFilterD.Visible := true;
    UDFilterD.Visible := true;
  end;
  if RGFilterSelect.ItemIndex > 7 then
  begin
    CBAddToOriginal.Visible := true;
    LEFilterN.Visible := false;
    UDFilterN.Visible := false;
    LEFilterM.Visible := false;
    UDFilterM.Visible := false;
  end;
end;

procedure TFFilter.TSHistogramShow(Sender: TObject);
begin
  GetHistogram;
end;

end.
