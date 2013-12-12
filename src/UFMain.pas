unit UFMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    IIn: TImage;
    IOut: TImage;
    OPD1: TOpenPictureDialog;
    procedure FormActivate(Sender: TObject);
    procedure IInDblClick(Sender: TObject);
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
  UPixelConvert;

procedure TForm1.FormActivate(Sender: TObject);
begin
  IIn.Canvas.Rectangle(1, 1, IIn.Width, IIn.Height);
  IOut.Canvas.Rectangle(1, 1, IOut.Width, IOut.Height);
end;

procedure TForm1.IInDblClick(Sender: TObject);
var
  row, col: word;
  BM: TBitMap;
  color: TColor;
  r, g, b, Y, I, Q: double;
begin
  if OPD1.Execute then
  begin
    IIn.Picture.LoadFromFile(OPD1.FileName);
    BM := TBitMap.Create;
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

end.
