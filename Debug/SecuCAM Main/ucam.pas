{*******************************************************************************
     *  SecuCAM CST // ucam.pas *     !!! OBSOLETE !!!
     ****************************

  Entwickelt von : WARNIMONT POL
                   T3IF @ Lyc�e du Nord
                   2011 - 2012

  Beschreibung : Unit enth�llt die Klasse TCam.
                 TCam definiert eine Kamera

*******************************************************************************}

unit ucam;

interface

uses
  SysUtils, ucamcomparator, VFrames, ExtCtrls, Windows, dialogs;

type
  TCam = class (TCamComparator)
  private
    CamTimer  : TTimer;
    CamDevice : TVideoImage;
    CamCanvas : TImage;
    Paused    : boolean;

    FDectIntervall : integer;
    FCamDevice     : string;
    FMotDect       : boolean;

    procedure SetDectIntervall (const pDectIntervall: integer);
    procedure SetCamDevice     (const pCamDevice: string);
    procedure SetMotDect       (const pMotDect: boolean);

    procedure CamTimerEvent (Sender: TObject);
  public
    constructor Create;
    destructor  Destroy; override;

    property DetectionIntervall    : integer read FDectIntervall write SetDectIntervall;
    property AttachedCamDevice     : string read FCamDevice write SetCamDevice;
    property ToggleMotionDetection : boolean read FMotDect write SetMotDect;

    function StartVideo: boolean;
    function PauseVideo: boolean;
    function StopVideo: boolean;
  end;

implementation

  constructor TCam.Create;
  begin
    FDectIntervall:= 1000;
    CamTimer:= TTimer.Create (nil);
    CamTimer.Enabled:= true;
    CamTimer.Interval:= FDectIntervall;
    CamTimer.OnTimer:= CamTimerEvent;
    CamDevice:= TVideoImage.Create;
    CamCanvas:= TImage.Create (nil);
    CamDevice.SetDisplayCanvas (CamCanvas.Canvas);
    Paused:= false;
    inherited Create;
  end;

  destructor TCam.Destroy;
  begin
    CamTimer.Destroy;
    CamTimer.Free;
    inherited Destroy;
  end;

  procedure TCam.CamTimerEvent (Sender: TObject);
  begin
    //check cam pics
  end;

  procedure TCam.SetDectIntervall (const pDectIntervall: integer);
  begin
    FDectIntervall:= pDectIntervall;
    CamTimer.Interval:= FDectIntervall;
  end;

  procedure TCam.SetCamDevice (const pCamDevice: string);
  begin
    FCamDevice:= pCamDevice;
  end;

  procedure TCam.SetMotDect (const pMotDect: boolean);
  begin
    FMotDect:= pMotDect;
  end;

  function TCam.StartVideo: boolean;
  begin
    if not CamDevice.VideoRunning then begin
      if not Paused then CamDevice.VideoStart(FCamDevice)
      else begin
        CamDevice.VideoResume;
        Paused:= false;
      end;
      Result:= true;
    end
    else Result:= false;
  end;

  function TCam.PauseVideo: boolean;
  begin
    if not Paused then begin
      CamDevice.VideoPause;
      Result:= true;
      Paused:= true;
    end
    else Result:= false;
  end;

  function TCam.StopVideo: boolean;
  begin
    if CamDevice.VideoRunning then begin
      CamDevice.VideoStop;
      Result:= true;
      Paused:= false;
    end
    else Result:= false;
  end;

end.
