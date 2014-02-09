unit kys_engine;

interface

uses
  SysUtils,
  Windows,
  Math,
  Dialogs,
  SDL,
  SDL_TTF,
  //SDL_mixer,
  iniFiles,
  SDL_image,
  //smpeg,
  SDL_Gfx,
  kys_type,
  kys_battle,
  kys_main,
  bassmidi,
  bass,
  gl,
  glext;

type
  TBuildInfo = record
    c: integer;
    b, x, y: integer;
  end;

var
  LT: TPosition;  //��Ļ���Ͻ���ӳ���е�λ��

function WaitAnyKey: integer; overload;
procedure WaitAnyKey(keycode, x, y: psmallint); overload;
procedure CheckEvent3;

//��Ƶ�ӳ�
{
procedure PlayMP3(MusicNum, times: integer);
procedure StopMP3;
//procedure InitalMusic;
procedure PlaySound(SoundNum, times: integer); overload;
procedure PlaySound(SoundNum: integer); overload;  }

procedure InitialMusic;
procedure PlayMP3(MusicNum, times: integer); overload;
procedure StopMP3;
procedure PlaySoundE(SoundNum, times: integer); overload;
procedure PlaySoundE(SoundNum: integer); overload;
procedure PlaySoundE(SoundNum, times, x, y, z: integer); overload;
procedure PlaySoundA(SoundNum, times: integer);

//������ͼ�ӳ�
function GetPixel(surface: PSDL_Surface; x: integer; y: integer): uint32;
procedure PutPixel(surface_: PSDL_Surface; x: integer; y: integer; pixel: uint32);
procedure drawscreenpixel(x, y: integer; color: uint32);
procedure display_bmp(file_name: pchar; x, y: integer);
procedure display_img(file_name: pchar; x, y: integer); overload;
function ColColor(num: integer): uint32; overload;
function ColColor(colnum, num: integer): uint32; overload;
procedure DrawLine(x1, y1, x2, y2, color, Width: integer);

//��RLE8ͼƬ���ӳ�
function JudgeInScreen(px, py, w, h, xs, ys: integer): boolean; overload;
function JudgeInScreen(px, py, w, h, xs, ys, xx, yy, xw, yh: integer): boolean; overload;
procedure DrawRLE8Pic(num, px, py: Integer; Pidx: Pinteger; Ppic: PByte; RectArea: TRect;
  Image: pchar; Shadow: Integer; mask: integer = 0; maskvalue: smallint = 0); overload;
function GetPositionOnScreen(x, y, CenterX, CenterY: integer): TPosition;
procedure DrawTitlePic(imgnum, px, py: integer);
procedure DrawMPic(num, px, py: integer; mask: integer = 0);
procedure DrawSPic(num, px, py, x, y, w, h: integer; mask: integer = 0); overload;
procedure DrawSNewPic(num, px, py, x, y, w, h: integer; mask: integer = 0);
function CalBlock(x, y: integer): smallint;
procedure InitialSPic(num, px, py, x, y, w, h: integer; mask: integer = 0); overload;
procedure DrawHeadPic(num, px, py: integer);
procedure DrawBPic(num, px, py, shadow: integer; mask: integer = 0); overload;
procedure DrawBPic(num, x, y, w, h, px, py, shadow: integer; mask: integer = 0); overload;
procedure DrawBPicInRect(num, px, py, shadow, x, y, w, h: integer);
procedure InitialBPic(num, px, py: integer; mask: integer = 0; maskvalue: integer = 0); overload;
procedure InitialBPic(num, px, py, x, y, w, h, mask: integer); overload;
{�ɳ��ж�����һ֡����WMP
procedure DrawBRolePic(num, px, py, shadow, mask: integer); overload;
procedure DrawBRolePic(num, x, y, w, h, px, py, shadow, mask: integer); overload; }

//��ʾ���ֵ��ӳ�
function Big5ToUnicode(str: pchar): WideString;
function GBKToUnicode(str: pchar): WideString;
function UnicodeToBig5(str: pWideChar): string;
procedure DrawText(sur: PSDL_Surface; word: puint16; x_pos, y_pos, size: integer; color: uint32); overload;
procedure DrawText(sur: PSDL_Surface; word: puint16; x_pos, y_pos: integer; color: uint32); overload;
procedure DrawEngText(sur: PSDL_Surface; word: puint16; x_pos, y_pos: integer; color: uint32);
procedure DrawShadowText(word: puint16; x_pos, y_pos, size: integer; color1, color2: uint32); overload;
procedure DrawShadowText(word: puint16; x_pos, y_pos: integer; color1, color2: uint32); overload;
procedure DrawEngShadowText(word: puint16; x_pos, y_pos: integer; color1, color2: uint32);
procedure DrawBig5Text(sur: PSDL_Surface; str: pchar; x_pos, y_pos: integer; color: uint32);
procedure DrawBig5ShadowText(word: pchar; x_pos, y_pos: integer; color1, color2: uint32);
procedure DrawGBKText(sur: PSDL_Surface; str: pchar; x_pos, y_pos: integer; color: uint32);
procedure DrawGBKShadowText(word: pchar; x_pos, y_pos: integer; color1, color2: uint32);
procedure DrawTextWithRect(word: puint16; x, y, w: integer; color1, color2: uint32);
procedure DrawRectangle(x, y, w, h: integer; colorin, colorframe: uint32; alpha: integer);
procedure DrawRectangleWithoutFrame(x, y, w, h: integer; colorin: uint32; alpha: integer);

//����������Ļ���ӳ�
procedure Redraw;
procedure DrawMMap;
procedure QuickSortB(var a: array of TBuildInfo; l, r: integer);
procedure DrawScene;
procedure DrawSceneWithoutRole(x, y: integer);
procedure DrawRoleOnScene(x, y: integer);
procedure InitialScene();
procedure UpdateScene(xs, ys, oldpic, newpic: integer);
procedure LoadScenePart(x, y: integer);
procedure DrawBField;
procedure DrawBfieldWithoutRole(x, y: integer);
procedure DrawRoleOnBfield(x, y: integer);
procedure InitialWholeBField;
procedure LoadBfieldPart(x, y: integer; onlyBuild: integer = 0);
procedure DrawBFieldWithCursor(AttAreaType, step, range,mods: integer);
procedure DrawBFieldWithEft(f, Epicnum, bigami, level: integer);
procedure DrawBFieldWithEft2(f, Epicnum, bigami, x, y, level: integer);
procedure DrawBFieldWithAction(f, bnum, Apicnum: integer);

//KG�����ĺ���
procedure InitNewPic(num, px, py, x, y, w, h: integer; mask: integer = 0);
procedure display_img(file_name: pchar; x, y, x1, y1, w, h: integer); overload;
procedure display_imgFromSurface(image: PSDL_Surface; x, y, x1, y1, w, h: integer); overload;
procedure display_imgFromSurface(image: PSDL_Surface; x, y: integer); overload;
procedure display_imgFromSurface(image: Tpic; x, y, x1, y1, w, h: integer); overload;
procedure display_imgFromSurface(image: Tpic; x, y: integer); overload;
function GetPngPic(filename: string; num: integer): Tpic; overload;
function GetPngPic(f: integer; num: integer): Tpic; overload;
procedure drawPngPic(image: Tpic; px, py, mask: integer; maskvalue: smallint = 0); overload;
procedure drawPngPic(image: Tpic; x, y, w, h, px, py, mask: integer; maskvalue: smallint = 0); overload;
function ReadPicFromByte(p_byte: Pbyte; size: Integer): PSDL_Surface;
function Simplified2Traditional(mSimplified: string): string;
function Traditional2Simplified(mTraditional: string): string;
procedure resetpallet; overload;
procedure resetpallet(num: integer); overload;
function RoRforUInt16(a, n: uint16): uint16; //ѭ������Nλ
function RoLforUint16(a, n: uint16): uint16; //ѭ������Nλ
function RoRforByte(a: byte; n: uint16): byte; //ѭ������Nλ
function RoLforByte(a: byte; n: uint16): byte; //ѭ������Nλ
procedure DrawEftPic(Pic: Tpic; px, py, level: integer);
procedure ZoomPic(scr: PSDL_Surface; angle: double; x, y, w, h: integer);
function GetZoomPic(scr: PSDL_Surface; angle: double; x, y, w, h: integer): PSDL_Surface;
function UnicodeToGBK(str: pWideChar): string;
procedure UpdateBattleScene(xs, ys, oldPic, newpic: integer);
procedure Moveman(x1, y1, x2, y2: integer);
procedure FindWay(x1, y1: integer); overload;
procedure FindWay(x1, y1, mods: integer); overload;

//��Ļ��չ���
procedure SDL_UpdateRect2(scr1: PSDL_Surface; x, y, w, h: integer);
procedure SDL_GetMouseState2(var x, y: integer);
procedure ResizeWindow(w, h: integer);
procedure SwitchFullscreen;
procedure QuitConfirm;
procedure CheckBasicEvent;
procedure ChangeCol;

procedure GetMousePosition(var x, y: integer; x0, y0: integer; yp: integer = 0);


implementation

uses
  kys_event,
  sty_engine,
  sty_show,
  sty_newevent;

{procedure InitalMusic;
var
  i: integer;
  str: string;
begin
  SDL_Init(SDL_INIT_AUDIO);
  Mix_OpenAudio(MIX_DEFAULT_FREQUENCY, MIX_DEFAULT_FORMAT, 2, 8192);
  for i := 0 to 99 do
  begin
    str := 'music\'+ inttostr(i) + '.mp3';
    if fileexists(str) then
      Music[i] := Mix_LoadMUS(pchar(str))
    else
      Music[i] := nil;
  end;
  for i := 0 to 99 do
  begin
    str := 'sound\e'+ format('%2d', [i]) + '.wav';
    if fileexists(str) then
      Esound[i] := Mix_LoadWav(pchar(str))
    else
      Esound[i] := nil;
  end;
  for i := 0 to 99 do
  begin
    str := 'sound\Atk'+ format('%2d', [i]) + '.wav';
    if fileexists(str) then
      Asound[i] := Mix_LoadWav(pchar(str))
    else
      Asound[i] := nil;
  end;
end;        }

//�ȴ����ⰴ��

function WaitAnyKey: integer; overload;
begin
  //event.type_ := SDL_NOEVENT;
  event.key.keysym.sym := 0;
  event.button.button := 0;

  while (SDL_PollEvent(@event) > 0) do ; //�����Ϣ����

  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    if (event.type_ = SDL_KEYUP) or (event.type_ = SDL_MOUSEBUTTONUP) then
      if (event.key.keysym.sym <> 0) or (event.button.button <> 0) then
        break;
  end;
  Result := event.key.keysym.sym;
  event.key.keysym.sym := 0;
  event.button.button := 0;
end;

procedure WaitAnyKey(keycode, x, y: psmallint); overload;
begin
  //event.type_ := SDL_NOEVENT;
  event.key.keysym.sym := 0;
  event.button.button := 0;

  while (SDL_PollEvent(@event) > 0) do ; //�����Ϣ����

  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    if (event.type_ = SDL_KEYUP) and (event.key.keysym.sym <> 0) then
    begin
      keycode^ := event.key.keysym.sym;
      break;
    end;
    if (event.type_ = SDL_MOUSEBUTTONUP) and (event.button.button <> 0) then
    begin
      keycode^ := -1;
      x^ := event.button.x;
      y^ := event.button.y;
      y^ := y^ + 30;
      break;
    end;
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
end;
//����Ƿ��е�3���¼�, ���������

procedure CheckEvent3;
var
  enum: integer;
begin
  enum := SData[CurScene, 3, Sx, Sy];
  if (enum >= 0) and (DData[CurScene, enum, 4] > 0) and (IsEventActive(CurScene, enum)) and
    ((S_eventx <> Sx) and (S_eventy <> Sy)) then
  begin
    // saver(5);
    CurEvent := enum;
    //waitanykey;
    S_eventx := Sx; //�������ƾ������¼���ͣ��ʱ�����ظ�����
    S_eventy := Sy;
    nowstep := -1;
    CallEvent(DData[CurScene, enum, 4]);
    CurEvent := -1;
  end;
end;

//����mp3����

{procedure PlayMP3(MusicNum, times: integer); overload;
var
  i: integer;
  str: string;
begin

  // if MusicNum in [Low(Music)..High(Music)] then
   //  if Music[MusicNum] <> nil then
   //  begin
       //Music[i] := Mix_LoadMUS(pchar(str))
       //Music[i] := nil;
       //Mix_PlayMusic(Music[MusicNum], times, );
    // end;
  str := 'music\'+ inttostr(musicnum) + '.mp3';
  if fileexists(str) then
    Music := Mix_LoadMUS(pchar(str))
  else
    Music := nil;
  Mix_PlayMusic(Music, times);
  Mix_VolumeMusic(MusicVolume);

end; }

procedure InitialMusic;
var
  i: integer;
  str: string;
  sf: BASS_MIDI_FONT;
  Flag: longword;
begin
  BASS_Set3DFactors(1, 0, 0);
  sf.font := BASS_MIDI_FontInit(pchar(AppPath + 'music/mid.sf2'), 0);
  BASS_MIDI_StreamSetFonts(0, sf, 1);
  sf.preset := -1; // use all presets
  sf.bank := 0;
  Flag := 0;
  if SOUND3D = 1 then
    Flag := BASS_SAMPLE_3D or Flag;

  for i := low(Music) to high(Music) do
  begin
    str := AppPath + 'music/' + IntToStr(i) + '.mp3';
    if FileExists(pchar(str)) then
    begin
      try
        Music[i] := BASS_StreamCreateFile(False, pchar(str), 0, 0, 0);
      finally

      end;
    end
    else
    begin
      str := AppPath + 'music/' + IntToStr(i) + '.mid';
      if FileExists(pchar(str)) then
      begin
        try
          Music[i] := BASS_MIDI_StreamCreateFile(False, pchar(str), 0, 0, 0, 0);
          BASS_MIDI_StreamSetFonts(Music[i], sf, 1);
          //showmessage(inttostr(Music[i]));
        finally

        end;
      end
      else
        Music[i] := 0;
    end;
  end;

  for i := low(ESound) to high(ESound) do
  begin
    str := AppPath + formatfloat('sound/e000', i) + '.wav';
    if FileExists(pchar(str)) then
      ESound[i] := BASS_SampleLoad(False, pchar(str), 0, 0, 1, Flag)
    else
      ESound[i] := 0;
    //showmessage(inttostr(esound[i]));
  end;
  for i := low(ASound) to high(ASound) do
  begin
    str := AppPath + formatfloat('sound/atk000', i) + '.wav';
    if FileExists(pchar(str)) then
      ASound[i] := BASS_SampleLoad(False, pchar(str), 0, 0, 1, Flag)
    else
      ASound[i] := 0;
  end;

end;

procedure PlayMP3(MusicNum, times: integer); overload;
var
  repeatable: boolean;
  //nowmusic: HSTREAM;
begin
  if times = -1 then
    repeatable := True
  else
    repeatable := False;
  try
    if (MusicNum > -1) and (MusicNum < 1000) and (MusicVolume > 0) then
      if Music[MusicNum] <> 0 then
      begin
        //BASS_ChannelSlideAttribute(Music[nowmusic], BASS_ATTRIB_VOL, 0, 1000);
        if (MusicNum > -1) and (MusicNum < 1000) then
        begin
          BASS_ChannelStop(Music[nowmusic]);
          BASS_ChannelSetPosition(Music[nowmusic], 0, BASS_POS_BYTE);
        end;
        BASS_ChannelSetAttribute(Music[MusicNum], BASS_ATTRIB_VOL, MusicVolume / 100.0);
        if SOUND3D = 1 then
        begin
          //BASS_SetEAXParameters(EAX_ENVIRONMENT_UNDERWATER, -1, 0, 0);
          BASS_Apply3D();
        end;

        if repeatable then
          BASS_ChannelFlags(Music[MusicNum], BASS_SAMPLE_LOOP, BASS_SAMPLE_LOOP)
        else
          BASS_ChannelFlags(Music[MusicNum], 0, BASS_SAMPLE_LOOP);
        BASS_ChannelPlay(Music[MusicNum], repeatable);
        nowmusic := musicnum;
      end;
  finally

  end;

end;

//ֹͣ��ǰ���ŵ�����

procedure StopMP3;
begin
  //Mix_HaltMusic;
  if (nowmusic > -1) and (nowmusic < 1000) then
  begin
    BASS_ChannelStop(Music[nowmusic]);
  end;
end;

//����wav��Ч

{procedure PlaySound(SoundNum, times: integer); overload;
var
  i: integer;
  str: string;
begin

  str := 'sound\e'+ format('%3d', [SoundNum]) + '.wav';
  for i := 0 to length(str) - 1 do
    if str[i] = ''then str[i] := '0';
  if fileexists(str) then
    Esound := Mix_LoadWav(pchar(str))
  else
    Esound := nil;
  if Esound <> nil then
  begin
    Mix_VolumeChunk(Esound, SoundVolume);
    Mix_PlayChannel(-1, Esound, times);
  end;
end;

procedure PlaySound(SoundNum: integer); overload;
var
  i: integer;
  str: string;
begin
  str := 'sound\e'+ format('%3d', [SoundNum]) + '.wav';
  for i := 0 to length(str) - 1 do
    if str[i] = ''then str[i] := '0';

  if fileexists(str) then
    Esound := Mix_LoadWav(pchar(str))
  else
    Esound := nil;
  if Esound <> nil then
  begin
    Mix_VolumeChunk(Esound, SoundVolume);
    Mix_PlayChannel(-1, Esound, 0);
  end;

end;}

procedure PlaySoundE(SoundNum, times: integer); overload;
var
  ch: HCHANNEL;
  repeatable: boolean;
