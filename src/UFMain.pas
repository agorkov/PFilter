unit UFMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    IIn: TImage;
    IOut: TImage;
    OPD1: TOpenPictureDialog;
    BFilter: TButton;
    RGFilterSelect: TRadioGroup;
    GBFilterParams: TGroupBox;
    LEFilterN: TLabeledEdit;
    UDFilterN: TUpDown;
    UDFilterM: TUpDown;
    LEFilterM: TLabeledEdit;
    Ltime: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure IInDblClick(Sender: TObject);
    procedure BFilterClick(Sender: TObject);
    procedure IOutDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  UPixelConvert, UImages, UFilter;

procedure TForm1.BFilterClick(Sender: TObject);
var
  GSI: UImages.TGreyscaleImage;
  BM: TBitmap;
  FilterN, FilterM: byte;
  T: TDateTime;
begin
  BM := TBitmap.Create;
  BM.Assign(IIn.Picture);
  UImages.LoadGSIFromBitMap(GSI, BM);
  BM.Free;

  FilterN := StrToInt(LEFilterN.Text);
  FilterM := StrToInt(LEFilterM.Text);
  T := Now;
  case RGFilterSelect.ItemIndex of
  0: UFilter.AVGFilter(GSI, FilterN, FilterM);
  1: UFilter.WeightedAVGFilter(GSI, FilterN, FilterM);
  2: UFilter.GeometricMeanFilter(GSI, FilterN, FilterM);
  3: UFilter.MedianFilter(GSI, FilterN, FilterM);
  4: UFilter.MaxFilter(GSI, FilterN, FilterM);
  5: UFilter.MinFilter(GSI, FilterN, FilterM);
  6: UFilter.MiddlePointFilter(GSI, FilterN, FilterM);
  7: UFilter.TruncatedMeanFilter(GSI, FilterN, FilterM, (FilterN * 2 + 1) * (FilterM * 2 + 1) div 3);
  end;
  Label1.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
  BM := UImages.SaveGreyscaleImgToBitMap(GSI);
  IOut.Picture.Assign(BM);
  BM.Free;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  IIn.Canvas.Rectangle(1, 1, IIn.Width, IIn.Height);
  IOut.Canvas.Rectangle(1, 1, IOut.Width, IOut.Height);
end;

procedure TForm1.IInDblClick(Sender: TObject);
var
  row, col: word;
  BM: TBitmap;
  color: TColor;
  r, g, b, Y, I, Q: double;
begin
  if OPD1.Execute then
  begin
    IIn.Picture.LoadFromFile(OPD1.FileName);
    BM := TBitmap.Create;
    BM.Assign(IIn.Picture);
    for row := 1 to BM.Height do
      for col := 1 to BM.Width do
      begin
        color := BM.Canvas.Pixels[col, row];
        UPixelConvert.TColorToRGB(color, r, g, b);
        UPixelConvert.RGBToYIQ(r, g, b, Y, I, Q);
        color := UPixelConvert.RGBToColor(Y, Y, Y);
        BM.Canvas.Pixels[col, row] := color;
      end;
    IIn.Picture.Assign(BM);
    BM.Free;
  end;
end;

procedure TForm1.IOutDblClick(Sender: TObject);
begin
  IOut.Picture.SaveToFile('Result.bmp');
end;

end.
