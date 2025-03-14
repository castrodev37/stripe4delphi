unit Stripe.Config.EnvironmentVariables;

interface

uses
  System.Classes,
  System.SysUtils;

function GetEnvVariable(const AFileName, AKey: string): string;

implementation

function GetEnvVariable(const AFileName, AKey: string): string;
var
  LEnvFile: TStringList;
  I: Integer;
  LLine, LKey, LValue: string;
begin
  Result := '';
  if not FileExists(AFileName) then
    Exit;

  LEnvFile := TStringList.Create;
  try
    LEnvFile.LoadFromFile(AFileName);
    for I := 0 to Pred(LEnvFile.Count) do
    begin
      LLine := Trim(LEnvFile[I]);
      if (LLine = '') or (LLine.StartsWith('#')) then
        Continue;
      LKey := Trim(Copy(LLine, 1, Pos('=', LLine) - 1));
      LValue := Trim(Copy(LLine, Pos('=', LLine) + 1, Length(LLine)));

      if SameText(LKey, AKey) then
      begin
        Result := LValue;
        Break;
      end;
    end;
  finally
    LEnvFile.Free;
  end;
end;

end.