begin
  if times = -1 then
    repeatable := True
  else
    repeatable := False;
  if (SoundNum > -1) and (SoundNum < 1000) and (MusicVolume > 0) then
    if Esound[SoundNum] <> 0 then
    begin
      //Mix_VolumeChunk(Esound[SoundNum], Volume);
      //Mix_PlayChannel(-1, Esound[SoundNum], 0);
      BASS_SampleStop(Esound[soundnum]);
      ch := BASS_SampleGetChannel(Esound[soundnum], False);
      BASS_ChannelSetAttribute(ch, BASS_ATTRIB_VOL, MusicVolume / 100.0);
      if repeatable then
        BASS_ChannelFlags(ch, BASS_SAMPLE_LOOP, BASS_SAMPLE_LOOP)
      else
        BASS_ChannelFlags(ch, 0, BASS_SAMPLE_LOOP);
      BASS_ChannelPlay(ch, repeatable);
    end;

end;

procedure PlaySoundE(SoundNum: integer); overload;
begin
  PlaySoundE(Soundnum, 0);

end;

procedure PlaySoundE(SoundNum, times, x, y, z: integer); overload;
var
  ch: HCHANNEL;
  repeatable: boolean;
  pos, posvec, posvel: BASS_3DVECTOR;
  //��Դ��λ��, ����, �ٶ�
  //p: PSource;
begin
  if times = -1 then
    repeatable := True
  else
    repeatable := False;

  if (SoundNum > -1) and (SoundNum < 1000) and (MusicVolume > 0) then
    if Esound[SoundNum] <> 0 then
    begin
      //Mix_VolumeChunk(Esound[SoundNum], Volume);
      //Mix_PlayChannel(-1, Esound[SoundNum], 0);
      BASS_SampleStop(Esound[soundnum]);
      ch := BASS_SampleGetChannel(Esound[soundnum], False);
      //BASS_ChannelSet3DAttributes(ch, BASS_3DMODE_RELATIVE, -1, -1, -1, -1, -1);
      if ch = 0 then
        ShowMessage(IntToStr(BASS_ErrorGetCode));
      if SOUND3D = 1 then
      begin
        pos.x := x * 100;
        pos.y := y * 100;
        pos.z := z * 100;
        posvec.x := x;
        posvec.y := y;
        posvec.z := z;
        posvel.x := -x * 100;
        posvel.y := -y * 100;
        posvel.z := -z * 100;
        BASS_ChannelSet3DPosition(ch, pos, posvec, posvel);
        BASS_Apply3D();
      end;
      BASS_ChannelSetAttribute(ch, BASS_ATTRIB_VOL, MusicVolume / 100.0);
      if repeatable then
        BASS_ChannelFlags(ch, BASS_SAMPLE_LOOP, BASS_SAMPLE_LOOP)
      else
        BASS_ChannelFlags(ch, 0, BASS_SAMPLE_LOOP);
      BASS_ChannelPlay(ch, repeatable);
      //BASS_Apply3D();
    end;

end;

procedure PlaySoundA(SoundNum, times: integer);
var
  ch: HCHANNEL;
  repeatable: boolean;
begin
  if times = -1 then
    repeatable := True
  else
    repeatable := False;
  if (SoundNum > -1) and (SoundNum < 1000) and (MusicVolume > 0) then
    if Asound[SoundNum] <> 0 then
    begin
      //Mix_VolumeChunk(Esound[SoundNum], Volume);
      //Mix_PlayChannel(-1, Esound[SoundNum], 0);
      BASS_SampleStop(Esound[soundnum]);
      ch := BASS_SampleGetChannel(Asound[soundnum], False);
      BASS_ChannelSetAttribute(ch, BASS_ATTRIB_VOL, MusicVolume / 100.0);
      if repeatable then
        BASS_ChannelFlags(ch, BASS_SAMPLE_LOOP, BASS_SAMPLE_LOOP)
      else
        BASS_ChannelFlags(ch, 0, BASS_SAMPLE_LOOP);
      BASS_ChannelPlay(ch, repeatable);
    end;

end;
//��ȡĳ������Ϣ

function GetPixel(surface: PSDL_Surface; x: integer; y: integer): uint32;
begin
  if (x >= 0) and (x < screen.w) and (y >= 0) and (y < screen.h) then
  begin
    Result := puint32(uint32(surface.pixels) + y * surface.pitch + x * 4)^;
  end
  else
    Result := 0;
end;

//������

procedure PutPixel(surface_: PSDL_Surface; x: integer; y: integer; pixel: uint32);
begin
  if (x >= 0) and (x < screen.w) and (y >= 0) and (y < screen.h) then
  begin
    puint32(uint32(surface_.pixels) + y * surface_.pitch + x * 4)^ := pixel;
  end;
end;

//��һ����

procedure drawscreenpixel(x, y: integer; color: uint32);
begin
  PutPixel(screen, x, y, color);
  SDL_UpdateRect2(screen, x, y, 1, 1);
end;

//��ʾbmp�ļ�

procedure display_bmp(file_name: pchar; x, y: integer);
var
  image: PSDL_Surface;
  dest: TSDL_Rect;
