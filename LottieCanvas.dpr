program LottieCanvas;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'src\Main.pas' {Form2},
  Bodymovin in 'src\Bodymovin.pas',
  Data in 'src\Data.pas',
  bodymovin.CanvasManager in 'src\bodymovin.CanvasManager.pas',
  bodymovin.Struct in 'src\bodymovin.Struct.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
