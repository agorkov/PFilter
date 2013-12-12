unit UFilter;

interface

uses
  UImages;
procedure Inverse(var GSI: TGreyscaleImage);

implementation

procedure Inverse(var GSI: TGreyscaleImage);
var
  i, j: word;
begin
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSI.i[i, j] := not GSI.i[i, j];
end;

end.