begin
  if FileExists(file_name) then
  begin
    image := SDL_LoadBMP(file_name);
    if (image = nil) then
    begin
      MessageBox(0, pchar(Format('Couldn''t load %s : %s', [file_name, SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
      exit;
    end;
    dest.x := x;
    dest.y := y;
    image := sdl_displayformat(image);
    if (SDL_BlitSurface(image, nil, screen, @dest) < 0) then
      MessageBox(0, pchar(Format('BlitSurface error : %s', [SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
    //SDL_UpdateRect2(screen, 0, 0, image.w, image.h);
    SDL_FreeSurface(image);
  end;
end;

//��ʾtif, png, jpg�ȸ�ʽͼƬ

procedure display_img(file_name: pchar; x, y, x1, y1, w, h: integer); overload;
var
  image: PSDL_Surface;
  dest, dest1: TSDL_Rect;
begin
  if FileExists(file_name) then
  begin
    image := IMG_Load(file_name);
    if (image = nil) then
    begin
      MessageBox(0, pchar(Format('Couldn''t load %s : %s', [file_name, SDL_GetError])),
        'Error', MB_OK or MB_ICONHAND);
      exit;
    end;
    dest.x := x;
    dest.y := y;
    dest1.x := x1;
    dest1.y := y1;
    dest1.w := w;
    dest1.h := h;
    if (SDL_BlitSurface(image, @dest1, screen, @dest) < 0) then
      MessageBox(0, pchar(Format('BlitSurface error : %s', [SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
    //SDL_UpdateRect2(screen, 0, 0, image.w, image.h);
    SDL_FreeSurface(image);
  end;
end;

//��ʾtif, png, jpg�ȸ�ʽͼƬ

procedure display_imgFromSurface(image: PSDL_Surface; x, y, x1, y1, w, h: integer); overload;
var
  dest, dest1: TSDL_Rect;
begin

  if (image = nil) then
  begin
    exit;
  end;
  dest.x := x;
  dest.y := y;
  dest1.x := x1;
  dest1.y := y1;
  dest1.w := w;
  dest1.h := h;
  if (SDL_BlitSurface(image, @dest1, screen, @dest) < 0) then
    MessageBox(0, pchar(Format('BlitSurface error : %s', [SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
  //SDL_UpdateRect2(screen, 0, 0, image.w, image.h);
  //SDL_FreeSurface(image);

end;

procedure display_imgFromSurface(image: Tpic; x, y, x1, y1, w, h: integer); overload;
var
  dest, dest1: TSDL_Rect;
begin

  if (image.pic = nil) then
  begin
    exit;
  end;
  dest.x := x;
  dest.y := y;
  dest1.x := x1;
  dest1.y := y1;
  dest1.w := w;
  dest1.h := h;
  if (SDL_BlitSurface(image.pic, @dest1, screen, @dest) < 0) then
    MessageBox(0, pchar(Format('BlitSurface error : %s', [SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
  //SDL_UpdateRect2(screen, 0, 0, image.w, image.h);
  //SDL_FreeSurface(image);

end;

procedure display_img(file_name: pchar; x, y: integer); overload;
var
  image: PSDL_Surface;
  dest: TSDL_Rect;
begin
  if FileExists(file_name) then
  begin
    image := IMG_Load(file_name);
    if (image = nil) then
    begin
      MessageBox(0, pchar(Format('Couldn''t load %s : %s', [file_name, SDL_GetError])),
        'Error', MB_OK or MB_ICONHAND);
      exit;
    end;
    dest.x := x;
    dest.y := y;
    if (SDL_BlitSurface(image, nil, screen, @dest) < 0) then
      MessageBox(0, pchar(Format('BlitSurface error : %s', [SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
    //SDL_UpdateRect2(screen, 0, 0, image.w, image.h);
    SDL_FreeSurface(image);
  end;
end;

procedure display_imgFromSurface(image: PSDL_Surface; x, y: integer); overload;
var
  dest: TSDL_Rect;
begin
  if (image = nil) then
  begin
    exit;
  end;
  dest.x := x;
  dest.y := y;
  if (SDL_BlitSurface(image, nil, screen, @dest) < 0) then
    MessageBox(0, pchar(Format('BlitSurface error : %s', [SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
  //SDL_UpdateRect2(screen, 0, 0, image.w, image.h);
  //SDL_FreeSurface(image);
end;

procedure display_imgFromSurface(image: Tpic; x, y: integer); overload;
var
  dest: TSDL_Rect;
begin
  if (image.pic = nil) then
  begin
    exit;
  end;
  dest.x := x;
  dest.y := y;
  if (SDL_BlitSurface(image.pic, nil, screen, @dest) < 0) then
    MessageBox(0, pchar(Format('BlitSurface error : %s', [SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
  //SDL_UpdateRect2(screen, 0, 0, image.w, image.h);
  //SDL_FreeSurface(image);
end;

//ȡ��ɫ�����ɫ, ��Ƶϵͳ��32λɫ, ���ܶ�ʱ������Ҫԭ��ɫ�����ɫ

function ColColor(num: integer): uint32;
begin
  ColColor := SDL_MapRGB(screen.format, Acol[num * 3] * 4, Acol[num * 3 + 1] * 4, Acol[num * 3 + 2] * 4);
end;

function ColColor(colnum, num: integer): uint32;
begin
  ColColor := SDL_MapRGB(screen.format, col[colnum][num * 3] * 4, col[colnum][num * 3 + 1] *
    4, col[colnum][num * 3 + 2] * 4);
end;

//�ж������Ƿ�����Ļ��

function JudgeInScreen(px, py, w, h, xs, ys: integer): boolean; overload;
begin
  Result := False;
  if (px - xs + w >= 0) and (px - xs < screen.w) and (py - ys + h >= 0) and (py - ys < screen.h) then
    Result := True;

end;

//�ж������Ƿ���ָ����Χ��(����)

function JudgeInScreen(px, py, w, h, xs, ys, xx, yy, xw, yh: integer): boolean; overload;
begin
  Result := False;
  if (px - xs + w >= xx) and (px - xs < xx + xw) and (py - ys + h >= yy) and (py - ys < yy + yh) then
    Result := True;

end;
//RLE8ͼƬ�����ӳ̣���������ӳ̾��Դ˷�װ

//����һ�������������Ƿ����ʹ������
//0Ϊ���������֣�1Ϊ�������֣�2Ϊʹ������  ,3Ϊ������������

procedure DrawRLE8Pic(num, px, py: integer; Pidx: Pinteger; Ppic: PByte; RectArea: TRect;
  Image: pchar; shadow: integer; mask: integer = 0; maskvalue: smallint = 0); overload;
var
  w, h, xs, ys, x, y: smallint;
  os, offset, ix, iy, length, p, i1, i2, i, a, b: integer;
  l, l1: Byte;
  alphe, pix, pix1, pix2, pix3, pix4: uint32;
begin
  if (maskvalue = 0) and ((mask = 2) or (mask = 3)) then
    maskvalue := 1;
  if rs = 0 then
  begin
    randomcount := random(640);
  end;
  if num = 0 then
    offset := 0
  else
  begin
    Inc(Pidx, num - 1);
    offset := Pidx^;
  end;

  Inc(Ppic, offset);
  w := Psmallint((Ppic))^;
  Inc(Ppic, 2);
  h := Psmallint((Ppic))^;
  Inc(Ppic, 2);
  xs := Psmallint((Ppic))^ + 1;
  Inc(Ppic, 2);
  ys := Psmallint((Ppic))^ + 1;
  Inc(Ppic, 2);

  if (px - xs + w < rectarea.x) and (px - xs < rectarea.x) then exit;
  if (px - xs + w > rectarea.x + rectarea.w) and (px - xs > rectarea.x + rectarea.w) then exit;
  if (py - ys + h < rectarea.y) and (py - ys < rectarea.y) then exit;
  if (py - ys + h > rectarea.y + rectarea.h) and (py - ys > rectarea.y + rectarea.h) then exit;
  {if mask = 1 then
    for i1 := rectarea.x to rectarea.x + rectarea.w do
      for i2 := rectarea.y to rectarea.y + rectarea.h do
      begin
        MaskArray[i1, i2] := 0;
      end;}
  if JudgeInScreen(px, py, w, h, xs, ys, RectArea.x, RectArea.y, RectArea.w, RectArea.h) then
  begin
    for iy := 1 to h do
    begin
      l := Ppic^;
      Inc(Ppic, 1);
      w := 1;
      p := 0;
      for ix := 1 to l do
      begin
        l1 := Ppic^;
        Inc(Ppic);
        if p = 0 then
        begin
          w := w + l1;
          p := 1;
        end
        else if p = 1 then
        begin
          p := 2 + l1;
        end
        else if p > 2 then
        begin
          p := p - 1;
          x := w - xs + px;
          y := iy - ys + py;
          if (x >= RectArea.x) and (y >= RectArea.y) and (x < RectArea.x + RectArea.w) and
            (y < RectArea.y + RectArea.h) then
          begin
            if ((mask = 2) and (MaskArray[x, y] < maskvalue)) or ((mask = 3) and
              (MaskArray[x, y] <> 0)) or (mask = 0) or (mask = 1) then
            begin
              if mask = 1 then
              begin
                MaskArray[x, y] := maskvalue;
              end;
              if mask = 3 then
                MaskArray[x, y] := 0;
              if image = nil then
              begin
                pix := SDL_MapRGB(screen.format, ACol[l1 * 3] * (4 + shadow), ACol[l1 * 3 + 1] *
                  (4 + shadow), ACol[l1 * 3 + 2] * (4 + shadow));
                //    if mask = 1 then  pix :=$ffffff;
                if HighLight then
                begin
                  alphe := 50;
                  pix1 := pix and $FF;
                  pix2 := pix shr 8 and $FF;
                  pix3 := pix shr 16 and $FF;
                  pix4 := pix shr 24 and $FF;
                  pix1 := (alphe * $FF + (100 - alphe) * pix1) div 100;
                  pix2 := (alphe * $FF + (100 - alphe) * pix2) div 100;
                  pix3 := (alphe * $FF + (100 - alphe) * pix3) div 100;
                  pix4 := (alphe * $FF + (100 - alphe) * pix4) div 100;
                  pix := pix1 + pix2 shl 8 + pix3 shl 16 + pix4 shl 24;
                end
                else if Gray > 0 then
                begin
                  pix1 := pix and $FF;
                  pix2 := pix shr 8 and $FF;
                  pix3 := pix shr 16 and $FF;
                  pix4 := pix shr 24 and $FF;
                  pix := (pix1 * 11) div 100 + (pix2 * 59) div 100 + (pix3 * 3) div 10;
                  pix1 := ((100 - gray) * pix1 + gray * pix) div 100;
                  pix2 := ((100 - gray) * pix2 + gray * pix) div 100;
                  pix3 := ((100 - gray) * pix3 + gray * pix) div 100;
                  pix := pix1 + pix1 shl 8 + pix1 shl 16 + pix4 shl 24;
                end
                else if blue > 0 then
                begin
                  pix1 := (pix and $FF);
                  pix2 := ((pix shr 8 and $FF) * (150 - blue)) div 150;
                  pix3 := ((pix shr 16 and $FF) * (150 - blue)) div 150;
                  pix := pix1 + pix2 shl 8 + pix3 shl 16;
                end
                else if red > 0 then
                begin
                  pix1 := ((pix and $FF) * (150 - red)) div 150;
                  pix2 := ((pix shr 8 and $FF) * (150 - red)) div 150;
                  pix3 := (pix shr 16 and $FF);
                  pix := pix1 + pix2 shl 8 + pix3 shl 16;
                end
                else if green > 0 then
                begin
                  pix1 := ((pix and $FF) * (150 - green)) div 150;
                  pix2 := (pix shr 8 and $FF);
                  pix3 := ((pix shr 16 and $FF) * (150 - green)) div 150;
                  pix := pix1 + pix2 shl 8 + pix3 shl 16;
                end
                else if yellow > 0 then
                begin
                  pix1 := ((pix and $FF) * (150 - yellow)) div 150;
                  pix2 := (pix shr 8 and $FF);
                  pix3 := (pix shr 16 and $FF);
                  pix := pix1 + pix2 shl 8 + pix3 shl 16;
                end;
                if (showBlackScreen = True) and (where = 1) then
                begin
                  alphe := snowalpha[y, x];
                  if alphe >= 100 then pix := 0
                  else if alphe > 0 then
                  begin
                    pix1 := pix and $FF;
                    pix2 := pix shr 8 and $FF;
                    pix3 := pix shr 16 and $FF;
                    pix4 := pix shr 24 and $FF;
                    pix1 := ((100 - alphe) * pix1) div 100;
                    pix2 := ((100 - alphe) * pix2) div 100;
                    pix3 := ((100 - alphe) * pix3) div 100;
                    pix4 := ((100 - alphe) * pix4) div 100;
                    pix := pix1 + pix2 shl 8 + pix3 shl 16 + pix4 shl 24;
                  end;
                end;

                if (where = 1) and (water >= 0) then
                begin
                  os := (iy - ys + py + water div 3) mod 60;
                  os := snowalpha[0][os];
                  if os > 128 then os := os - 256;
                  PutPixel(screen, x + os, y, pix);

                  b := (i2 + water div 3) mod 60;

                  b := snowalpha[0][b];
                  if b > 128 then b := b - 256;

                end
                else if (where = 1) and (rain >= 0) then
                begin
                  b := ix + randomcount;
                  if b >= 640 then b := b - 640;
                  b := snowalpha[y][b];
                  alphe := 50;
                  if b = 1 then
                  begin
                    pix1 := pix and $FF;
                    pix2 := pix shr 8 and $FF;
                    pix3 := pix shr 16 and $FF;
                    pix4 := pix shr 24 and $FF;
                    pix1 := (alphe * $FF + (100 - alphe) * pix1) div 100;
                    pix2 := (alphe * $FF + (100 - alphe) * pix2) div 100;
                    pix3 := (alphe * $FF + (100 - alphe) * pix3) div 100;
                    pix4 := (alphe * $FF + (100 - alphe) * pix4) div 100;
                    pix := pix1 + pix2 shl 8 + pix3 shl 16 + pix4 shl 24;
                  end;
                  PutPixel(screen, x, y, pix);
                end
                else if (where = 1) and (snow >= 0) then
                begin
                  b := ix + randomcount;
                  if b >= 640 then b := b - 640;
                  b := snowalpha[iy - ys + py][b];
                  if b = 1 then pix := ColColor(255);
                  PutPixel(screen, x, y, pix);
                end
                else if (where = 1) and (fog) then
                begin
                  b := ix + randomcount;
                  if b >= 640 then b := b - 640;
                  alphe := snowalpha[y][b];
                  pix1 := pix and $FF;
                  pix2 := pix shr 8 and $FF;
                  pix3 := pix shr 16 and $FF;
                  pix4 := pix shr 24 and $FF;
                  pix1 := (alphe * $FF + (100 - alphe) * pix1) div 100;
                  pix2 := (alphe * $FF + (100 - alphe) * pix2) div 100;
                  pix3 := (alphe * $FF + (100 - alphe) * pix3) div 100;
                  pix4 := (alphe * $FF + (100 - alphe) * pix4) div 100;
                  pix := pix1 + pix2 shl 8 + pix3 shl 16 + pix4 shl 24;
                  PutPixel(screen, x, y, pix);
                end
                else
                  PutPixel(screen, x, y, pix);
              end
              else
                Pint(image + (x * 1402 + y) * 4)^ :=
                  SDL_MapRGB(screen.format, ACol[l1 * 3] * (4 + shadow), ACol[l1 * 3 + 1] *
                  (4 + shadow), ACol[l1 * 3 + 2] * (4 + shadow));
            end;
          end;
          w := w + 1;
          if p = 2 then
          begin
            p := 0;
          end;
        end;
      end;
    end;
  end;

end;


//��ȡ��Ϸ����������Ļ�ϵ�λ��

function GetPositionOnScreen(x, y, CenterX, CenterY: integer): TPosition;
begin
  Result.x := -(x - CenterX) * 18 + (y - CenterY) * 18 + CENTER_X;
  Result.y := (x - CenterX) * 9 + (y - CenterY) * 9 + CENTER_Y;
end;

//��ʾtitle.grp������(����ʼ��ѡ��)

procedure DrawTitlePic(imgnum, px, py: integer);
var
  len, grp, idx: integer;
  Area: TRect;
  BufferIdx: array[0..100] of integer;
  BufferPic: array[0..70000] of Byte;
begin
  grp := FileOpen('resource\title.grp', fmopenread);
  idx := FileOpen('resource\title.idx', fmopenread);

  len := FileSeek(idx, 0, 2);
  FileSeek(idx, 0, 0);
  FileRead(idx, BufferIdx[0], len);
  len := FileSeek(grp, 0, 2);
  FileSeek(grp, 0, 0);
  FileRead(grp, BufferPic[0], len);

  FileClose(grp);
  FileClose(idx);

  Area.x := 0;
  Area.y := 0;
  Area.w := screen.w;
  Area.h := screen.h;
  resetpallet;
  DrawRLE8Pic(imgnum, px, py, @BufferIdx[0], @BufferPic[0], Area, nil, 0);

end;

//��ʾ����ͼ��ͼ

procedure DrawMPic(num, px, py: integer; mask: integer = 0);
var
  Area: Trect;
begin
  Area.x := 0;
  Area.y := 0;
  Area.w := screen.w;
  Area.h := screen.h;
  if num < length(midx) then
    DrawRLE8Pic(num, px, py, @Midx[0], @Mpic[0], Area, nil, 0, mask);

end;

//��ʾ����ͼƬ


procedure DrawSPic(num, px, py, x, y, w, h: integer; mask: integer = 0); overload;
var
  Area: TRect;
begin
  Area.x := x;
  Area.y := y;
  Area.w := w;
  Area.h := h;
  if num < length(sidx) then
    DrawRLE8Pic(num, px, py, @SIdx[0], @SPic[0], Area, nil, 0, mask);

end;

procedure DrawSNewPic(num, px, py, x, y, w, h: integer; mask: integer);
var
  i1, i2, bpp, b, x1, y1, pix1, pix2, pix3, alpha, col1, col2, col3, pix: integer;
  image: pansichar;
  p: puint32;
  c: uint32;
begin

  if num >= 3 then
  begin
    b := 0;
    x1 := px - Scenepic[num].x + 1;
    y1 := py - Scenepic[num].y + 1;
    if (x1 + Scenepic[num].pic.w < x) and (x1 < x) then exit;
    if (x1 + Scenepic[num].pic.w > x + w) and (x1 > x + w) then exit;
    if (y1 + Scenepic[num].pic.h < y) and (y1 < y) then exit;
    if (y1 + Scenepic[num].pic.h > y + h) and (y1 > y + h) then exit;
    if mask = 1 then
      for i1 := x to x + w do
        for i2 := y to y + h do
        begin
          MaskArray[i1, i2] := 0;
        end;
    bpp := Scenepic[num].pic.format.BytesPerPixel;
    for i1 := 0 to Scenepic[num].pic.w - 1 do
      for i2 := 0 to Scenepic[num].pic.h - 1 do
      begin
        if ((x1 + i1) >= x) and ((x1 + i1) <= x + w) and (y1 + i2 >= y) and (y1 + i2 <= y + h) then
          if (MaskArray[x1 + i1, y1 + i2] = 1) or (Mask <= 0) then
          begin
            p := Pointer(uint32(Scenepic[num].pic.pixels) + i2 * Scenepic[num].pic.pitch + i1 * bpp);
            c := puint32(p)^;
            p := Pointer(uint32(screen.pixels) + (y1 + i2) * screen.pitch + (x1 + i1) * bpp);
            pix := puint32(p)^;

            pix1 := (pix shr 16) and $FF;
            pix2 := (pix shr 8) and $FF;
            pix3 := pix and $FF;
            alpha := (c shr 24) and $FF;
            col3 := (c shr 16) and $FF;
            col2 := (c shr 8) and $FF;
            col1 := c and $FF;

            if (where = 1) then
            begin
              if (Rscene[curscene].Pallet = 1) then //��ɫ��1
              begin
                col1 := (69 * col1) div 100;
                col2 := (73 * col2) div 100;
                col3 := (75 * col3) div 100;
              end
              else if (Rscene[curscene].Pallet = 2) then //��ɫ��2
              begin
                col1 := (85 * col1) div 100;
                col2 := (75 * col2) div 100;
                col3 := (30 * col3) div 100;
              end
              else if (Rscene[curscene].Pallet = 3) then //��ɫ��3
              begin
                col1 := (25 * col1) div 100;
                col2 := (68 * col2) div 100;
                col3 := (45 * col3) div 100;
              end;
            end;
            if (alpha = 0) and (Mask = 1) then MaskArray[x1 + i1, y1 + i2] := 1;

            pix1 := (alpha * col1 + (255 - alpha) * pix1) div 255;
            pix2 := (alpha * col2 + (255 - alpha) * pix2) div 255;
            pix3 := (alpha * col3 + (255 - alpha) * pix3) div 255;
            //   c := 0 ;

            p := Pointer(uint32(screen.pixels) + (y1 + i2) * screen.pitch + (x1 + i1) * bpp);

            if HighLight then //����
            begin
              alpha := 50;
              pix1 := (alpha * $FF + (255 - alpha) * pix1) div 100;
              pix2 := (alpha * $FF + (255 - alpha) * pix2) div 100;
              pix3 := (alpha * $FF + (255 - alpha) * pix3) div 100;
            end;

            if (showBlackScreen = True) and (where = 1) then //ɽ��
            begin
              // alpha := snowalpha[iy - ys + py][w - xs + px];
              alpha := snowalpha[y1 + i2][x1 + i1];
              if alpha >= 100 then pix := 0
              else if alpha > 0 then
              begin
                pix1 := ((100 - alpha) * pix1) div 100;
                pix2 := ((100 - alpha) * pix2) div 100;
                pix3 := ((100 - alpha) * pix3) div 100;
              end;
            end;
            if (where = 1) and (water >= 0) then //Ť��
            begin
              b := (y1 + i2 + water div 3) mod 60;
              b := snowalpha[0][b];
              if b > 128 then b := b - 256;

              p := Pointer(uint32(screen.pixels) + (y1 + i2) * screen.pitch + (x1 + i1 + b) * bpp);
              pix := puint32(p)^;

              pix1 := (pix shr 16) and $FF;
              pix2 := (pix shr 8) and $FF;
              pix3 := pix and $FF;

              pix1 := (alpha * col1 + (255 - alpha) * pix1) div 255;
              pix2 := (alpha * col2 + (255 - alpha) * pix2) div 255;
              pix3 := (alpha * col3 + (255 - alpha) * pix3) div 255;

            end
            else if (where = 1) and (rain >= 0) then //����
            begin
              b := i1 + randomcount;
              if b >= 640 then b := b - 640;
              b := snowalpha[i2 + y1][b];
              alpha := 50;
              if b = 1 then
              begin
                pix1 := (alpha * $FF + (100 - alpha) * pix1) div 100;
                pix2 := (alpha * $FF + (100 - alpha) * pix2) div 100;
                pix3 := (alpha * $FF + (100 - alpha) * pix3) div 100;
              end;
            end
            else if (where = 1) and (snow >= 0) then //��ѩ
            begin
              b := i1 + randomcount;
              if b >= 640 then b := b - 640;
              b := snowalpha[i2 + y1][b];
              if b = 1 then c := ColColor(255);
            end
            else if (where = 1) and (fog) then //����
            begin
              b := i1 + randomcount;
              if b >= 640 then b := b - 640;
              alpha := snowalpha[i2][b];
              pix1 := (alpha * $FF + (100 - alpha) * pix1) div 100;
              pix2 := (alpha * $FF + (100 - alpha) * pix2) div 100;
              pix3 := (alpha * $FF + (100 - alpha) * pix3) div 100;

            end;
            c := pix3 + pix2 shl 8 + pix1 shl 16;
            puint32(p)^ := c;

          end;
      end;
  end;

end;

function CalBlock(x, y: integer): smallint;
begin
  //Result := 128 * min(x, y) + abs(x - y);
  //Result := 8192 - (x - 64) * (x - 64) - (y - 64) * (y - 64);
  Result := 128 * (x + y) + y;
end;

//������ͼƬ��Ϣд��ӳ��

procedure InitialSPic(num, px, py, x, y, w, h: integer; mask: integer = 0);
var
  Area: TRect;
  i: integer;
  image: pansichar;
begin
  if x + w > 2303 then
    w := 2303 - x;
  if y + h > 1401 then
    h := 1401 - y;
  Area.x := x;
  Area.y := y;
  Area.w := w;
  Area.h := h;
  if num < length(sidx) then
    DrawRLE8Pic(num, px, py, @SIdx[0], @SPic[0], Area, @SceneImg[0], 0, mask);

end;

procedure InitNewPic(num, px, py, x, y, w, h: integer; mask: integer = 0);
var
  i1, i2, bpp, x1, y1, pix1, pix2, pix3, alpha, col1, col2, col3, pix: integer;
  image: pansichar;
  p: puint32;
  c: uint32;
begin
  if num >= 3 then
  begin
    x1 := px - Scenepic[num].x + 1;
    y1 := py - Scenepic[num].y + 1;
    if (x1 + Scenepic[num].pic.w < x) and (x1 < x) then exit;
    if (x1 + Scenepic[num].pic.w > x + w) and (x1 > x + w) then exit;
    if (y1 + Scenepic[num].pic.h < y) and (y1 < y) then exit;
    if (y1 + Scenepic[num].pic.h > y + h) and (y1 > y + h) then exit;
    bpp := Scenepic[num].pic.format.BytesPerPixel;
    for i1 := 0 to Scenepic[num].pic.w - 1 do
      for i2 := 0 to Scenepic[num].pic.h - 1 do
      begin
        if mask = 1 then MaskArray[x1 + i1, y1 + i2] := 0;
        if ((x1 + i1) >= x) and ((x1 + i1) <= x + w) and (y1 + i2 >= y) and (y1 + i2 <= y + h) then
          if (MaskArray[x1 + i1, y1 + i2] = 1) or (Mask < 2) then
          begin
            p := Pointer(uint32(Scenepic[num].pic.pixels) + i2 * Scenepic[num].pic.pitch + i1 * bpp);
            c := puint32(p)^;
            pix := SceneImg[i1 + x1, i2 + y1];
            if c and $FF000000 <> 0 then
            begin

              if mask = 1 then
              begin
                MaskArray[x1 + i1, y1 + i2] := 1;
                SceneImg[i1 + x1, i2 + y1] := 0;
                continue;
              end;
              pix1 := (pix shr 16) and $FF;
              pix2 := (pix shr 8) and $FF;
              pix3 := pix and $FF;
              alpha := (c shr 24) and $FF;
              col3 := (c shr 16) and $FF;
              col2 := (c shr 8) and $FF;
              col1 := c and $FF;
              if (where = 1) then
              begin
                if (Rscene[curscene].Pallet = 1) then //��ɫ��1
                begin
                  col1 := (69 * col1) div 100;
                  col2 := (73 * col2) div 100;
                  col3 := (75 * col3) div 100;
                end
                else if (Rscene[curscene].Pallet = 2) then //��ɫ��2
                begin
                  col1 := (85 * col1) div 100;
                  col2 := (75 * col2) div 100;
                  col3 := (30 * col3) div 100;
                end
                else if (Rscene[curscene].Pallet = 3) then //��ɫ��3
                begin
                  col1 := (25 * col1) div 100;
                  col2 := (68 * col2) div 100;
                  col3 := (45 * col3) div 100;
                end;
              end;
              pix1 := (alpha * col1 + (255 - alpha) * pix1) div 255;
              pix2 := (alpha * col2 + (255 - alpha) * pix2) div 255;
              pix3 := (alpha * col3 + (255 - alpha) * pix3) div 255;
              c := pix3 + pix2 shl 8 + pix1 shl 16;
              // c:=0;
              SceneImg[i1 + x1, i2 + y1] := c;
            end;
          end;
      end;
  end;

end;

//��ʾͷ��, ���ȿ���'.head\'Ŀ¼�µ�pngͼƬ

procedure DrawHeadPic(num, px, py: integer);
var
  len, grp, idx, b, bpp, i1, i2, x1, y1, pix, pix1, pix2, pix3, alpha, col, col1, col2, col3: integer;
  p: puint32;
  c: uint32;
  // Area: TRect;
  // str: string;
begin
  //DrawRectangle(px, py - 57, 57, 59, 0, colcolor(255), 0);

  b := 0;
  x1 := px - Head_Pic[num].x + 1;
  y1 := py - Head_Pic[num].y + 1;
  bpp := Head_Pic[num].pic.format.BytesPerPixel;
  for i1 := 0 to Head_Pic[num].pic.w - 1 do
    for i2 := 0 to Head_Pic[num].pic.h - 1 do
    begin
      if ((x1 + i1) >= 0) and ((x1 + i1) <= screen.w) and (y1 + i2 >= 0) and (y1 + i2 <= screen.h) then
      begin
        p := Pointer(uint32(Head_Pic[num].pic.pixels) + i2 * Head_Pic[num].pic.pitch + i1 * bpp);
        c := puint32(p)^;
        p := Pointer(uint32(screen.pixels) + (y1 + i2) * screen.pitch + (x1 + i1) * bpp);
        pix := puint32(p)^;

        pix1 := (pix shr 16) and $FF;
        pix2 := (pix shr 8) and $FF;
        pix3 := pix and $FF;
        alpha := (c shr 24) and $FF;
        col1 := (c shr 16) and $FF;
        col2 := (c shr 8) and $FF;
        col3 := c and $FF;

        //   c := 0 ;

        if Gray > 0 then
        begin
          c := (col1 * 11) div 100 + (col2 * 59) div 100 + (col3 * 3) div 10;
          col1 := ((100 - gray) * col1 + gray * c) div 100;
          col2 := ((100 - gray) * col2 + gray * c) div 100;
          col3 := ((100 - gray) * col3 + gray * c) div 100;
        end
        else if blue > 0 then
        begin
          col1 := col1;
          col2 := (col2 * (150 - blue)) div 150;
          col3 := (col3 * (150 - blue)) div 150;
        end
        else if red > 0 then
        begin
          col1 := (col1 * (150 - red)) div 150;
          col2 := (col2 * (150 - red)) div 150;
          col3 := (col3);
        end
        else if green > 0 then
        begin
          col1 := (col1 * (150 - green)) div 150;
          col2 := col2;
          col3 := (col3 * (150 - green)) div 150;
        end
        else if yellow > 0 then
        begin
          col1 := (col1 * (150 - yellow)) div 150;
          col2 := col2;
          col3 := col3;
        end;

        pix1 := (alpha * col3 + (255 - alpha) * pix1) div 255;
        pix2 := (alpha * col2 + (255 - alpha) * pix2) div 255;
        pix3 := (alpha * col1 + (255 - alpha) * pix3) div 255;

        c := pix3 + pix2 shl 8 + pix1 shl 16;
        puint32(p)^ := c;

      end;
    end;

end;

//��ʾս��ͼƬ


procedure DrawBPic(num, px, py, shadow: integer; mask: integer = 0); overload;
var
  Area: TRect;
begin
  Area.x := 0;
  Area.y := 0;
  Area.w := screen.w;
  Area.h := screen.h;
  if num < length(sidx) then
    DrawRLE8Pic(num, px, py, @SIdx[0], @SPic[0], Area, nil, shadow, mask);

end;

procedure DrawBPic(num, x, y, w, h, px, py, shadow: integer; mask: integer = 0); overload;
var
  Area: TRect;
begin
  Area.x := x;
  Area.y := y;
  Area.w := w;
  Area.h := h;
  if num < length(sidx) then
    DrawRLE8Pic(num, px, py, @SIdx[0], @SPic[0], Area, nil, shadow, mask);

end;

{�ɳ��ж�����һ֡����WMP
procedure DrawBRolePic(num, px, py, shadow, mask: integer); overload;
var
  Area: TRect;
begin
  Area.x := 0;
  Area.y := 0;
  Area.w := screen.w;
  Area.h := screen.h;
  if num < length(widx) then
    DrawRLE8Pic(num, px, py, @WIdx[0], @WPic[0], Area, nil, shadow, mask);

end;

procedure DrawBRolePic(num, x, y, w, h, px, py, shadow, mask: integer); overload;
var
  Area: TRect;
begin
  Area.x := x;
  Area.y := y;
  Area.w := w;
  Area.h := h;
  if num < length(widx) then
    DrawRLE8Pic(num, px, py, @WIdx[0], @WPic[0], Area, nil, shadow, mask);
end; }

//����ĳ������ʾս��ͼƬ

procedure DrawBPicInRect(num, px, py, shadow, x, y, w, h: integer);
var
  Area: TRect;
begin
  Area.x := x;
  Area.y := y;
  Area.w := w;
  Area.h := h;
  if num < length(sidx) then
    DrawRLE8Pic(num, px, py, @SIdx[0], @SPic[0], Area, nil, shadow);

end;

//��ս��ͼƬ����ӳ��

procedure InitialBPic(num, px, py: integer; mask: integer = 0; maskvalue: integer = 0); overload;
var
  Area: TRect;
begin
  Area.x := 0;
  Area.y := 0;
  Area.w := 2304;
  Area.h := 1402;
  if num < length(sidx) then
  begin
    DrawRLE8Pic(num, px, py, @SIdx[0], @SPic[0], Area, @BFieldImg[0], 0, mask, maskvalue);
  end;

end;

procedure InitialBPic(num, px, py, x, y, w, h, mask: integer); overload;
var
  Area: TRect;
  i: integer;
  image: pansichar;
begin
  if x + w > 2303 then
    w := 2303 - x;
  if y + h > 1151 then
    h := 1151 - y;
  Area.x := x;
  Area.y := y;
  Area.w := w;
  Area.h := h;
  if num < length(sidx) then
    DrawRLE8Pic(num, px, py, @SIdx[0], @SPic[0], Area, @BFieldImg[0], 0, mask);

end;

//big5תΪunicode

function Big5ToUnicode(str: pchar): WideString;
var
  len: integer;
begin
  len := MultiByteToWideChar(950, 0, pchar(str), -1, nil, 0);
  setlength(Result, len - 1);
  MultiByteToWideChar(950, 0, pchar(str), length(str), pWideChar(Result), len + 1);
  //result :=''+ result;

end;

function GBKToUnicode(str: pchar): WideString;
var
  len: integer;
  word: string;
begin
  //word := Simplified2Traditional(str);
  // len := MultiByteToWideChar(936, 0, PChar(word), -1, nil, 0);
  len := MultiByteToWideChar(936, 0, pchar(str), -1, nil, 0);
  setlength(Result, len - 1);
  MultiByteToWideChar(936, 0, pchar(str), length(str), pWideChar(Result), len + 1);

end;

//unicodeתΪbig5, ��������������

function UnicodeToBig5(str: pWideChar): string;
var
  len: integer;
begin
  len := WideCharToMultiByte(950, 0, pWideChar(str), -1, nil, 0, nil, nil);
  setlength(Result, len + 1);
  WideCharToMultiByte(950, 0, pWideChar(str), -1, pchar(Result), len + 1, nil, nil);

end;

function UnicodeToGBK(str: pWideChar): string;
var
  len: integer;
begin
  len := WideCharToMultiByte(936, 0, pWideChar(str), -1, nil, 0, nil, nil);
  setlength(Result, len + 1);
  WideCharToMultiByte(936, 0, pWideChar(str), -1, pchar(Result), len + 1, nil, nil);

end;

//��ʾunicode����

procedure DrawText(sur: PSDL_Surface; word: puint16; x_pos, y_pos: integer; color: uint32); overload;
begin
  DrawText(sur, word, x_pos, y_pos, 20, color);
end;

procedure DrawText(sur: PSDL_Surface; word: puint16; x_pos, y_pos, size: integer; color: uint32); overload;
var
  dest: TSDL_Rect;
  len, i, x, y, ax1, ax2: integer;
  pword: array[0..2] of uint16;
  words: string;
  c1, c2, c3, c4: integer;
  t: WideString;
begin
  //len := length(word);
  c3 := color and $FF;
  c2 := color shr 8 and $FF;
  c1 := color shr 16 and $FF;
  c4 := color shr 24 and $FF;
  ax1 := 10;
  ax2 := 20;
  if size = 18 then
  begin
    ax1 := 9;
    ax2 := 18;
  end;
  color := c1 + c2 shl 8 + c3 shl 16 + c4 shl 24;
  pword[0] := 32;
  pword[2] := 0;
  if SIMPLE = 1 then
  begin
    t := Traditional2Simplified(pWideChar(word));
    word := puint16(t);
  end;
  x := x_pos;
  dest.x := x_pos;
  while (word <> nil) and (word^ > 0) do
  begin
    pword[1] := word^;
    dest.x := x_pos - ax1;
    Inc(word);
    if pword[1] > 128 then
    begin
      if size = 18 then
      begin
        Text := TTF_RenderUNICODE_blended(font2, @pword[0], TSDL_Color(Color));
      end
      else
      begin
        Text := TTF_RenderUNICODE_blended(font, @pword[0], TSDL_Color(Color));
      end;
      //dest.x := x_pos;

      dest.y := y_pos;
      SDL_BlitSurface(Text, nil, sur, @dest);
      x_pos := x_pos + ax2;
    end
    else
    begin
      if (pword[1] = 42) then //�����*
      begin
        pword[1] := 0;
        x_pos := x;
        y_pos := y_pos + 19;
      end;
      if size = 18 then
      begin
        Text := TTF_RenderUNICODE_blended(engfont2, @pword[1], TSDL_Color(Color));

      end
      else
        Text := TTF_RenderUNICODE_blended(engfont, @pword[1], TSDL_Color(Color));
      dest.x := x_pos + ax1 - 3 * (20 - ax2);
      dest.y := y_pos + 4;
      SDL_BlitSurface(Text, nil, sur, @dest);

      x_pos := x_pos + ax1;
    end;
    SDL_FreeSurface(Text);
  end;
end;

//��ʾӢ��

procedure DrawEngText(sur: PSDL_Surface; word: puint16; x_pos, y_pos: integer; color: uint32);
var
  dest: TSDL_Rect;
  c1, c2, c3, c4: integer;
begin
  c3 := color and $FF;
  c2 := color shr 8 and $FF;
  c1 := color shr 16 and $FF;
  c4 := color shr 24 and $FF;
  color := c1 + c2 shl 8 + c3 shl 16 + c4 shl 24;
  Text := TTF_RenderUNICODE_blended(engfont, word, TSDL_Color(Color));
  dest.x := x_pos;
  dest.y := y_pos + 4;
  SDL_BlitSurface(Text, nil, sur, @dest);
  SDL_FreeSurface(Text);

end;

//��ʾunicode������Ӱ����, ����ͬ��������ʾ2��, ���1����

procedure DrawShadowText(word: puint16; x_pos, y_pos, size: integer; color1, color2: uint32); overload;
begin
  DrawText(screen, word, x_pos + 11, y_pos, size, color2);
  DrawText(screen, word, x_pos + 10, y_pos, size, color1);

end;

procedure DrawShadowText(word: puint16; x_pos, y_pos: integer; color1, color2: uint32); overload;
begin
  DrawText(screen, word, x_pos + 11, y_pos, 20, color2);
  DrawText(screen, word, x_pos + 10, y_pos, 20, color1);

end;
//��ʾӢ����Ӱ����

procedure DrawEngShadowText(word: puint16; x_pos, y_pos: integer; color1, color2: uint32);
begin
  DrawEngText(screen, word, x_pos + 11, y_pos, color2);
  DrawEngText(screen, word, x_pos + 10, y_pos, color1);

end;

//��ʾbig5����

procedure DrawBig5Text(sur: PSDL_Surface; str: pchar; x_pos, y_pos: integer; color: uint32);
var
  len: integer;
  words: WideString;
begin
  len := MultiByteToWideChar(950, 0, pchar(str), -1, nil, 0);
  setlength(words, len - 1);
  MultiByteToWideChar(950, 0, pchar(str), length(str), pWideChar(words), len + 1);
  //words := ''+ words;
  //words := Simplified2Traditional(words);
  DrawText(screen, @words[1], x_pos + 10, y_pos, color);

end;

//��ʾBig5��Ӱ����

procedure DrawBig5ShadowText(word: pchar; x_pos, y_pos: integer; color1, color2: uint32);

var
  len: integer;
  words: WideString;
begin
  len := MultiByteToWideChar(950, 0, pchar(word), -1, nil, 0);
  setlength(words, len - 1);
  MultiByteToWideChar(950, 0, pchar(word), length(word), pWideChar(words), len + 1);

  //words := ''+ words;
  //words := Simplified2Traditional(words);
  DrawText(screen, @words[1], x_pos + 11, y_pos, color2);
  DrawText(screen, @words[1], x_pos + 10, y_pos, color1);

end;

//��ʾGBK����

procedure DrawGBKText(sur: PSDL_Surface; str: pchar; x_pos, y_pos: integer; color: uint32);
var
  len: integer;
  words: WideString;
begin
  words := gbktounicode(str);
  DrawText(screen, @words[1], x_pos + 10, y_pos, color);

end;

//��ʾGBK��Ӱ����

procedure DrawGBKShadowText(word: pchar; x_pos, y_pos: integer; color1, color2: uint32);
var
  len: integer;
  words: WideString;
begin
  words := gbktounicode(word);
  DrawText(screen, @words[1], x_pos + 11, y_pos, color2);
  DrawText(screen, @words[1], x_pos + 10, y_pos, color1);
end;

//��ʾ���߿������, ������unicode, ���Զ������

procedure DrawTextWithRect(word: puint16; x, y, w: integer; color1, color2: uint32);
var
  len: integer;
  p: pchar;
begin
  DrawRectangle(x, y, w, 28, 0, ColColor(0, 255), 30);
  DrawShadowText(word, x - 17, y + 2, color1, color2);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

//����

procedure DrawLine(x1, y1, x2, y2, color, Width: integer);
var
  i, x, y, p, w: integer;
begin
  if x1 > x2 then
  begin
    x := x1;
    x1 := x2;
    x2 := x;
    y := y1;
    y1 := y2;
    y2 := y;
  end;
  x := x2 - x1 - Width;
  y := y2 - y1 - Width;
  if x > 0 then
  begin
    for i := 0 to x - 1 do
    begin
      p := (y * i) div x;
      DrawRectangleWithoutFrame(x1 + i, y1 + p, Width, Width, color, 100);
    end;
  end
  else if y > 0 then
  begin
    for i := 0 to y - 1 do
    begin
      p := (x * i) div y;
      DrawRectangleWithoutFrame(x1 + i, y1 + p, Width, Width, color, 100);
    end;
  end
  else
  begin
    DrawRectangleWithoutFrame(x1 + i, y1 + p, Width, Width, color, 100);
  end;
end;

//�����߿����, (x����, y����, ��, ��, �ڲ���ɫ, �߿���ɫ, ͸����)

procedure DrawRectangle(x, y, w, h: integer; colorin, colorframe: uint32; alpha: integer);
var
  i1, i2, l1, l2, l3, l4: integer;
  tempscr: PSDL_Surface;
  dest: TSDL_Rect;
  r, g, b, r1, g1, b1, a: byte;
begin
  if (w > 0) and (h > 0) then
  begin
    tempscr := SDL_CreateRGBSurface(screen.flags or SDL_SRCALPHA, w + 1, h + 1, 32, RMask, GMask, BMask, AMask);
    SDL_GetRGB(colorin, tempscr.format, @r, @g, @b);
    SDL_GetRGB(colorframe, tempscr.format, @r1, @g1, @b1);
    SDL_FillRect(tempscr, nil, SDL_MapRGBA(tempscr.format, r, g, b, alpha * 255 div 100));
    dest.x := x;
    dest.y := y;
    dest.w := 0;
    dest.h := 0;
    for i1 := 0 to w do
      for i2 := 0 to h do
      begin
        l1 := i1 + i2;
        l2 := -(i1 - w) + (i2);
        l3 := (i1) - (i2 - h);
        l4 := -(i1 - w) - (i2 - h);
        //4�߽�
        if not ((l1 >= 4) and (l2 >= 4) and (l3 >= 4) and (l4 >= 4)) then
        begin
          PutPixel(tempscr, i1, i2, 0);
        end;
        //����
        if (((l1 >= 4) and (l2 >= 4) and (l3 >= 4) and (l4 >= 4) and ((i1 = 0) or (i1 = w) or
          (i2 = 0) or (i2 = h))) or ((l1 = 4) or (l2 = 4) or (l3 = 4) or (l4 = 4))) then
        begin
          //a := round(200 - min(abs(i1/w-0.5),abs(i2/h-0.5))*2 * 100);
          a := round(250 - abs(i1 / w + i2 / h - 1) * 150);
          PutPixel(tempscr, i1, i2, SDL_MapRGBA(tempscr.format, r1, g1, b1, a));
        end;
      end;
    SDL_BlitSurface(tempscr, nil, screen, @dest);
    SDL_FreeSurface(tempscr);
  end;

end;

//�������߿�ľ���, ���ڶԻ��ͺ���

procedure DrawRectangleWithoutFrame(x, y, w, h: integer; colorin: uint32; alpha: integer);
var
  tempscr: PSDL_Surface;
  dest: TSDL_Rect;
begin
  if (w > 0) and (h > 0) then
  begin
    tempscr := SDL_CreateRGBSurface(screen.flags, w, h, 32, 0, 0, 0, 0);
    SDL_FillRect(tempscr, nil, colorin);
    SDL_SetAlpha(tempscr, SDL_SRCALPHA, alpha * 255 div 100);
    dest.x := x;
    dest.y := y;
    SDL_BlitSurface(tempscr, nil, screen, @dest);
    SDL_FreeSurface(tempscr);
  end;
end;

//�ػ���Ļ, SDL_UpdateRect2(screen,0,0,screen.w,screen.h)����ʾ

procedure Redraw;
var
  i: integer;
begin

  case where of
    0: DrawMMap;
    1: DrawScene;
    2: DrawBField;
    3: display_imgfromSurface(BEGIN_PIC.pic, 0, 0);
    4: display_imgfromSurface(DEATH_PIC.pic, 0, 0);
  end;
  if RShowpic.repeated > 0 then
  begin
    dec(RShowpic.repeated);
    case RShowpic.tp of
        0:
        begin
          if where <> 0 then
          begin
            if RShowpic.pnum > 0 then
              DrawSPic(RShowpic.pnum div 2, RShowpic.x, RShowpic.y, 0, 0, screen.w, screen.h)
            else
              DrawSNewPic(-RShowpic.pnum div 2, RShowpic.x, RShowpic.y, 0, 0, screen.w, screen.h, 0);
          end
          else DrawMPic(RShowpic.pnum div 2, RShowpic.x, RShowpic.y, 0);
        end;
        1: DrawHeadPic(RShowpic.pnum, RShowpic.x, RShowpic.y);
        2: DrawItemPic(RShowpic.pnum, RShowpic.x, RShowpic.y);
      end;
  end;  
end;

//��ʾ����ͼ��������Ļ

procedure DrawMMap;
var
  i1, i2, i, sum, x, y, k, c, widthregion, sumregion, num, h, MPicAmount: integer;
  //temp: array[0..479, 0..479] of smallint;
  Width, Height, xoffset, yoffset: smallint;
  pos: TPosition;
  BuildArray: array[0..2000] of TBuildInfo;
  tempb: TBuildInfo;
  tempscr, tempscr1: PSDL_Surface;
  dest: TSDL_Rect;
begin
  //���ϵ��»���, �Ȼ��Ƶ���ͱ���, ͬʱ������ֵĽ�����
  k := 0;
  h := High(BuildArray);
  MPicAmount := High(MIdx);
  widthregion := CENTER_X div 36 + 3;
  sumregion := CENTER_Y div 9 + 2;
  for sum := -sumregion to sumregion + 15 do
    for i := -Widthregion to Widthregion do
    begin
      if k >= h then
        break;
      i1 := Mx + i + (sum div 2);
      i2 := My - i + (sum - sum div 2);
      Pos := GetPositionOnScreen(i1, i2, Mx, My);
      if (i1 >= 0) and (i1 < 480) and (i2 >= 0) and (i2 < 480) then
      begin
        DrawMPic(earth[i1, i2] div 2, pos.x, pos.y);
        if surface[i1, i2] > 0 then
          DrawMPic(surface[i1, i2] div 2, pos.x, pos.y);
        num := building[i1, i2] div 2;
        //�����ǺͿմ���λ�ü��뽨��
        if (i1 = Mx) and (i2 = My) then
        begin
          if (InShip = 0) then
          begin
            if still = 0 then
              num := 5001 + MFace * 7 + MStep
            else
              num := 5028 + Mface * 6 + MStep;
          end
          else
          begin
            num := 3714 + MFace * 4 + (MStep + 1) div 2;
          end;
        end;
        if (i1 = shipy) and (i2 = shipx) then
        begin
          if (InShip = 0) then
          begin
            num := 3715 + ShipFace * 4;
          end;
        end;
        if (num > 0) and (num < MPicAmount) then
        begin
          BuildArray[k].x := i1;
          BuildArray[k].y := i2;
          BuildArray[k].b := num;
          Width := SmallInt(Mpic[MIdx[num - 1]]);
          Height := SmallInt(Mpic[MIdx[num - 1] + 2]);
          yoffset := SmallInt(Mpic[MIdx[num - 1] + 6]);
          xoffset := SmallInt(Mpic[MIdx[num - 1] + 4]);
          //����ͼƬ�Ŀ��ȼ���ͼ���е���������Ϊ��������
          //y����Ϊ�ڶ�����
          //BuildArray[k].c := (i1 + i2) - (Width + 35) div 36 - (yoffset - Height + 1) div 9;
          BuildArray[k].c := ((i1 + i2) - (Width + 35) div 36 - (yoffset - Height + 1) div 9) * 1024 + i2;
          if (i1 = Mx) and (i2 = My) then
            BuildArray[k].c := (i1 + i2) * 1024 + i2;
          k := k + 1;
        end;
      end
      else
        DrawMPic(0, pos.x, pos.y);
    end;
  QuickSortB(BuildArray, 0, k - 1);
  for i := 0 to k - 1 do
  begin
    Pos := GetPositionOnScreen(BuildArray[i].x, BuildArray[i].y, Mx, My);
    DrawMPic(BuildArray[i].b, pos.x, pos.y);
  end;
  drawdate;
  if (tipsstring <> '') then
  begin
    //drawshadowtext(@tipsstring[1], tipsx , tipsy, colcolor($5), colcolor($7));
    DrawRectangleWithoutFrame(0, tipsy - 1, screen.w, 24, 0, 30);
    DrawText(screen, @tipsstring[1], tipsx, tipsy, ColColor($5));
  end;

end;

procedure QuickSortB(var a: array of TBuildInfo; l, r: integer);
var
  i, j: integer;
  x, t: TBuildInfo;
begin
  i := l;
  j := r;
  x := a[(l + r) div 2];
  repeat
    while a[i].c < x.c do Inc(i);
    while a[j].c > x.c do Dec(j);
    if i <= j then
    begin
      t := a[i];
      a[i] := a[j];
      a[j] := t;
      Inc(i);
      Dec(j);
    end;
  until i > j;
  if i < r then
    QuickSortB(a, i, r);
  if l < j then
    QuickSortB(a, l, j);
end;


//����������Ļ

procedure DrawScene;
var
  i1, i2, x, y, xpoint, ypoint: integer;
  dest: TSDL_Rect;
  word, worddate: WideString;
begin
  //�Ȼ������ǵĳ���, �ٻ�����
  //�����¼���, ����Cx, CyΪ����, ��������������Ϊ����
  if (CurEvent < 0) then
  begin
    DrawSceneWithoutRole(Sx, Sy);
    DrawRoleOnScene(Sx, Sy);
  end
  else
  begin
    DrawSceneWithoutRole(Cx, Cy);
    if (DData[CurScene, CurEvent, 10] = Sx) and (DData[CurScene, CurEvent, 9] = Sy) then
    begin
      if (DData[CurScene, CurEvent, 4] <> BEGIN_EVENT) then
      begin
        DrawRoleOnScene(Cx, Cy);
      end;
    end
    else DrawRoleOnScene(Cx, Cy);
  end;
  drawdate;
  if (tipsstring <> '') then
  begin
    //drawshadowtext(@tipsstring[1], tipsx , tipsy, colcolor($5), colcolor($7));
    DrawRectangleWithoutFrame(0, tipsy - 1, screen.w, 24, 0, 30);
    DrawText(screen, @tipsstring[1], tipsx, tipsy, ColColor($5));
  end;
  //SDL_UpdateRect2(screen, 0,0,screen.w,screen.h);
  if time > 0 then
  begin
    word := formatfloat('0', time div 60) + ':' + formatfloat('00', time mod 60);
    DrawShadowText(@word[1], 5, 5, ColColor(0, 5), ColColor(0, 7));
  end;

end;


//���������ǵĳ���(��DrawSceneByCenter��ͬ)

procedure DrawSceneWithoutRole(x, y: integer);
var
  i1, i2, xpoint, ypoint: integer;
begin
  loadScenePart(-x * 18 + y * 18 + 1151 - CENTER_X, x * 9 + y * 9 + 259 - CENTER_Y);
  //SDL_UpdateRect2(screen, 0,0,screen.w,screen.h);
end;

//�������ڳ���

procedure DrawRoleOnScene(x, y: integer);
var
  i1, i2, xpoint, ypoint, i, rolenum: integer;
  pos, pos1: TPosition;
  rect1, rect2: TSDL_Rect;
  col1, col2, col3, alpha, pix1, pix2, pix3, pix, pix4: cardinal;
begin
  if ShowMR then
  begin
    pos := GetPositionOnScreen(Sx, Sy, x, y);
    DrawSPic(5001 + SFace * 7 + SStep, pos.x, pos.y - SData[CurScene, 4, Sx, Sy], pos.x - 20,
      pos.y - 60 - SData[CurScene, 4, Sx, Sy], 40, 60, 1);

    //�ػ����Ǹ����Ĳ���, �����ڵ�
    //���¼����޸߶ȵ��治������κζ����ǵ��ڵ�

    for i1 := 0 to 63 do
      for i2 := 0 to 63 do
      begin
        pos1 := GetPositionOnScreen(i1, i2, x, y);
        if (i1 in [0..63]) and (i2 in [0..63]) then
        begin
          if (SData[CurScene, 0, i1, i2] > 0) then
            DrawSPic(SData[CurScene, 0, i1, i2] div 2, pos1.x, pos1.y, pos.x - 20, pos.y -
              60 - SData[CurScene, 4, Sx, Sy], 40, 60, 2)
          else if (SData[CurScene, 0, i1, i2] < 0) then
            DrawSNewPic(-SData[CurScene, 0, i1, i2] div 2, pos1.x, pos1.y, pos.x - 20, pos.y -
              60 - SData[CurScene, 4, Sx, Sy], 40, 60, 2);

          if (SData[CurScene, 1, i1, i2] > 0) then
            DrawSPic(SData[CurScene, 1, i1, i2] div 2, pos1.x, pos1.y - SData[CurScene, 4, i1, i2],
              pos.x - 20, pos.y - 60 - SData[CurScene, 4, Sx, Sy], 40, 60, 2)
          else if (SData[CurScene, 1, i1, i2] < 0) then
            DrawSNewPic(-SData[CurScene, 1, i1, i2] div 2, pos1.x, pos1.y - SData[CurScene, 4, i1, i2],
              pos.x - 20, pos.y - 60 - SData[CurScene, 4, Sx, Sy], 40, 60, 2);
          if (i1 = Sx) and (i2 = Sy) then
            DrawSPic(5001 + SFace * 7 + SStep, pos1.x, pos1.y - SData[CurScene, 4, i1, i2],
              pos.x - 20, pos.y - 60 - SData[CurScene, 4, Sx, Sy], 40, 60, 1);

          if (SData[CurScene, 2, i1, i2] > 0) then
            DrawSPic(SData[CurScene, 2, i1, i2] div 2, pos1.x, pos1.y - SData[CurScene, 5, i1, i2],
              pos.x - 20, pos.y - 60 - SData[CurScene, 4, Sx, Sy], 40, 60, 2)
          else if (SData[CurScene, 2, i1, i2] < 0) then
            DrawSNewPic(-SData[CurScene, 2, i1, i2] div 2, pos1.x, pos1.y - SData[CurScene, 5, i1, i2],
              pos.x - 20, pos.y - 60 - SData[CurScene, 4, Sx, Sy], 40, 60, 2);
          if (SData[CurScene, 3, i1, i2] >= 0) and IsEventActive(CurScene, SData[CurScene, 3, i1, i2]) then
          begin
            if (DData[CurScene, SData[CurScene, 3, i1, i2], 5] > 0) then
              DrawSPic(DData[CurScene, SData[CurScene, 3, i1, i2], 5] div 2, pos1.x, pos1.y -
                SData[CurScene, 4, i1, i2], pos.x - 20, pos.y - 60 - SData[CurScene, 4, Sx, Sy], 40, 60, 2);
            if (DData[CurScene, SData[CurScene, 3, i1, i2], 5] < 0) then
              DrawSNewPic(-DData[CurScene, SData[CurScene, 3, i1, i2], 5] div 2, pos1.x,
                pos1.y - SData[CurScene, 4, i1, i2], pos.x - 20, pos.y - 60 - SData[CurScene, 4, Sx, Sy], 40, 60, 2);
          end;

        end;
      end;
  end;

end;




//Save the image informations of the whole Scene.
//���ɳ���ӳ��

procedure InitialScene();
var
  i1, i2, i, r, x, y: integer;
  pos: TPosition;
  c: cardinal;
  map: PSDL_Surface;
  bpp: integer;
  p: PInteger;
  str: string;
begin
  FillChar(SceneImg, SizeOf(SceneImg), 0);
  FillChar(MaskArray, SizeOf(MaskArray), 0);
  setscene();

  //��������ͼ��˳��ӦΪ�����廭���޸߶ȵĵ���㣬�ٽ���������һ�𻭳�
  //����ʹ�õ�˳�������ǽ�ڸ���������������ڵ����ڻ�ͼ��Ӧ������������״��
  //����ʹ�ø�������3D��˳��
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      x := -i1 * 18 + i2 * 18 + 1151;
      y := i1 * 9 + i2 * 9 + 9 + 250;
      if SData[CurScene, 0, i1, i2] > 0 then
        InitialSPic(SData[CurScene, 0, i1, i2] div 2, x, y, 0, 0, 2304, 1402)
      else if SData[CurScene, 0, i1, i2] < 0 then
        InitNewPic(-SData[CurScene, 0, i1, i2] div 2, x, y, 0, 0, 2304, 1402);

      if (SData[CurScene, 1, i1, i2] > 0) then
        InitialSPic(SData[CurScene, 1, i1, i2] div 2, x, y - SData[CurScene, 4, i1, i2], 0, 0, 2304, 1402)
      else if SData[CurScene, 1, i1, i2] < 0 then
        InitNewPic(-SData[CurScene, 1, i1, i2] div 2, x, y - SData[CurScene, 4, i1, i2], 0, 0, 2304, 1402);

      if (SData[CurScene, 2, i1, i2] > 0) then
        InitialSPic(SData[CurScene, 2, i1, i2] div 2, x, y - SData[CurScene, 5, i1, i2], 0, 0, 2304, 1402)
      else if (SData[CurScene, 2, i1, i2] < 0) then
        InitNewPic(-SData[CurScene, 2, i1, i2] div 2, x, y - SData[CurScene, 5, i1, i2], 0, 0, 2304, 1402);

      if (SData[CurScene, 3, i1, i2] >= 0) and IsEventActive(CurScene, SData[CurScene, 3, i1, i2]) then
      begin
        if DData[CurScene, SData[CurScene, 3, i1, i2], 7] > 0 then
          DData[CurScene, SData[CurScene, 3, i1, i2], 5] := DData[CurScene, SData[CurScene, 3, i1, i2], 7];

        //���øô��¼���������ͼ
        {if DData[CurScene, SData[CurScene, 3, i1, i2], 0] >= 10 then
        begin
          if Rrole[DData[CurScene, SData[CurScene, 3, i1, i2], 0] div 10].Impression>0 then
            DData[CurScene, SData[CurScene, 3, i1, i2], 5] := Rrole[DData[CurScene, SData[CurScene, 3, i1, i2], 0] div 10].Impression*2 ;
        end;  }
        if (DData[CurScene, SData[CurScene, 3, i1, i2], 5] > 0) then
          InitialSPic(DData[CurScene, SData[CurScene, 3, i1, i2], 5] div 2, x, y -
            SData[CurScene, 4, i1, i2], 0, 0, 2304, 1402);

        if DData[CurScene, SData[CurScene, 3, i1, i2], 7] < 0 then
          DData[CurScene, SData[CurScene, 3, i1, i2], 5] := DData[CurScene, SData[CurScene, 3, i1, i2], 7];
        if (DData[CurScene, SData[CurScene, 3, i1, i2], 5] < 0) then
          InitNewPic(-DData[CurScene, SData[CurScene, 3, i1, i2], 5] div 2, x, y -
            SData[CurScene, 4, i1, i2], 0, 0, 2304, 1402);

      end;
    end;

end;

//���ĳ���ӳ��, ���ڶ���, �����ڶ�̬Ч��

procedure UpdateScene(xs, ys, oldPic, newpic: integer);
var
  i1, i2, x, y: integer;
  num, offset: integer;
  xp, yp, xp1, yp1, xp2, yp2, w2, w1, h1, h2, w, h: smallint;
begin

  x := -xs * 18 + ys * 18 + 1151;
  y := xs * 9 + ys * 9 + 9 + 250;

  oldpic := oldpic div 2;
  newpic := newpic div 2;
  if oldpic > 0 then
  begin
    offset := SIdx[oldpic - 1];
    xp1 := x - (SPic[offset + 4] + 256 * SPic[offset + 5]);
    yp1 := y - (SPic[offset + 6] + 256 * SPic[offset + 7]) - SData[CurScene, 4, xs, ys];
    w1 := (SPic[offset] + 256 * SPic[offset + 1]);
    h1 := (SPic[offset + 2] + 256 * SPic[offset + 3]);
    //  InitialSPic(oldpic , x, y,  xp, yp, w, h, 1);
  end
  else if oldpic < -1 then
  begin
    xp1 := x - scenepic[-oldpic].x;
    yp1 := y - scenepic[-oldpic].y - SData[CurScene, 4, xs, ys];
    w1 := scenepic[-oldpic].pic.w;
    h1 := scenepic[-oldpic].pic.h;
    // InitNewPic(oldpic , x, y, 0, 0, scenepic[-oldpic].pic.w, scenepic[-oldpic].pic.h, 1);
  end
  else
  begin
    xp1 := x;
    yp1 := y - SData[CurScene, 4, xs, ys];
    w1 := 0;
    h1 := 0;
  end;

  if newpic > 0 then
  begin
    offset := SIdx[newpic - 1];
    xp2 := x - (SPic[offset + 4] + 256 * SPic[offset + 5]);
    yp2 := y - (SPic[offset + 6] + 256 * SPic[offset + 7]) - SData[CurScene, 4, xs, ys];
    w2 := (SPic[offset] + 256 * SPic[offset + 1]);
    h2 := (SPic[offset + 2] + 256 * SPic[offset + 3]);
    //  InitialSPic(oldpic , x, y,  xp, yp, w, h, 1);
  end
  else if newpic < -1 then
  begin
    xp2 := x - scenepic[-newpic].x;
    yp2 := y - scenepic[-newpic].y - SData[CurScene, 4, xs, ys];
    w2 := scenepic[-newpic].pic.w;
    h2 := scenepic[-newpic].pic.h;
    //  InitNewPic(oldpic , x, y, 0, 0, scenepic[-oldpic].pic.w, scenepic[-oldpic].pic.h, 1);
  end
  else
  begin
    xp2 := x;
    yp2 := y - SData[CurScene, 4, xs, ys];
    w2 := 0;
    h2 := 0;
  end;
  xp := min(xp2, xp1) - 1;
  yp := min(yp2, yp1) - 1;
  w := max(xp2 + w2, xp1 + w1) + 3 - xp;
  h := max(yp2 + h2, yp1 + h1) + 3 - yp;

  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      x := -i1 * 18 + i2 * 18 + 1151;
      y := i1 * 9 + i2 * 9 + 259;
      if SData[CurScene, 0, i1, i2] > 0 then
        InitialSPic(SData[CurScene, 0, i1, i2] div 2, x, y, xp, yp, w, h, 0)
      else if SData[CurScene, 0, i1, i2] < 0 then
        InitNewPic(-SData[CurScene, 0, i1, i2] div 2, x, y, xp, yp, w, h, 0);

      if (SData[CurScene, 1, i1, i2] > 0) then
        InitialSPic(SData[CurScene, 1, i1, i2] div 2, x, y - SData[CurScene, 4, i1, i2], xp, yp, w, h, 0)
      else if SData[CurScene, 1, i1, i2] < 0 then
        InitNewPic(-SData[CurScene, 1, i1, i2] div 2, x, y - SData[CurScene, 4, i1, i2], xp, yp, w, h, 0);

      if (SData[CurScene, 2, i1, i2] > 0) then
        InitialSPic(SData[CurScene, 2, i1, i2] div 2, x, y - SData[CurScene, 5, i1, i2], xp, yp, w, h, 0)
      else if (SData[CurScene, 2, i1, i2] < 0) then
        InitNewPic(-SData[CurScene, 2, i1, i2] div 2, x, y - SData[CurScene, 5, i1, i2], xp, yp, w, h, 0);

      if (SData[CurScene, 3, i1, i2] >= 0) and IsEventActive(CurScene, SData[CurScene, 3, i1, i2]) then
      begin
        if (DData[CurScene, SData[CurScene, 3, i1, i2], 5] > 0) then
          InitialSPic(DData[CurScene, SData[CurScene, 3, i1, i2], 5] div 2, x, y -
            SData[CurScene, 4, i1, i2], xp, yp, w, h, 0);
        if (DData[CurScene, SData[CurScene, 3, i1, i2], 5] < 0) then
          InitNewPic(-DData[CurScene, SData[CurScene, 3, i1, i2], 5] div 2, x, y -
            SData[CurScene, 4, i1, i2], xp, yp, w, h, 0);
      end;
    end;
end;

//������ӳ�񻭵���Ļ

procedure LoadScenePart(x, y: integer);
var
  i1, i2, a, b: integer;
  alphe, pix, pix1, pix2, pix3, pix4: uint32;
begin
  LT.x := x;
  LT.y := y;
  if rs = 0 then
  begin
    randomcount := random(640);
  end;
  for i1 := 0 to screen.w - 1 do
    for i2 := 0 to screen.h - 1 do
    begin
      pix := Sceneimg[x + i1, y + i2];
      if water >= 0 then
      begin
        b := (i2 + water div 3) mod 60;

        b := snowalpha[0][b];
        if b > 128 then b := b - 256;

        pix := Sceneimg[x + i1 - b, y + i2];
      end
      else if snow >= 0 then
      begin
        b := i1 + randomcount;
        if b >= 640 then b := b - 640;
        b := snowalpha[i2][b];
        if b = 1 then pix := ColColor($FF);
      end
      else if fog then
      begin
        b := i1 + randomcount;
        if b >= 640 then b := b - 640;
        alphe := snowalpha[i2][b];
        pix1 := pix and $FF;
        pix2 := pix shr 8 and $FF;
        pix3 := pix shr 16 and $FF;
        pix4 := pix shr 24 and $FF;
        pix1 := (alphe * $FF + (100 - alphe) * pix1) div 100;
        pix2 := (alphe * $FF + (100 - alphe) * pix2) div 100;
        pix3 := (alphe * $FF + (100 - alphe) * pix3) div 100;
        pix4 := (alphe * $FF + (100 - alphe) * pix4) div 100;
        pix := pix1 + pix2 shl 8 + pix3 shl 16 + pix4 shl 24;

      end
      else if rain >= 0 then
      begin
        b := i1 + randomcount;
        if b >= 640 then b := b - 640;
        b := snowalpha[i2][b];
        if b = 1 then
        begin
          alphe := 50;
          pix1 := pix and $FF;
          pix2 := pix shr 8 and $FF;
          pix3 := pix shr 16 and $FF;
          pix4 := pix shr 24 and $FF;
          pix1 := (alphe * $FF + (100 - alphe) * pix1) div 100;
          pix2 := (alphe * $FF + (100 - alphe) * pix2) div 100;
          pix3 := (alphe * $FF + (100 - alphe) * pix3) div 100;
          pix4 := (alphe * $FF + (100 - alphe) * pix4) div 100;
          pix := pix1 + pix2 shl 8 + pix3 shl 16 + pix4 shl 24;
        end;
      end
      else
      if showBlackScreen = True then
      begin
        alphe := snowalpha[i2][i1];
        if alphe >= 100 then pix := 0
        else if alphe > 0 then
        begin
          pix1 := pix and $FF;
          pix2 := pix shr 8 and $FF;
          pix3 := pix shr 16 and $FF;
          pix4 := pix shr 24 and $FF;
          pix1 := ((100 - alphe) * pix1) div 100;
          pix2 := ((100 - alphe) * pix2) div 100;
          pix3 := ((100 - alphe) * pix3) div 100;
          pix4 := ((100 - alphe) * pix4) div 100;
          pix := pix1 + pix2 shl 8 + pix3 shl 16 + pix4 shl 24;
        end;
      end;
      if (x + i1 >= 0) and (y + i2 >= 0) and (x + i1 < 2304) and (y + i2 < 1402) then
        PutPixel(screen, i1, i2, pix)
      else
        PutPixel(screen, i1, i2, 0);

    end;

end;

//��ս��

procedure DrawBField;
var
  i, i1, i2, ii1, ii2, i3: integer;
  image: Tpic;
  pos1, pos, pos2: TPosition;

begin
  DrawBfieldWithoutRole(Bx, By);

  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      if (Bfield[2, i1, i2] >= 0) then
        DrawRoleOnBfield(i1, i2);
    end;
      {��WMP��Ϊ���ж����ĵ�һ֡
      if (Bfield[2, i1, i2] >= 0) and (Brole[Bfield[2, i1, i2]].rnum >= 0) then
      begin
        if (Brole[Bfield[2, i1, i2]].show = 0) then
          DrawRoleOnBfield(i1, i2);
      end
      else if (Bfield[5, i1, i2] >= 0) and (Brole[Bfield[5, i1, i2]].rnum >= 0) then
      begin
        if (Brole[Bfield[5, i1, i2]].show = 0) then
          DrawRoleOnBfield(i1, i2);
      end;
    end;
  }
end;

//���������ǵ�ս��

procedure DrawBfieldWithoutRole(x, y: integer);
var
  i1, i2, xpoint, ypoint: integer;
begin
  LoadBfieldPart(-x * 18 + y * 18 + 1151 - CENTER_X, x * 9 + y * 9 + 259 - CENTER_Y);
end;

//��ս��������, �����������ǰ���ڵ�

procedure DrawRoleOnBfield(x, y: integer);
var
  i1, i2, w, h, xs, ys, offset, num, xpoint, ypoint: integer;
  pos, pos1, pos2: Tposition;
  //Ppic: pbyte;
  //Pidx: pinteger;
  image: Tpic;
  nowtime: uint32;
begin
  nowtime := SDL_GetTicks;
  if (Bfield[2, x, y] >= 0) then num := Rrole[Brole[Bfield[2, x, y]].rnum].HeadNum * 4 +
      Brole[Bfield[2, x, y]].Face + BEGIN_BATTLE_ROLE_PIC
  else if (Bfield[5, x, y] >= 0) then num := Rrole[Brole[Bfield[5, x, y]].rnum].HeadNum * 4 +
      Brole[Bfield[5, x, y]].Face + BEGIN_BATTLE_ROLE_PIC;

  pos := GetPositionOnScreen(x, y, Bx, By);

  if (Bfield[2, x, y] >= 0) then
  begin
    if (Brole[Bfield[2, x, y]].Show = 0) and (Brole[Bfield[2, x, y]].rnum >= 0) then
    begin
      if not (RBimage[Rrole[Brole[Bfield[2, x, y]].rnum].HeadNum][Brole[Bfield[2, x, y]].face].ispic) then
      begin
        RBimage[Rrole[Brole[Bfield[2, x, y]].rnum].headnum][Brole[Bfield[2, x, y]].face].pic.pic :=
          ReadPicFromByte(@RBimage[Rrole[Brole[Bfield[2, x, y]].rnum].headnum][Brole[Bfield[2, x, y]].face].Data[0],
          RBimage[Rrole[Brole[Bfield[2, x, y]].rnum].HeadNum][Brole[Bfield[2, x, y]].face].len);
        RBimage[Rrole[Brole[Bfield[2, x, y]].rnum].HeadNum][Brole[Bfield[2, x, y]].face].ispic := True;
      end;
      image := RBimage[Rrole[Brole[Bfield[2, x, y]].rnum].headnum][Brole[Bfield[2, x, y]].face].pic;
      pos1 := GetPositionOnScreen(x, y, Bx, By);
      drawPngPic(image, pos1.x, pos1.y, 2, CalBlock(x, y));
      for i1 := 4 to 7 do
      begin
        if (Brole[Bfield[2, x, y]].rnum = BShowBWord.rnum[i1]) and ((BShowBWord.sign and (1 shl i1)) > 0) then
        begin
          if (integer(nowtime) - integer(BShowBWord.starttime[i1]) <= BShowBWord.delay[i1]) then
          begin
            pos2 := GetPositionOnScreen(BShowBWord.x[i1], BShowBWord.y[i1], Bx, By);
            DrawShadowText(@BShowBWord.words[i1][1], pos2.x - length(BShowBWord.words[i1]) *
              CHINESE_FONT_SIZE div 2 + round((integer(nowtime) - integer(BShowBWord.starttime[i1])) div
              50 * BShowBWord.Sx[i1]), pos2.y - 40 - round(
              (integer(nowtime) - integer(BShowBWord.starttime[i1])) div 50 * BShowBWord.Sy[i1]),
              ColColor(BShowBWord.col1[i1]), ColColor(BShowBWord.col2[i1]));
            ZoomPic(head_pic[Rrole[BShowBWord.rnum[i1]].HeadNum].pic, 0, pos2.x + 10 -
              length(BShowBWord.words[i1]) * CHINESE_FONT_SIZE div 2 + round(
              (integer(nowtime) - integer(BShowBWord.starttime[i1])) div 50 * BShowBWord.Sx[i1]),
              pos2.y - 40 - round((integer(nowtime) - integer(BShowBWord.starttime[i1])) div
              50 * BShowBWord.Sy[i1]) - 30, 29, 30);
          end;
        end;
      end;
    end;
  end
  else if (Bfield[5, x, y] >= 0) then
  begin
    if (Brole[Bfield[5, x, y]].Show = 0) and (Brole[Bfield[5, x, y]].rnum >= 0) then
    begin
      if not (RBimage[Rrole[Brole[Bfield[5, x, y]].rnum].HeadNum][Brole[Bfield[5, x, y]].face].ispic) then
      begin
        RBimage[Rrole[Brole[Bfield[5, x, y]].rnum].HeadNum][Brole[Bfield[5, x, y]].face].pic.pic :=
          ReadPicFromByte(@RBimage[Rrole[Brole[Bfield[5, x, y]].rnum].headnum][Brole[Bfield[5, x, y]].face].Data[0],
          RBimage[Rrole[Brole[Bfield[5, x, y]].rnum].HeadNum][Brole[Bfield[5, x, y]].face].len);
        RBimage[Rrole[Brole[Bfield[5, x, y]].rnum].HeadNum][Brole[Bfield[5, x, y]].face].ispic := True;
      end;
      image := RBimage[Rrole[Brole[Bfield[5, x, y]].rnum].headnum][Brole[Bfield[5, x, y]].face].pic;
      pos1 := GetPositionOnScreen(x, y, Bx, By);
      drawPngPic(image, pos1.x, pos1.y, 2, CalBlock(x, y));
      for i1 := 4 to 7 do
      begin
        if (Brole[Bfield[5, x, y]].rnum = BShowBWord.rnum[i1]) and ((BShowBWord.sign and (1 shl i1)) > 0) then
        begin
          if (integer(nowtime) - integer(BShowBWord.starttime[i1]) <= BShowBWord.delay[i1]) then
          begin
            pos2 := GetPositionOnScreen(BShowBWord.x[i1], BShowBWord.y[i1], Bx, By);
            DrawShadowText(@BShowBWord.words[i1][1], pos2.x - length(BShowBWord.words[i1]) *
              CHINESE_FONT_SIZE div 2 + round((integer(nowtime) - integer(BShowBWord.starttime[i1])) div
              50 * BShowBWord.Sx[i1]), pos2.y - 40 - round(
              (integer(nowtime) - integer(BShowBWord.starttime[i1])) div 50 * BShowBWord.Sy[i1]),
              ColColor(BShowBWord.col1[i1]), ColColor(BShowBWord.col2[i1]));
            ZoomPic(head_pic[Rrole[BShowBWord.rnum[i1]].HeadNum].pic, 0, pos2.x + 10 -
              length(BShowBWord.words[i1]) * CHINESE_FONT_SIZE div 2 + (integer(nowtime) -
              integer(BShowBWord.starttime[i1])) div 50, pos2.y - 40 - round(
              (integer(nowtime) - integer(BShowBWord.starttime[i1])) div 50 * BShowBWord.Sy[i1]) - 30, 29, 30);
          end;
        end;
      end;
    end;
  end;

end;

//��ʼ��ս��ӳ��

procedure InitialWholeBField;
var
  i1, i2, x, y: integer;
begin
  FillChar(BFieldImg, SizeOf(BFieldImg), 0);
  FillChar(MaskArray, SizeOf(MaskArray), 0);
  for i1 := 0 to 63 do
  begin
    for i2 := 0 to 63 do
    begin
      x := -i1 * 18 + i2 * 18 + 1151;
      y := i1 * 9 + i2 * 9 + 259;
      if (i1 < 0) or (i2 < 0) or (i1 > 63) or (i2 > 63) then
        InitialBPic(0, x, y)
      else
      begin
        InitialBPic(Bfield[0, i1, i2] div 2, x, y);
        if (Bfield[1, i1, i2] > 0) then
        begin
          InitialBPic(bfield[1, i1, i2] div 2, x, y, 1, CalBlock(i1, i2));
        end;
      end;
    end;
  end;

end;

//��ս��ӳ�񻭵���Ļ

procedure LoadBfieldPart(x, y: integer; onlyBuild: integer = 0);
var
  i1, i2: integer;
begin
  LT.x := x;
  LT.y := y;
  for i1 := 0 to screen.w - 1 do
    for i2 := 0 to screen.h - 1 do
      if (x + i1 >= 0) and (y + i2 >= 0) and (x + i1 < 2304) and (y + i2 < 1402) then
      begin
        if (onlyBuild <> 0) and (MaskArray[x + i1, LT.y + i2] = 0) then continue;
        PutPixel(screen, i1, i2, Bfieldimg[x + i1, y + i2]);
      end
      else
        PutPixel(screen, i1, i2, 0);

end;

//���������ӳ�
//���ӳ�Ч�ʲ���

procedure DrawBFieldWithCursor(AttAreaType, step, range,mods: integer);
var
  i, i1, i2, i3, bnum, minstep: integer;
  x1, y1, x2, x, y, y2, p, w, num: integer;
  pos, pos2: TPosition;
  image: Tpic;
  nowtime: uint32;
begin
  p := 0;
  Redraw;
  nowtime := SDL_GetTicks;
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      Bfield[4, i1, i2] := 0;
      pos := GetPositionOnScreen(i1, i2, Bx, By);
      num := Bfield[0, i1, i2] div 2;
      case AttAreaType of
        0: //Ŀ��ϵ����(�����ƶ����㹥���ö���ҽ�Ƶ�)��Ŀ��ϵʮ�͡�Ŀ��ϵ���͡�ԭ��ϵ����
        begin
          if num > 0 then
          begin
            if (abs(i1 - Ax) + abs(i2 - Ay)) <= range then
            begin
              DrawBPic(num, pos.x, pos.y, 1);
              Bfield[4, i1, i2] := 1;
            end
            else if (abs(i1 - Bx) + abs(i2 - By) <= step) and (Bfield[3, i1, i2] >= 0) then
              DrawBPic(num, pos.x, pos.y, 0)
            else
              DrawBPic(num, pos.x, pos.y, -1);
          end;
        end;
        1: //����ϵ����
        begin
          if num > 0 then
          begin
            if ((i1 = Bx) and (abs(i2 - By) <= step) and (((i2 - By) * (Ay - By)) > 0)) or
              ((i2 = By) and (abs(i1 - Bx) <= step) and (((i1 - Bx) * (Ax - Bx)) > 0)) then
            begin
              DrawBPic(num, pos.x, pos.y, 1);
              Bfield[4, i1, i2] := 1;
            end
            else if ((i1 = Bx) and (abs(i2 - By) <= step)) or ((i2 = By) and (abs(i1 - Bx) <= step)) then
              DrawBPic(num, pos.x, pos.y, 0)
            else
              DrawBPic(num, pos.x, pos.y, -1);
          end;
        end;
        2: //ԭ��ϵʮ�͡�ԭ��ϵ���͡�ԭ��ϵ����
        begin
          if num > 0 then
          begin
            if ((i1 = Bx) and (abs(i2 - By) <= step)) or ((i2 = By) and (abs(i1 - Bx) <= step)) or
              ((abs(i1 - Bx) = abs(i2 - By)) and (abs(i1 - Bx) <= range)) then
            begin
              DrawBPic(num, pos.x, pos.y, 1);
              Bfield[4, i1, i2] := 1;
            end
            else
              DrawBPic(num, pos.x, pos.y, -1);
          end;
        end;
        3: //Ŀ��ϵ���͡�ԭ��ϵ����
        begin
          if num > 0 then
          begin
            if (abs(i1 - Ax) <= range) and (abs(i2 - Ay) <= range) then
            begin
              DrawBPic(num, pos.x, pos.y, 1);
              Bfield[4, i1, i2] := 1;
            end
            else if (abs(i1 - Bx) + abs(i2 - By) <= step) and (Bfield[0, i1, i2] >= 0) then
              DrawBPic(num, pos.x, pos.y, 0)
            else
              DrawBPic(num, pos.x, pos.y, -1);
          end;
        end;
        4: //����ϵ����
        begin
          if num > 0 then
          begin
            if ((abs(i1 - Bx) + abs(i2 - By) <= step) and (abs(i1 - Bx) <> abs(i2 - By))) and
              ((((i1 - Bx) * (Ax - Bx) > 0) and (abs(i1 - Bx) > abs(i2 - By))) or
              (((i2 - By) * (Ay - By) > 0) and (abs(i1 - Bx) < abs(i2 - By)))) then
            begin
              DrawBPic(num, pos.x, pos.y, 1);
              Bfield[4, i1, i2] := 1;
            end
            else if (abs(i1 - Bx) + abs(i2 - By) <= step) and (abs(i1 - Bx) <> abs(i2 - By)) then
              DrawBPic(num, pos.x, pos.y, 0)
            else
              DrawBPic(num, pos.x, pos.y, -1);
          end;
        end;
        5: //����ϵ����
        begin
          if num > 0 then
          begin
            if ((abs(i1 - Bx) <= step) and (abs(i2 - By) <= step) and (abs(i1 - Bx) <> abs(i2 - By))) and
              ((((i1 - Bx) * (Ax - Bx) > 0) and (abs(i1 - Bx) > abs(i2 - By))) or
              (((i2 - By) * (Ay - By) > 0) and (abs(i1 - Bx) < abs(i2 - By)))) then
            begin
              DrawBPic(num, pos.x, pos.y, 1);
              Bfield[4, i1, i2] := 1;
            end
            else if (abs(i1 - Bx) <= step) and (abs(i2 - By) <= step) and (abs(i1 - Bx) <> abs(i2 - By)) then
              DrawBPic(num, pos.x, pos.y, 0)
            else
              DrawBPic(num, pos.x, pos.y, -1);
          end;
        end;
        6: //Զ��
        begin
          minstep := 3;
          if num > 0 then
          begin
            if (abs(i1 - Ax) + abs(i2 - Ay)) <= range then
            begin
              DrawBPic(num, pos.x, pos.y, 1);
              Bfield[4, i1, i2] := 1;
            end
            else if (abs(i1 - Bx) + abs(i2 - By) <= step) and (abs(i1 - Bx) + abs(i2 - By) > minstep) and
              (Bfield[3, i1, i2] >= 0) then
              DrawBPic(num, pos.x, pos.y, 0)
            else
              DrawBPic(num, pos.x, pos.y, -1);
          end;
        end;
        7: //�޶���ֱ��
        begin
          if num > 0 then
          begin
            if (i1 = Bx) and (i2 = By) then
            begin
              DrawBPic(num, pos.x, pos.y, 1);
              Bfield[4, i1, i2] := 1;
            end
            else if (abs(i1 - Bx) + abs(i2 - By) <= step) and (Bfield[3, i1, i2] >= 0) then
            begin
              if ((abs(i1 - Bx) <= abs(Ax - Bx)) and (abs(i2 - By) <= abs(Ay - By))) then
              begin
                if (abs(Ax - Bx) > abs(Ay - By)) and (((i1 - Bx) / (Ax - Bx)) > 0) and
                  (i2 = round(((i1 - Bx) * (Ay - By)) / (Ax - Bx)) + By) then
                begin
                  DrawBPic(num, pos.x, pos.y, 1);
                  Bfield[4, i1, i2] := 1;
                end
                else if (abs(Ax - Bx) <= abs(Ay - By)) and (((i2 - By) / (Ay - By)) > 0) and
                  (i1 = round(((i2 - By) * (Ax - Bx)) / (Ay - By)) + Bx) then
                begin
                  DrawBPic(num, pos.x, pos.y, 1);
                  Bfield[4, i1, i2] := 1;
                end
                else DrawBPic(num, pos.x, pos.y, 0);
              end
              else DrawBPic(num, pos.x, pos.y, 0);
            end
            else
              DrawBPic(num, pos.x, pos.y, -1);
          end;
        end;
      end;
      if (i1 = Ax) and (i2 = Ay) then
        DrawBPic(Bfield[0, i1, i2] div 2, pos.x, pos.y, 2);
    end;
  //ֻ���뽨����
  LoadBfieldPart(-Bx * 18 + By * 18 + 1151 - CENTER_X, Bx * 9 + By * 9 + 259 - CENTER_Y, 1);
  //����������ѭ�������б�Ҫ�ģ������ڵ���������
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      pos := GetPositionOnScreen(i1, i2, Bx, By);
      bnum := Bfield[2, i1, i2];
      if (bnum >= 0) and (Brole[bnum].Dead = 0) then
      begin
        if Brole[bnum].rnum >= 0 then
        begin
          if (Bfield[4, i1, i2] > 0) then
            if ((mods = 0) and (Brole[bnum].Team <> Brole[Bfield[2, Bx, By]].Team))
              or ((mods = 1) and (Brole[bnum].Team = Brole[Bfield[2, Bx, By]].Team)) then
               HighLight := True;
          if not (RBimage[Rrole[Brole[bnum].rnum].HeadNum][Brole[bnum].Face].ispic) then
          begin
            RBimage[Rrole[Brole[bnum].rnum].HeadNum][Brole[bnum].Face].pic.pic :=
              ReadPicFromByte(@RBimage[Rrole[Brole[bnum].rnum].headnum][Brole[bnum].face].Data[0],
              RBimage[Rrole[Brole[bnum].rnum].HeadNum][Brole[bnum].face].len);
            RBimage[Rrole[Brole[bnum].rnum].HeadNum][Brole[bnum].face].ispic := True;
          end;
          image := RBimage[Rrole[Brole[bnum].rnum].headnum][Brole[bnum].Face].pic;
          drawPngPic(image, pos.x, pos.y, 2, CalBlock(i1, i2));
          HighLight := False;
          for i3 := 4 to 7 do
          begin
            if (Brole[bnum].rnum = BShowBWord.rnum[i3]) and ((BShowBWord.sign and (1 shl i3)) > 0) then
            begin
              if (integer(nowtime) - integer(BShowBWord.starttime[i3]) <= BShowBWord.delay[i3]) then
              begin
                pos2 := GetPositionOnScreen(BShowBWord.x[i3], BShowBWord.y[i3], Bx, By);
                DrawShadowText(@BShowBWord.words[i3][1], pos2.x - length(BShowBWord.words[i3]) *
                  CHINESE_FONT_SIZE div 2 + round((integer(nowtime) - integer(BShowBWord.starttime[i3])) div
                  50 * BShowBWord.Sx[i3]), pos2.y - 40 - round(
                  (integer(nowtime) - integer(BShowBWord.starttime[i3])) div 50 * BShowBWord.Sy[i3]),
                  ColColor(BShowBWord.col1[i3]), ColColor(BShowBWord.col2[i3]));
                ZoomPic(head_pic[Rrole[BShowBWord.rnum[i3]].HeadNum].pic, 0, pos2.x + 10 -
                  length(BShowBWord.words[i3]) * CHINESE_FONT_SIZE div 2 + round(
                  (integer(nowtime) - integer(BShowBWord.starttime[i3])) div 50 * BShowBWord.Sx[i3]),
                  pos2.y - 40 - round((integer(nowtime) - integer(BShowBWord.starttime[i3])) div
                  50 * BShowBWord.Sy[i3]) - 30, 29, 30);
              end;
            end;
          end;
        end;
      end;
    end;
  showprogress;
end;

//����Ч����ս��

procedure DrawBFieldWithEft(f, Epicnum, bigami, level: integer);
var
  i, i1, i2, n: integer;
  pos: TPosition;
  image: Tpic;
begin
  image := GetPngPic(f, epicnum);
  DrawBfieldWithoutRole(Bx, By);
  n := 0;
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      if (Bfield[2, i1, i2] >= 0) and (Brole[Bfield[2, i1, i2]].Show = 0) then
      begin
        HighLight := False;
        if (Brole[Bfield[2, Bx, By]].Team <> Brole[Bfield[2, i1, i2]].Team) and (Bfield[4, i1, i2] > 0) then
          HighLight := Boolean(random(2));
        if (Brole[Bfield[2, i1, i2]].rnum >= 0) then
          DrawRoleOnBfield(i1, i2);
      end;
    end;

  if bigami = 0 then
  begin
    for i1 := 0 to 63 do
      for i2 := 0 to 63 do
      begin
        pos := GetPositionOnScreen(i1, i2, Bx, By);
        if (Effect <> 0) and ((image.pic.w > 120) or (image.pic.h > 120)) and ((i1 + i2) mod 2 = 0) then continue;
        if Bfield[4, i1, i2] > 0 then
        begin
          begin
            DrawEftPic(image, pos.x, pos.y, 0);
          end;
        end;
      end;
  end
  else
  begin
    pos := GetPositionOnScreen(Ax, Ay, Bx, By);
    if Bfield[4, Ax, Ay] > 0 then
    begin
      DrawEftPic(image, pos.x, pos.y, level);
    end;
  end;
  SDL_FreeSurface(image.pic);
  HighLight := False;
end;

//��������Ч����ս��

procedure DrawBFieldWithEft2(f, Epicnum, bigami, x, y, level: integer);
var
  i, i1, i2, n: integer;
  pos: TPosition;
  image: Tpic;
begin
  image := GetPngPic(f, epicnum);
  DrawBfieldWithoutRole(Bx, By);
  n := 0;
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      if (Bfield[2, i1, i2] >= 0) and (Brole[Bfield[2, i1, i2]].Show = 0) then
      begin
        HighLight := False;
        if (Brole[Bfield[2, Bx, By]].Team <> Brole[Bfield[2, i1, i2]].Team) and (Bfield[4, i1, i2] > 0) then
          HighLight := Boolean(random(2));
        if (Brole[Bfield[2, i1, i2]].rnum >= 0) then
          DrawRoleOnBfield(i1, i2);
      end;
    end;
  if bigami = 0 then
  begin
    for i1 := 0 to 63 do
      for i2 := 0 to 63 do
      begin
        pos := GetPositionOnScreen(i1, i2, Bx, By);
        if (Effect <> 0) and ((image.pic.w > 120) or (image.pic.h > 120)) and ((i1 + i2) mod 2 = 0) then continue;
        if ((i1 = x) and (i2 = y)) then
        begin
          begin
            DrawEftPic(image, pos.x, pos.y, 0);
          end;
        end;
      end;
  end
  else
  begin
    pos := GetPositionOnScreen(Ax, Ay, Bx, By);
    if Bfield[4, Ax, Ay] > 0 then
    begin
      DrawEftPic(image, pos.x, pos.y, level);
    end;
  end;
  SDL_FreeSurface(image.pic);
  HighLight := False;
end;

//�������ﶯ����ս��

procedure DrawBFieldWithAction(f, bnum, Apicnum: integer);
var
  i, i1, i2, i3, ii1, x1, y1, ii2: integer;
  pos1, pos, pos2: TPosition;
  image: Tpic;
  nowtime: uint32;
begin
  DrawBfieldWithoutRole(Bx, By);
  image := GetPngPic(f, Apicnum);
  nowtime := SDL_GetTicks;
  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      if (Bfield[2, i1, i2] >= 0) and (Brole[Bfield[2, i1, i2]].Show = 0) and (Bfield[2, i1, i2] <> bnum) then
      begin
        if (Brole[Bfield[2, i1, i2]].rnum >= 0) then
          DrawRoleOnBfield(i1, i2);
      end;
      if (Bfield[2, i1, i2] = bnum) then
      begin
        pos1 := GetPositionOnScreen(i1, i2, Bx, By);
        drawPngPic(image, pos1.x, pos1.y, 2, CalBlock(i1, i2));
        for i3 := 4 to 7 do
        begin
          if (Brole[Bfield[2, i1, i2]].rnum = BShowBWord.rnum[i3]) and
            ((BShowBWord.sign and (1 shl i3)) > 0) then
          begin
            if (integer(nowtime) - integer(BShowBWord.starttime[i3]) <= BShowBWord.delay[i3]) then
            begin
              pos2 := GetPositionOnScreen(BShowBWord.x[i3], BShowBWord.y[i3], Bx, By);
              DrawShadowText(@BShowBWord.words[i3][1], pos2.x - length(BShowBWord.words[i3]) *
                CHINESE_FONT_SIZE div 2 + round((integer(nowtime) - integer(BShowBWord.starttime[i3])) div
                50 * BShowBWord.Sx[i3]), pos2.y - 40 - round(
                (integer(nowtime) - integer(BShowBWord.starttime[i3])) div 50 * BShowBWord.Sy[i3]),
                ColColor(BShowBWord.col1[i3]), ColColor(BShowBWord.col2[i3]));
              ZoomPic(head_pic[Rrole[BShowBWord.rnum[i3]].HeadNum].pic, 0, pos2.x +
                10 - length(BShowBWord.words[i3]) * CHINESE_FONT_SIZE div 2 + round(
                (integer(nowtime) - integer(BShowBWord.starttime[i3])) div 50 * BShowBWord.Sx[i3]),
                pos2.y - 40 - round((integer(nowtime) - integer(BShowBWord.starttime[i3])) div
                50 * BShowBWord.Sy[i3]) - 30, 29, 30);
            end;
          end;
        end;
      end;
    end;
  SDL_FreeSurface(image.pic);

end;



//��Pngͼ

function GetPngPic(f: integer; num: integer): Tpic; overload;
var
  address, len: integer;
  picdata: array of byte;
  Count: integer;
begin

  FileSeek(f, 0, 0);
  FileRead(f, Count, 4);
  FileSeek(f, (num + 1) * 4, 0);
  FileRead(f, len, 4);
  if num = 0 then
    address := (Count + 1) * 4
  else
  begin
    FileSeek(f, num * 4, 0);
    FileRead(f, address, 4);
  end;
  len := len - address - 12;
  FileSeek(f, address, 0);
  FileRead(f, Result.x, 4);
  FileRead(f, Result.y, 4);
  FileRead(f, Result.black, 4);
  setlength(picdata, len);
  FileRead(f, picdata[0], len);
  Result.pic := ReadPicFromByte(@picdata[0], len);
end;

function GetPngPic(filename: string; num: integer): Tpic; overload;
var
  address, len: integer;
  Data: array of byte;
  f, Count, beginaddress: integer;
begin
  f := FileOpen(filename, fmOpenRead);
  FileSeek(f, 0, 0);
  FileRead(f, Count, 4);
  FileSeek(f, (num + 1) * 4, 0);
  FileRead(f, len, 4);
  if num = 0 then
    address := (Count + 1) * 4
  else
  begin
    FileSeek(f, num * 4, 0);
    FileRead(f, address, 4);
  end;
  len := len - address - 12;
  FileSeek(f, address, 0);
  FileRead(f, Result.x, 4);
  FileRead(f, Result.y, 4);
  FileRead(f, Result.black, 4);
  setlength(Data, len);
  FileRead(f, Data[0], len);
  Result.pic := ReadPicFromByte(@Data[0], len);
  FileClose(f);
end;

procedure drawPngPic(image: Tpic; px, py, mask: integer; maskvalue: smallint = 0); overload;
begin
  drawPngPic(image, 0, 0, image.pic.w, image.pic.h, px, py, mask, maskvalue);
end;

procedure drawPngPic(image: Tpic; x, y, w, h, px, py, mask: integer; maskvalue: smallint = 0); overload;
var
  i1, i2, bpp, b, x1, y1, pix: integer;
  p: puint32;
  c: uint32;
  pix1, pix2, pix3, alpha, col1, col2, col3, alpha1: byte;
begin
  b := 0;
  x1 := px - image.x;
  y1 := py - image.y;
  bpp := image.pic.format.BytesPerPixel;
  for i1 := 0 to w - 1 do
    for i2 := 0 to h - 1 do
    begin
      if ((y1 + i2) >= 0) and ((y1 + i2) < 440) and ((x1 + i1) >= 0) and ((x1 + i1) < 640) then
        if ((mask = 2) and (MaskArray[LT.x + x1 + i1, LT.y + y1 + i2] <= maskvalue)) or (Mask <= 1) then
        begin
          p := Pointer(uint32(image.pic.pixels) + (i2 + y) * image.pic.pitch + (i1 + x) * bpp);
          c := puint32(p)^;
          p := Pointer(uint32(screen.pixels) + (y1 + i2) * screen.pitch + (x1 + i1) * screen.format.BytesPerPixel);
          pix := puint32(p)^;
          SDL_GetRGB(pix, screen.format, @pix1, @pix2, @pix3);
          SDL_GetRGBA(c, image.pic.format, @col1, @col2, @col3, @alpha);
          if (alpha = 0) and (Mask = 1) then MaskArray[x1 + i1, y1 + i2] := 1;
          if alpha > 0 then
          begin
            pix1 := (alpha * col1 + (255 - alpha) * pix1) div 255;
            pix2 := (alpha * col2 + (255 - alpha) * pix2) div 255;
            pix3 := (alpha * col3 + (255 - alpha) * pix3) div 255;
            if HighLight then //����
            begin
              alpha1 := 50;
              pix1 := (alpha1 * $FF + (100 - alpha1) * pix1) div 100;
              pix2 := (alpha1 * $FF + (100 - alpha1) * pix2) div 100;
              pix3 := (alpha1 * $FF + (100 - alpha1) * pix3) div 100;
            end;
            PutPixel(screen, x1 + i1, y1 + i2, SDL_MapRGB(screen.format, pix1, pix2, pix3));
          end;
        end;
    end;

end;

function ReadPicFromByte(p_byte: Pbyte; size: Integer): PSDL_Surface;
var
  temp: PSDL_Surface;
begin
  Result := IMG_Load_RW(SDL_RWFromMem(p_byte, size), 1);
  //result := SDL_DisplayFormat(temp);
  //sdl_freesurface(temp);
end;

//���庺��ת���ɷ��庺��

function Simplified2Traditional(mSimplified: string): string; //���ط����ַ���   //Win98����Ч
var
  L: Integer;
begin
  L := Length(mSimplified);
  SetLength(Result, L);
  LCMapString(GetUserDefaultLCID,
    LCMAP_TRADITIONAL_CHINESE, pchar(mSimplified), L, @Result[1], L);
end; {   Simplified2Traditional   }

//���庺��ת���ɼ��庺��

function Traditional2Simplified(mTraditional: string): string; //���ط����ַ���
var
  L: Integer;
begin
  L := Length(mTraditional);
  SetLength(Result, L);
  LCMapString(GetUserDefaultLCID,
    LCMAP_SIMPLIFIED_CHINESE, pchar(mTraditional), L, @Result[1], L);
end; {   Traditional2Simplified   }




procedure resetpallet; overload;
var
  i, c: integer;
  p: pbyte;
begin
  c := 0;
  if where = 1 then
  begin
    if rScene[curScene].Pallet in [0..3] then
      c := rScene[curScene].Pallet
    else c := 0;
    p := @Col[c][0];
  end
  else p := @Col[0][0];

  for i := 0 to 768 - 1 do
  begin
    Acol[i] := p^;
    Inc(p);

  end;

end;

procedure resetpallet(num: integer); overload;
var
  i: integer;
begin
  for i := 0 to 768 - 1 do
    Acol[i] := Col[num][i];
end;

function RoRforUint16(a, n: uint16): uint16;
var
  b: uint16;
begin
  b := a shl (16 - n);
  a := a shr n;
  Result := a or b;
end;

function RoLforUInt16(a, n: uint16): uint16;
var
  b: uint16;
begin
  b := a shr (16 - n);
  a := a shl n;
  Result := a or b;
end;

function RoRforByte(a: byte; n: uint16): byte;
var
  b: byte;
begin
  b := a shl (8 - n);
  a := a shr n;
  Result := a or b;
end;

function RoLforByte(a: byte; n: uint16): byte;
var
  b: byte;
begin
  b := a shr (8 - n);
  a := a shl n;
  Result := a or b;
end;

procedure DrawEftPic(Pic: Tpic; px, py, level: integer);
var
  w, h, xs, ys, black: integer;
  xx, yy: integer;
  pix, pix0: uint32;
  pix1, pix2, pix3, pix4: byte;
  pix01, pix02, pix03, pix04: byte;
  i: double;
  pic1: Tpic;
begin
  if (level = 0) then level := 10;

  i := (level) / 20 + 0.5;
  xs := trunc(pic.x * i);
  ys := trunc(pic.y * i);
  pic1.x := xs;
  pic1.y := ys;
  xs := px - xs;
  ys := py - ys;
  w := trunc(pic.pic.w * i);
  h := trunc(pic.pic.h * i);
  black := pic.black;
  pic1.pic := zoomSurface(pic.pic, i, i, 0);
  if black <> 0 then
  begin
    for yy := 0 to h - 1 do
    begin
      if yy + ys < screen.h then
        for xx := 0 to w - 1 do
        begin
          if xx + xs < screen.w then
          begin
            pix0 := GetPixel(pic1.pic, xx, yy);
            if (pix0 and $FFFFFF) <> 0 then
            begin
              pix := GetPixel(screen, xx + xs, yy + ys);
              pix03 := pix0 and $FF;
              pix02 := pix0 shr 8 and $FF;
              pix01 := pix0 shr 16 and $FF;
              pix04 := pix0 shr 24 and $FF;
              pix1 := pix and $FF;
              pix2 := pix shr 8 and $FF;
              pix3 := pix shr 16 and $FF;
              pix4 := pix shr 24 and $FF;

              pix1 := pix1 + pix01 - (pix01 * pix1) div 255;
              pix2 := pix2 + pix02 - (pix02 * pix2) div 255;
              pix3 := pix3 + pix03 - (pix03 * pix3) div 255;

              pix := pix1 + pix2 shl 8 + pix3 shl 16 + pix4 shl 24;
              PutPixel(screen, xx + xs, yy + ys, pix);

            end;
          end;

        end;
    end;
  end
  else
  begin

    for yy := 0 to h - 1 do
    begin
      if yy + ys < screen.h then
        for xx := 0 to w - 1 do
        begin
          if xx + xs < screen.w then
          begin
            pix0 := GetPixel(pic1.pic, xx, yy);
            if (pix0 and $FF000000) <> 0 then
            begin
              pix := GetPixel(screen, xx + xs, yy + ys);
              pix03 := pix0 and $FF;
              pix02 := pix0 shr 8 and $FF;
              pix01 := pix0 shr 16 and $FF;
              pix04 := pix0 shr 24 and $FF;
              pix1 := pix and $FF;
              pix2 := pix shr 8 and $FF;
              pix3 := pix shr 16 and $FF;
              pix4 := pix shr 24 and $FF;

              pix1 := (pix04 * pix01 + (255 - pix04) * pix1) div 255;
              pix2 := (pix04 * pix02 + (255 - pix04) * pix2) div 255;
              pix3 := (pix04 * pix03 + (255 - pix04) * pix3) div 255;

              pix := pix1 + pix2 shl 8 + pix3 shl 16;
              PutPixel(screen, xx + xs, yy + ys, pix);

            end;
          end;
        end;
    end;
  end;
  SDL_FreeSurface(pic1.pic);
end;

procedure ZoomPic(scr: PSDL_Surface; angle: double; x, y, w, h: integer);
var
  a, b: double;
  dest, sest: TSDL_Rect;
  temp: PSDL_Surface;
begin
  a := w / scr.w;
  b := h / scr.h;
  dest.x := x;
  dest.y := y;
  dest.w := w;
  dest.h := h;
  temp := sdl_gfx.rotozoomSurfaceXY(scr, angle, a, b, 0);
  SDL_BlitSurface(temp, nil, screen, @dest);
  SDL_FreeSurface(temp);
end;

function GetZoomPic(scr: PSDL_Surface; angle: double; x, y, w, h: integer): PSDL_Surface;
var
  a, b: double;
  dest, sest: TSDL_Rect;
begin
  a := w / scr.w;
  b := h / scr.h;
  dest.x := x;
  dest.y := y;
  dest.w := w;
  dest.h := h;
  Result := sdl_gfx.rotozoomSurfaceXY(scr, angle, a, b, 0);
end;




procedure UpdateBattleScene(xs, ys, oldPic, newpic: integer);
var
  i1, i2, x, y: integer;
  num, offset: integer;
  xp, yp, xp1, yp1, xp2, yp2, w2, w1, h1, h2, w, h: smallint;
begin

  x := -xs * 18 + ys * 18 + 1151;
  y := xs * 9 + ys * 9 + 259;

  oldpic := oldpic div 2;
  newpic := newpic div 2;
  if oldpic > 0 then
  begin
    offset := SIdx[oldpic - 1];
    xp1 := x - (SPic[offset + 4] + 256 * SPic[offset + 5]);
    yp1 := y - (SPic[offset + 6] + 256 * SPic[offset + 7]);
    w1 := (SPic[offset] + 256 * SPic[offset + 1]);
    h1 := (SPic[offset + 2] + 256 * SPic[offset + 3]);
    //  InitialSPic(oldpic , x, y,  xp, yp, w, h, 1);
  end
  else
  begin
    xp1 := x;
    yp1 := y;
    w1 := 0;
    h1 := 0;
  end;

  if newpic > 0 then
  begin
    offset := SIdx[newpic - 1];
    xp2 := x - (SPic[offset + 4] + 256 * SPic[offset + 5]);
    yp2 := y - (SPic[offset + 6] + 256 * SPic[offset + 7]);
    w2 := (SPic[offset] + 256 * SPic[offset + 1]);
    h2 := (SPic[offset + 2] + 256 * SPic[offset + 3]);
    //  InitialSPic(oldpic , x, y,  xp, yp, w, h, 1);
  end
  else
  begin
    xp2 := x;
    yp2 := y;
    w2 := 0;
    h2 := 0;
  end;
  xp := min(xp2, xp1) - 1;
  yp := min(yp2, yp1) - 1;
  w := max(xp2 + w2, xp1 + w1) + 3 - xp;
  h := max(yp2 + h2, yp1 + h1) + 3 - yp;


  for i1 := 0 to 63 do
    for i2 := 0 to 63 do
    begin
      x := -i1 * 18 + i2 * 18 + 1151;
      y := i1 * 9 + i2 * 9 + 259;
      if BField[0, i1, i2] > 0 then
        InitialBPic(BField[0, i1, i2] div 2, x, y, xp, yp, w, h, 0);
      if (BField[1, i1, i2] > 0) then
        InitialBPic(BField[1, i1, i2] div 2, x, y, xp, yp, w, h, 0);
    end;
end;

procedure Moveman(x1, y1, x2, y2: integer);
var
  s, i, i1, i2, a, tempx, tx1, tx2, ty1, ty2, tempy: integer;
  Xinc, Yinc, dir: array[1..4] of integer;
begin
  if Fway[x2, y2] > 0 then
  begin
    Xinc[1] := 0; Xinc[2] := 1; Xinc[3] := -1; Xinc[4] := 0;
    Yinc[1] := -1; Yinc[2] := 0; Yinc[3] := 0; Yinc[4] := 1;
    linex[0] := x2;
    liney[0] := y2;
    for a := 1 to Fway[x2, y2] do
    begin
      for i := 1 to 4 do
      begin
        tempx := linex[a - 1] + Xinc[i];
        tempy := liney[a - 1] + Yinc[i];
        if Fway[tempx, tempy] = Fway[linex[a - 1], liney[a - 1]] - 1 then
        begin
          linex[a] := tempx;
          liney[a] := tempy;
          break;
        end;
      end;
    end;
  end;
end;

procedure FindWay(x1, y1: integer); overload;
begin
  FindWay(x1, y1, -1);
end;

procedure FindWay(x1, y1, mods: integer); overload;
var
  //���ڳ�����Ҫ�����������趨�������ֵΪ100001
  Xlist: array[0..99855] of smallint; //��ͨ�еĸ��ӵ�X�����б� ,
  Ylist: array[0..99855] of smallint;
  steplist: array[0..99855] of smallint; //���_ÿ����ͨ�еĸ��ӵĲ���
  curgrid, totalgrid, curstep: integer;
  Bgrid: array[1..4] of integer; //0��λ��1���ɹ���2���߹� ,3Խ�磬4����5ˮ��6���
  Xinc, Yinc: array[1..4] of integer; //�Ă���λ�����˼�ֵ
  curX, curY, nextX, nextY: integer;
  i, i1, i2, i3, max0: integer;
begin
  if mods = -1 then max0 := 22
  else if mods=-2 then max0:=2000
       
  else max0 := mods;
  Xinc[1] := 0;
  Xinc[2] := 1;
  Xinc[3] := -1;
  Xinc[4] := 0;
  Yinc[1] := -1;
  Yinc[2] := 0;
  Yinc[3] := 0;
  Yinc[4] := 1;
  curgrid := 0;
  totalgrid := 0;
  Xlist[totalgrid] := x1;
  Ylist[totalgrid] := y1;
  steplist[totalgrid] := 0;
  totalgrid := totalgrid + 1;
  while curgrid < totalgrid do
  begin
    curX := Xlist[curgrid];
    curY := Ylist[curgrid];
    curstep := steplist[curgrid];
    //�жϵ�ǰ�����ܸ��ӵ�״��
    case where of
      1:
      begin
        for i := 1 to 4 do
        begin
          nextX := curX + Xinc[i];
          nextY := curY + Yinc[i];
          if (nextX < 0) or (nextX > 63) or (nextY < 0) or (nextY > 63) then
            Bgrid[i] := 3
          else if Fway[nextX, nextY] >= 0 then
            Bgrid[i] := 2
          else if not canwalkinscene(nextX, nextY) then
            Bgrid[i] := 1
          else
            Bgrid[i] := 0;
        end;
      end;
      0:
      begin
        for i := 1 to 4 do
        begin
          nextX := curX + Xinc[i];
          nextY := curY + Yinc[i];
          if (nextX < 0) or (nextX > 479) or (nextY < 0) or (nextY > 479) then
            Bgrid[i] := 3 //Խ��
          else if Fway[nextX, nextY] >= 0 then
            Bgrid[i] := 2 //���߹�
          else if (Entrance[nextx, nexty] >= 0) then
            Bgrid[i] := 6 //���
          else if buildx[nextx, nexty] > 0 then
            Bgrid[i] := 1 //�谭
          else if ((surface[nextx, nexty] >= 1692) and (surface[nextx, nexty] <= 1700)) then
            Bgrid[i] := 1
          else if (earth[nextx, nexty] = 838) or ((earth[nextx, nexty] >= 612) and (earth[nextx, nexty] <= 670)) then
            Bgrid[i] := 1
          else if ((earth[nextx, nexty] >= 358) and (earth[nextx, nexty] <= 362)) or
            ((earth[nextx, nexty] >= 506) and (earth[nextx, nexty] <= 670)) or
            ((earth[nextx, nexty] >= 1016) and (earth[nextx, nexty] <= 1022)) then
          begin
            if (nextx = shipy) and (nexty = shipx) then
              Bgrid[i] := 4 //��
            else if ((surface[nextx, nexty] div 2 >= 863) and (surface[nextx, nexty] div 2 <= 872)) or
              ((surface[nextx, nexty] div 2 >= 852) and (surface[nextx, nexty] div 2 <= 854)) or
              ((surface[nextx, nexty] div 2 >= 858) and (surface[nextx, nexty] div 2 <= 860)) then
              Bgrid[i] := 0 //��
            else
              Bgrid[i] := 5; //ˮ
          end
          else
            Bgrid[i] := 0;
        end;
      end;
      //�ƶ������
    end;
    for i := 1 to 4 do
    begin
      if ((inship = 1) and (Bgrid[i] = 5)) or (((Bgrid[i] = 0) or (Bgrid[i] = 4)) and (inship = 0)) or
        ((Bgrid[i] = 6) and (mods = -2)) then
      begin
        Xlist[totalgrid] := curX + Xinc[i];
        Ylist[totalgrid] := curY + Yinc[i];
        steplist[totalgrid] := curstep + 1;
        Fway[Xlist[totalgrid], Ylist[totalgrid]] := steplist[totalgrid];
        totalgrid := totalgrid + 1;
      end;
    end;
    curgrid := curgrid + 1;
    if (where = 0) and (curX - Mx > max0) and (curY - My > max0) then break;
  end;
end;

procedure SDL_UpdateRect2(scr1: PSDL_Surface; x, y, w, h: integer);
var
  realx, realy, realw, realh, ZoomType: integer;
  tempscr: PSDL_Surface;
  now, Next: uint32;
  dest: TSDL_Rect;
  TextureID: GLUint;
begin
  dest.x := x;
  dest.y := y;
  dest.w := w;
  dest.h := h;
  if scr1 = screen then
  begin
    //sdl_setalpha(screen, SDL_SRCALPHA, 128);

    SDL_BlitSurface(screen, @dest, prescreen, @dest);
  end;

  if GLHR = 1 then
  begin
    glGenTextures(1, @TextureID);
    glBindTexture(GL_TEXTURE_2D, TextureID);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, screen.w, screen.h, 0, GL_BGRA, GL_UNSIGNED_BYTE, prescreen.pixels);

    if SMOOTH = 1 then
    begin
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    end
    else
    begin
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    end;

    glEnable(GL_TEXTURE_2D);
    glBegin(GL_QUADS);
    glTexCoord2f(0.0, 0.0);
    glVertex3f(-1.0, 1.0, 0.0);
    glTexCoord2f(1.0, 0.0);
    glVertex3f(1.0, 1.0, 0.0);
    glTexCoord2f(1.0, 1.0);
    glVertex3f(1.0, -1.0, 0.0);
    glTexCoord2f(0.0, 1.0);
    glVertex3f(-1.0, -1.0, 0.0);
    glEnd;
    glDisable(GL_TEXTURE_2D);
    SDL_GL_SwapBuffers();
    glDeleteTextures(1, @TextureID);
  end
  else
  begin
    if (RealScreen.w = screen.w) and (RealScreen.h = screen.h) then
    begin
      SDL_BlitSurface(prescreen, nil, RealScreen, nil);
    end
    else
    begin
      tempscr := zoomSurface(prescreen, RealScreen.w / screen.w, RealScreen.h / screen.h, SMOOTH);
      SDL_BlitSurface(tempscr, nil, RealScreen, nil);
      SDL_FreeSurface(tempscr);
    end;
    SDL_UpdateRect(RealScreen, 0, 0, RealScreen.w, RealScreen.h);
  end;

end;

procedure SDL_GetMouseState2(var x, y: integer);
var
  tempx, tempy: integer;
begin
  SDL_GetMouseState(tempx, tempy);
  x := tempx * screen.w div RealScreen.w;
  y := tempy * screen.h div RealScreen.h;

end;

procedure ResizeWindow(w, h: integer);
begin
  RealScreen := SDL_SetVideoMode(w, h, 32, ScreenFlag);
  event.type_ := 0;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

procedure SwitchFullscreen;
begin
  FULLSCREEN := 1 - FULLSCREEN;
  if FULLSCREEN = 0 then
  begin
    RealScreen := SDL_SetVideoMode(RESOLUTIONX, RESOLUTIONY, 32, ScreenFlag);
  end
  else
  begin
    RealScreen := SDL_SetVideoMode(CENTER_X * 2, CENTER_Y * 2, 32, ScreenFlag or SDL_FULLSCREEN);
  end;

end;

procedure QuitConfirm;
var
  tempscr: PSDL_Surface;
  menuString: array[0..1] of WideString;
begin
  if (EXIT_GAME = 0) or (AskingQuit = True) then
  begin
    if messagedlg('Are you sure to quit?', mtConfirmation, [mbOK, mbCancel], 0) = idOk then
      Quit;
  end
  else
  begin
    {if AskingQuit then
      exit;
    AskingQuit := True;
    tempscr := SDL_ConvertSurface(prescreen, screen.format, screen.flags);
    SDL_BlitSurface(tempscr, nil, screen, nil);
    DrawRectangleWithoutFrame(0, 0, screen.w, screen.h, 0, 50);
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    menuString[0] := 'ȡ��';
    menuString[1] := '�_�J';
    if CommonMenu(CENTER_X * 2 - 50, 2, 45, 1) = 1 then
      Quit;
    Redraw(1);
    SDL_BlitSurface(tempscr, nil, screen, nil);
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    SDL_FreeSurface(tempscr);
    AskingQuit := False;}
  end;

end;

procedure CheckBasicEvent;
var
  i, x, y: integer;
begin
  //if not (LoadingScence) then
  case event.type_ of
    SDL_QUITEV:
      QuitConfirm;
    SDL_VIDEORESIZE:
      ResizeWindow(event.resize.w, event.resize.h);
    {SDL_KEYUP:
      if (where = 2) and (event.key.keysym.sym = SDLK_ESCAPE) then
      begin
        for i := 0 to BRoleAmount - 1 do
        begin
          if Brole[i].Team = 0 then
            Brole[i].Auto := 0;
        end;
      end;}
  end;
  SDL_GetMouseState2(x, y);
  event.button.x := x;
  event.button.y := y;
  //event.button.x := event.button.x * RealScreen.w div screen.w;
  //event.button.y := event.button.y * RealScreen.h div screen.h;

end;

//��ɫ��仯, ��ͼ��˸Ч��

procedure ChangeCol;
var
  i, a, b: integer;
  temp: array[0..2] of byte;
begin

  a := $E7 * 3;
  temp[0] := ACol[a];
  temp[1] := ACol[a + 1];
  temp[2] := ACol[a + 2];

  for i := $E7 downto $E1 do
  begin
    b := i * 3;
    a := (i - 1) * 3;
    ACol[b] := ACol[a];
    ACol[b + 1] := ACol[a + 1];
    ACol[b + 2] := ACol[a + 2];
  end;

  b := $E0 * 3;
  ACol[b] := temp[0];
  ACol[b + 1] := temp[1];
  ACol[b + 2] := temp[2];

  a := $FC * 3;
  temp[0] := ACol[a];
  temp[1] := ACol[a + 1];
  temp[2] := ACol[a + 2];

  for i := $FC downto $F5 do
  begin
    b := i * 3;
    a := (i - 1) * 3;
    ACol[b] := ACol[a];
    ACol[b + 1] := ACol[a + 1];
    ACol[b + 2] := ACol[a + 2];
  end;

  b := $F4 * 3;
  ACol[b] := temp[0];
  ACol[b + 1] := temp[1];
  ACol[b + 2] := temp[2];

end;

//���㵱ǰ����λ��Ϊ��������
procedure GetMousePosition(var x, y: integer; x0, y0: integer; yp: integer = 0);
var
  x1, y1: integer;
begin
  SDL_GetMouseState2(x1, y1);
  x := (-x1 + CENTER_X + 2 * (y1 + yp) - 2 * CENTER_Y + 18) div 36 + x0;
  y := (x1 - CENTER_X + 2 * (y1 + yp) - 2 * CENTER_Y + 18) div 36 + y0;
end;


end.