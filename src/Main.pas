unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, bodymovin.CanvasManager,
  FMX.Layouts;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Layout1: TLayout;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    L: TCanvasLayer;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses
  bodymovin, System.IOUtils;

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  L := TCanvasLayer.Create(Self);
  l.Parent := Self;
//  Rectangle1.Canvas.Clear(TAlphaColorRec.White);
  with l.Layer[0] do
  begin
    BeginScene();
    Fill.Color := TAlphaColorRec.Blue;
    Fill.Kind := TBrushKind.Solid;
    Stroke.Thickness := 2;
    Stroke.Kind := TBrushKind.Solid;


    DrawLine(PointF(10, 10), PointF(100, 100), 1);
    DrawLine(PointF(100, 100), PointF(100, 10), 1);
    DrawLine(PointF(100, 10), PointF(10, 100), 1);
    DrawLine(PointF(10, 100), PointF(100, 100), 1);
    DrawLine(PointF(10, 10), PointF(100, 100), 1);
    EndScene;
  end;
  with l.Layer[1] do
  begin
    BeginScene();
    Fill.Color := TAlphaColorRec.Red;
    Fill.Kind := TBrushKind.Solid;
    Stroke.Thickness := 2;
    Stroke.Kind := TBrushKind.Solid;


    DrawLine(PointF(103, 14), PointF(104, 104), 1);
    DrawLine(PointF(104, 104), PointF(104, 14), 1);
    DrawLine(PointF(104, 14), PointF(14, 104), 1);
    DrawLine(PointF(14, 104), PointF(104, 104), 1);
//    DrawLine(PointF(10, 10), PointF(100, 100), 1);
    EndScene;
  end;

end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  TBodymovinPlayer.Create(Layout1, TFile.ReadAllText('warning.json'));
end;

end.
