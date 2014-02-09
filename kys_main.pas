unit kys_main;

{
 All Heros in Kam Yung's Stories - The Replicated Edition
 
 Created by S.weyl in 2008 May.
 No Copyright (C) reserved.
 
 You can build it by Delphi with JEDI-SDL support.
 
 This resouce code file which is not perfect so far,
 can be modified and rebuilt freely,
 or translate it to another programming language.
 But please keep this section when you want to spread a new vision. Thanks.
 Note: it must not be a good idea to use this as a pascal paradigm.

}

{
 �κ��˻����ݴ���֮��, ������������ɾ����, ����
 ����, ����Ϊ��������. ���뱣����������.
}

interface

uses
  SysUtils,
  Windows,
  Math,
  Dialogs,
  SDL,
  SDL_TTF,
  //SDL_mixer,
  SDL_image,
  iniFiles,
  Lua52,
  bass,
  kys_type;


//������Ҫ�ӳ�
procedure Run;
procedure Quit;

//��Ϸ��ʼ����, ���ߵ�
procedure Start;
procedure StartAmi;
procedure ReadFiles;
function InitialRole: boolean;
procedure LoadR(num: integer);
procedure SaveR(num: integer);

procedure Walk;
function CanWalk(x, y: integer): boolean;
procedure CheckEntrance;
function WalkInScene(Open: integer): integer;
procedure ShowSceneName(snum: integer);
function CanWalkInScene(x, y: integer): boolean;

procedure ShowRandomAttribute(ran: Bool);
function RandomAttribute: boolean;
procedure ReSetEntrance;


//ϵͳ�˵�
procedure MenuEsc;
procedure ShowMenu(menu: integer);
procedure MenuMedcine;
procedure MenuMedPoision;
function MenuItem(menu: integer): boolean;
function MPMenuItem(menu: integer): boolean;
function ReadItemList(ItemType: integer): integer;
procedure ShowMenuItem(row, col, x, y, atlu: integer);

procedure DrawItemFrame(x, y: integer);
procedure UseItem(inum: integer);
procedure MPUseItem(inum: integer);
function CanEquip(rnum, inum: integer): boolean;
procedure MenuStatus;
procedure ShowStatus(rnum: integer);
//procedure MenuLeave;
procedure MenuSystem;
procedure ShowMenuSystem(menu: integer);
procedure MenuLoad;
function MenuLoadAtBeginning: boolean;
procedure MenuSave;
procedure MenuQuit;
procedure XorCount(Data: pbyte; xornum: byte; length: integer);
procedure MenuDifficult;
procedure ShowSaveSuccess;
procedure ShowSkillMenu(menu: integer);

//ҽ��, �ⶾ, ʹ����Ʒ��Ч����
procedure EffectMedcine(role1, role2: integer);
procedure EffectMedPoision(role1, role2: integer);
procedure EatOneItem(rnum, inum: integer; isshow: boolean);

//�¼�ϵͳ
procedure CallEvent(num: integer);

procedure CheckHotkey(key: cardinal);
procedure FourPets;
function PetStatus(r: integer): boolean;
procedure ShowPetStatus(r, p: integer);
procedure DrawFrame(x, y, w: integer; color: uint32);
procedure PetLearnSkill(r, s: integer);
procedure ResistTheater;

//����
procedure initialeventtime;
procedure setbuild(snum: integer);
procedure initialmpmagic;
procedure initialziyuan;
procedure initialmp;
//����0-100���S�C��
procedure initialrandom;
function randomf1: integer;
function randomf2: integer;
function randomf3: integer;
procedure initialwujishu;
//����\����
procedure jiami(filename: string);

//����ս��ͼ���ɳ��ж���������
procedure initialWimage;


implementation

uses
  kys_event,
  kys_battle,
  kys_littlegame,
  kys_engine,
  kys_script,
  sty_engine,
  sty_show,
  sty_newevent;

//��ʼ������, ��Ч, ��Ƶ, ������Ϸ

procedure Run;
var
  title: string;
begin
{$IFDEF UNIX}
  AppPath := ExtractFilePath(ParamStr(0));
{$ELSE}
  AppPath := '';
{$ENDIF}
  //��ʼ����Ƶ
  SoundFlag := 0;
  if SOUND3D = 1 then
    SoundFlag := BASS_DEVICE_3D or SoundFlag;
  BASS_Init(-1, 22050, SoundFlag, 0, nil);
  //��ʼ��������ʾ

  //��ʼ������
  TTF_Init();
  font := TTF_OpenFont(CHINESE_FONT, CHINESE_FONT_SIZE);
  engfont := TTF_OpenFont(ENGLISH_FONT, ENGLISH_FONT_SIZE);
  font2 := TTF_OpenFont(CHINESE_FONT_SONGTI, CHINESE_FONT2_SIZE);
  engfont2 := TTF_OpenFont(ENGLISH_FONT, ENGLISH_FONT2_SIZE);
  if font = nil then
  begin
    MessageBox(0, pchar(Format('Error:%s!', [SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
    exit;
  end;

  //��ʼ����Ƶϵͳ
  Randomize;
  if (SDL_Init(SDL_INIT_VIDEO) < 0) then
  begin
    MessageBox(0, pchar(Format('Couldn''t initialize SDL : %s', [SDL_GetError])), 'Error', MB_OK or MB_ICONHAND);
    SDL_Quit;
    exit;
  end;

  //freemem(users[0],sizeof(uint16)*length(users));

  //freemem(user,sizeof(uint16));

  //��ʼ����Ƶϵͳ
  //InitalMusic;
  //SDL_Init(SDL_INIT_AUDIO);
  //Mix_OpenAudio(MIX_DEFAULT_FREQUENCY, MIX_DEFAULT_FORMAT, 2, 8192);
  SDL_WM_SetIcon(IMG_Load('resource\icon'), 0);
  title := 'In storys' + versionstr;

  SDL_WM_SetCaption(@title[1], 's.weyl��killer-G��luke19821001');

  InitialScript;
  ReadFiles;

  //���ｫscreen����Ϊ����ͼ����, ��ʵ�Ĵ�����realscreen
  ScreenFlag := SDL_RESIZABLE or SDL_DOUBLEBUF or SDL_ANYFORMAT;

  if HW = 0 then
    ScreenFlag := ScreenFlag or SDL_HWSURFACE
  else
    ScreenFlag := ScreenFlag or SDL_SWSURFACE;
  if FULLSCREEN <> 0 then
    ScreenFlag := ScreenFlag or SDL_FULLSCREEN;
  if GLHR = 1 then
    ScreenFlag := ScreenFlag or SDL_OPENGL;

  RealScreen := SDL_SetVideoMode(RESOLUTIONX, RESOLUTIONY, 32, screenFlag);

  if (RealScreen = nil) then
  begin
    MessageBox(0, pchar(Format('Couldn''t set 640x480x8 video mode : %s', [SDL_GetError])),
      'Error', MB_OK or MB_ICONHAND);
    SDL_Quit;
    halt(1);
  end;

  screen := SDL_CreateRGBSurface(ScreenFlag, CENTER_X * 2, CENTER_Y * 2, 32, RMASK, GMASK, BMASK, 0);
  prescreen := SDL_CreateRGBSurface(ScreenFlag, CENTER_X * 2, CENTER_Y * 2, 32, RMASK, GMASK, BMASK, 0);

  InitialMusic;

  Start;

  DestroyScript;
  TTF_CloseFont(font);
  TTF_CloseFont(engfont);
  TTF_CloseFont(font2);
  TTF_CloseFont(engfont2);
  TTF_Quit;
  SDL_Quit;
  halt(1);
  exit;

end;

//�ر������Ѵ򿪵���Դ, �˳�

procedure Quit;
begin
  DestroyScript;
  TTF_CloseFont(font);
  TTF_CloseFont(engfont);
  TTF_CloseFont(font2);
  TTF_CloseFont(engfont2);
  TTF_Quit;
  SDL_Quit;
  halt(1);
  exit;
end;

//��ͷ��Ļ

procedure StartAmi;
var
  str: WideString;
  p: integer;
begin
  instruct_14;
  DrawRectangleWithoutFrame(0, 0, screen.w, screen.h, 0, 100);
  ShowTitle(1609, 28515);
  DrawRectangleWithoutFrame(0, 0, screen.w, screen.h, 0, 100);
  ShowTitle(1610, 28515);
  instruct_14;
  //instruct_13;
end;

//��ȡ������ļ�

procedure ReadFiles;
var
  grp, idx, tnum, len, c, i, i1, l: integer;
  filename: string;
  p: puint16;
  cc: uint16;
begin
  Filename := ExtractFilePath(ParamStr(0)) + 'mod.ini';
  Kys_ini := TIniFile.Create(filename);

  try

    BEGIN_BATTLE_ROLE_PIC := 1;

    MAX_PHYSICAL_POWER := 100;
    BEGIN_WALKPIC := 5000;
    MONEY_ID := 0;
    COMPASS_ID := 1;
    MAX_LEVEL := 30;
    MAX_WEAPON_MATCH := 7;
    MIN_KNOWLEDGE := 0;
    MAX_HP := 9999;
    MAX_MP := 9999;
    LIFE_HURT := 100;
    MAP_ID := 401;
    MUSICVOLUME := Kys_ini.ReadInteger('constant', 'MUSIC_VOLUME', 64);
    SoundVolume := Kys_ini.ReadInteger('constant', 'SOUND_VOLUME', 32);
    MAX_ITEM_AMOUNT := 400;
    GAMESPEED := max(1, Kys_ini.ReadInteger('constant', 'GAME_SPEED', 10));
    SIMPLE := Kys_ini.ReadInteger('Set', 'simple', 0);
    Showanimation := Kys_ini.ReadInteger('Set', 'animation', 0);
    FULLSCREEN := Kys_ini.ReadInteger('Set', 'fullscreen', 0);
    BattleMode := Kys_ini.ReadInteger('Set', 'BattleMode', 0);
    HW := Kys_ini.ReadInteger('Set', 'HW', 0);

    SMOOTH := Kys_ini.ReadInteger('system', 'SMOOTH', 1);
    GLHR := Kys_ini.ReadInteger('system', 'GLHR', 1);

    RESOLUTIONX := Kys_ini.ReadInteger('system', 'RESOLUTIONX', CENTER_X * 2);
    RESOLUTIONY := Kys_ini.ReadInteger('system', 'RESOLUTIONY', CENTER_Y * 2);

    if Kys_ini.ReadString('Set', 'debug', '0') = '��Ҫ�����ڽ���' then debug := 1 else debug := 0;
    if debug = 1 then
    begin
      {BEGIN_EVENT := 172;
      BEGIN_Scene := 1;
      BEGIN_Sx := 38;
      BEGIN_Sy := 41;}
      BEGIN_EVENT := 1;
      BEGIN_Scene := 107;
      BEGIN_Sx := 29;
      BEGIN_Sy := 28;
    end
    else
    begin
      BEGIN_EVENT := 172;
      BEGIN_Scene := 1;
      BEGIN_Sx := 38;
      BEGIN_Sy := 41;
    end;

    MaxProList[58] := 1;


  finally
    //Kys_ini.Free;
  end;
  //showmessage(booltostr(fileexists(filename)));
  //showmessage(inttostr(max_level));

  if (FileExists('resource\pallet.COL')) then
  begin
    c := FileOpen('resource\pallet.COL', fmopenread);
    FileRead(c, Col[0][0], 4 * 768);
    FileClose(c);
  end;

  resetpallet;
  idx := FileOpen('resource\mmap.idx', fmopenread);
  grp := FileOpen('resource\mmap.grp', fmopenread);
  len := FileSeek(grp, 0, 2);
  FileSeek(grp, 0, 0);
  setlength(mpic, len);
  FileRead(grp, MPic[0], len);
  tnum := FileSeek(idx, 0, 2) div 4;
  FileSeek(idx, 0, 0);
  setlength(midx, tnum);
  FileRead(idx, MIdx[0], tnum * 4);
  FileClose(grp);
  FileClose(idx);

  idx := FileOpen('resource\sdx', fmopenread);
  grp := FileOpen('resource\smp', fmopenread);
  len := FileSeek(grp, 0, 2);
  FileSeek(grp, 0, 0);
  setlength(spic, len);
  FileRead(grp, SPic[0], len);
  tnum := FileSeek(idx, 0, 2) div 4;
  FileSeek(idx, 0, 0);
  setlength(sidx, tnum);
  FileRead(idx, SIdx[0], tnum * 4);
  FileClose(grp);
  FileClose(idx);

  {idx := fileopen('resource\wdx', fmopenread);
  grp := fileopen('resource\wmp', fmopenread);
  len := fileseek(grp, 0, 2);
  fileseek(grp, 0, 0);
  setlength(wpic, len);
  fileread(grp, WPic[0], len);
  tnum := fileseek(idx, 0, 2) div 4;
  fileseek(idx, 0, 0);
  setlength(widx, tnum);
  fileread(idx, WIdx[0], tnum * 4);
  fileclose(grp);
  fileclose(idx);}

  { idx := fileopen('resource\eft.idx', fmopenread);
   grp := fileopen('resource\eft.grp', fmopenread);
   len := fileseek(grp, 0, 2);
   fileseek(grp, 0, 0);
   fileread(grp, EPic[0], len);
   tnum := fileseek(idx, 0, 2) div 4;
   fileseek(idx, 0, 0);
   fileread(idx, EIdx[0], tnum * 4);
   fileclose(grp);
   fileclose(idx);

  idx := fileopen('resource\hdgrp.idx', fmopenread);
  grp := fileopen('resource\hdgrp.grp', fmopenread);
  len := fileseek(grp, 0, 2);
  fileseek(grp, 0, 0);
  fileread(grp, HPic[0], len);
  tnum := fileseek(idx, 0, 2) div 4;
  fileseek(idx, 0, 0);
  fileread(idx, HIdx[0], tnum * 4);
  fileclose(grp);
  fileclose(idx);

                  }

  if (FileExists(Scene_file)) then
  begin
    grp := FileOpen(Scene_file, fmopenread);
    FileSeek(grp, 0, 0);
    FileRead(grp, len, 4);
    setlength(Scenepic, len);
    for i := 0 to len - 1 do
      ScenePic[i] := GetPngPic(grp, i);
    FileClose(grp);
    //Setlength(BGidx, 0);
  end;

  if (FileExists(Heads_file)) then
  begin
    grp := FileOpen(Heads_file, fmopenread);
    FileSeek(grp, 0, 0);
    FileRead(grp, len, 4);
    setlength(Head_PIC, len);
    for i := 0 to len - 1 do
      Head_Pic[i] := GetPngPic(grp, i);
    FileClose(grp);
    //Setlength(BGidx, 0);
  end;

  if (FileExists(Skill_file)) then
  begin
    grp := FileOpen(Skill_file, fmopenread);
    FileSeek(grp, 0, 0);
    FileRead(grp, len, 4);
    setlength(SkillPIC, len);
    for i := 0 to len - 1 do
      SkillPIC[i] := GetPngPic(grp, i);
    FileClose(grp);
    //Setlength(BGidx, 0);
  end;
  if (FileExists(BACKGROUND_file)) then
  begin
    grp := FileOpen(BACKGROUND_file, fmopenread);

    {BEGIN_PIC := GetPngPic(grp, 0);
    MAGIC_PIC := GetPngPic(grp, 1);
    STATE_PIC := GetPngPic(grp, 2);
    SYSTEM_PIC := GetPngPic(grp, 3);
    MAP_PIC := GetPngPic(grp, 4);
    SHUPU_PIC := GetPngPic(grp, 5);
    MENUESC_PIC := GetPngPic(grp, 6);
    MENUESCBack_PIC := GetPngPic(grp, 7);
    battlePIC := GetPngPic(grp, 8);
    TEAMMATE_PIC := GetPngPic(grp, 9);
    MENUITEM_PIC := GetPngPic(grp, 10);
    PROGRESS_PIC := GetPngPic(grp, 11);
    MATESIGN_PIC := GetPngPic(grp, 12);
    ENEMYSIGN_PIC := GetPngPic(grp, 13);
    SELECTEDENEMY_PIC := GetPngPic(grp, 14);
    SELECTEDMATE_PIC := GetPngPic(grp, 15);
    NowPROGRESS_PIC := GetPngPic(grp, 16);
    angryprogress_pic := GetPngPic(grp, 17);
    angrycollect_pic := GetPngPic(grp, 18);
    angryfull_pic := GetPngPic(grp, 19);
    DEATH_PIC := GetPngPic(grp, 20);
    Maker_Pic := GetPngPic(grp, 21);
    DIZI_PIC:= GetPngPic(grp, 22);
    GONGJI_PIC:= GetPngPic(grp, 23);
    JIANSHE_PIC:= GetPngPic(grp, 24);
    MPNEIGONG_PIC:= GetPngPic(grp, 25);
    MPZHUANGTAI_PIC:= GetPngPic(grp, 26);
    RENMING_PIC := GetPngPic(grp, 27);
    SONGLI_PIC:= GetPngPic(grp, 28);
    YIDONG_PIC:= GetPngPic(grp, 29);
    MPLINE_PIC:= GetPngPic(grp, 30);
    TILILINE_PIC:= GetPngPic(grp, 31);
    HPLINE_PIC:= GetPngPic(grp, 32);
    HUIKUANG_PIC:= GetPngPic(grp, 33);
    HUANGKUANG_PIC:= GetPngPic(grp, 34);
    BIAOTIKUANG_PIC:= GetPngPic(grp, 35);
    HUIKUANG2_PIC:= GetPngPic(grp, 36);
    HUANGKUANG2_PIC:= GetPngPic(grp, 37); }
    BEGIN_PIC := GetPngPic(grp, 0);
    MAGIC_PIC := GetPngPic(grp, 1);
    STATE_PIC := GetPngPic(grp, 2);
    SYSTEM_PIC := GetPngPic(grp, 3);
    MAP_PIC := GetPngPic(grp, 4);
    SKILL_PIC := GetPngPic(grp, 5);
    MENUESC_PIC := GetPngPic(grp, 6);
    MENUESCBack_PIC := GetPngPic(grp, 7);
    battlePIC := GetPngPic(grp, 8);
    TEAMMATE_PIC := GetPngPic(grp, 9);
    MENUITEM_PIC := GetPngPic(grp, 10);
    PROGRESS_PIC := GetPngPic(grp, 11);
    MATESIGN_PIC := GetPngPic(grp, 12);
    ENEMYSIGN_PIC := GetPngPic(grp, 13);
    SELECTEDENEMY_PIC := GetPngPic(grp, 14);
    SELECTEDMATE_PIC := GetPngPic(grp, 15);
    NowPROGRESS_PIC := GetPngPic(grp, 16);
    angryprogress_pic := GetPngPic(grp, 17);
    angrycollect_pic := GetPngPic(grp, 18);
    angryfull_pic := GetPngPic(grp, 19);
    DEATH_PIC := GetPngPic(grp, 20);
    Maker_Pic := GetPngPic(grp, 21);
    DIZI_PIC := GetPngPic(grp, 22);
    GONGJI_PIC := GetPngPic(grp, 23);
    JIANSHE_PIC := GetPngPic(grp, 24);
    MPNEIGONG_PIC := GetPngPic(grp, 25);
    MPZHUANGTAI_PIC := GetPngPic(grp, 26);
    RENMING_PIC := GetPngPic(grp, 27);
    SONGLI_PIC := GetPngPic(grp, 28);
    YIDONG_PIC := GetPngPic(grp, 29);

    FileClose(grp);
    //Setlength(BGidx, 0);
  end;

  (* STATE_PIC := IMG_Load('resource\state.bok');
   MAGIC_PIC := IMG_Load('resource\magic.bok');
   SYSTEM_PIC := IMG_Load('resource\system.bok');
  *)
  c := FileOpen('resource\earth.002', fmopenread);
  FileRead(c, Earth[0, 0], 480 * 480 * 2);
  FileClose(c);
  c := FileOpen('resource\surface.002', fmopenread);
  FileRead(c, surface[0, 0], 480 * 480 * 2);
  FileClose(c);
  c := FileOpen('resource\building.002', fmopenread);
  FileRead(c, Building[0, 0], 480 * 480 * 2);
  FileClose(c);
  c := FileOpen('resource\buildx.002', fmopenread);
  FileRead(c, Buildx[0, 0], 480 * 480 * 2);
  FileClose(c);
  c := FileOpen('resource\buildy.002', fmopenread);
  FileRead(c, Buildy[0, 0], 480 * 480 * 2);
  FileClose(c);
  // c := fileopen('list\leave.bin', fmopenread);
  // fileread(c, leavelist[0], 200);
  // fileclose(c);

  c := FileOpen('list\Set.bin', fmopenread);
  l := sizeof(SetNum);
  FileRead(c, SetNum, l);
  FileClose(c);


  c := FileOpen('list\levelup.bin', fmopenread);
  l := sizeof(SetNum);
  FileRead(c, leveluplist[0], 200);
  FileClose(c);
  // c := fileopen('list\match.bin', fmopenread);
  // fileread(c, matchlist[0], MAX_WEAPON_MATCH * 3 * 2);
  // fileclose(c);

end;

//Main game.
//��ʾ��ͷ����

procedure Start;
var
  menu, menup, i, col, i1, ingame, i2, x, y, len, pic: integer;
  picb: array of byte;
  beginscreen: PSDL_Surface;
  dest: TSDL_Rect;
begin
  //Acupuncture(2);
  //InitialScript;
  StopMP3;
  PlayMP3(114, -1);
  SDL_EnableKeyRepeat(10, 100);
  ingame := 0;
  //  PlayBeginningMovie(0, -1);
  //PlayMpeg();
  display_imgfromSurface(BEGIN_PIC, 0, 0);
  DrawEngShadowText(@versionstr[1], CENTER_X - 320, CENTER_Y - 200, ColColor($63), ColColor($66));
  MStep := 0;
  // fullscreen := 0;
  where := 3;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  menu := 0;
  Setlength(RItemlist, MAX_ITEM_AMOUNT);
  for i := 0 to MAX_ITEM_AMOUNT - 1 do
  begin
    RItemlist[i].Number := -1;
    RItemlist[i].Amount := 0;
  end;
  Jxtips;
  x := 245;
  y := 290;
  //drawrectanglewithoutframe(270, 150, 100, 70, 0, 20);
  DrawTitlePic(0, x, y);
  DrawTitlePic(menu + 1, x + 12, y + 10 + menu * 23);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  initialBTalk;
  //WoodMan(3);
  //�¼��ȴ�
  while (ingame = 0) do
  begin
    while (SDL_WaitEvent(@event) >= 0) do
    begin

      CheckBasicEvent;

      //��ѡ���2��, ���˳�(���б�Ŵ�0��ʼ)
      if (((event.type_ = SDL_KEYUP) and ((event.key.keysym.sym = SDLK_RETURN) or
        (event.key.keysym.sym = SDLK_SPACE))) or ((event.type_ = SDL_MOUSEBUTTONUP) and
        (event.button.button = SDL_BUTTON_LEFT))) and (menu = 2) then
      begin
        ingame := 1;
        Quit;
      end;
      //ѡ���0��, ���¿�ʼ��Ϸ
      if (((event.type_ = SDL_KEYUP) and ((event.key.keysym.sym = SDLK_RETURN) or
        (event.key.keysym.sym = SDLK_SPACE))) or ((event.type_ = SDL_MOUSEBUTTONUP) and
        (event.button.button = SDL_BUTTON_LEFT))) and (menu = 0) then
      begin
        if InitialRole then
        begin
          initialWimage;
          initialMPdiaodu;
          showmr := False;
          CurScene := BEGIN_Scene;
          Rrole[0].weizhi := CurScene;
          StopMP3;
          PlayMP3(RScene[CurScene].ExitMusic, -1);
          SDL_EventState(SDL_MOUSEMOTION, SDL_ENABLE);

          WalkInScene(1);
          SDL_EventState(SDL_MOUSEMOTION, SDL_ignore);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        Redraw;
        DrawTitlePic(0, x, y);
        DrawTitlePic(menu + 1, x + 12, y + 10 + menu * 23);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      //ѡ���1��, �������
      if (((event.type_ = SDL_KEYUP) and ((event.key.keysym.sym = SDLK_RETURN) or
        (event.key.keysym.sym = SDLK_SPACE))) or ((event.type_ = SDL_MOUSEBUTTONUP) and
        (event.button.button = SDL_BUTTON_LEFT) and (event.button.x > x + 12) and
        (event.button.x < x + 116) and (event.button.y > y + 10) and (event.button.y < y + 79))) and (menu = 1) then
      begin
        showmr := True;

        //LoadR(1);
        if MenuLoadAtBeginning then
        begin
          //redraw;
          //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          //PlayBeginningMovie(26, 0);
          instruct_14;
          event.key.keysym.sym := 0;
          CurEvent := -1;
          break;
          //when CurEvent=-1, Draw Scene by Sx, Sy. Or by Cx, Cy.
        end
        else
        begin
          DrawTitlePic(0, x, y);
          DrawTitlePic(menu + 1, x + 12, y + 10 + menu * 23);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      //���·������
      if ((event.type_ = SDL_KEYUP) and ((event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8))) then
      begin
        menu := menu - 1;
        if menu < 0 then
          menu := 2;
        DrawTitlePic(0, x, y);
        DrawTitlePic(menu + 1, x + 12, y + 10 + menu * 23);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      //���·������
      if ((event.type_ = SDL_KEYUP) and ((event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2))) then
      begin
        menu := menu + 1;
        if menu > 2 then
          menu := 0;
        DrawTitlePic(0, x, y);
        DrawTitlePic(menu + 1, x + 12, y + 10 + menu * 23);
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      //����ƶ�
      if (event.type_ = SDL_MOUSEMOTION) then
      begin
        if (event.button.x > x + 12) and (event.button.x < x + 116) and (event.button.y > y + 10) and
          (event.button.y < y + 79) then
        begin
          menup := menu;
          menu := (event.button.y - y - 10) div 23;
          if menu <> menup then
          begin
            DrawTitlePic(0, x, y);
            DrawTitlePic(menu + 1, x + 12, y + 10 + menu * 23);
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
        end
        else menu := -1;
      end;

    end;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    if where = 1 then
    begin
      SDL_EventState(SDL_MOUSEMOTION, SDL_ENABLE);
      WalkInScene(0);
      SDL_EventState(SDL_MOUSEMOTION, SDL_ignore);
    end;
    if where >= 3 then
    begin
      StopMP3;
      PlayMP3(114, -1);
      SDL_EventState(SDL_MOUSEMOTION, SDL_ENABLE);
      display_imgfromSurface(BEGIN_PIC, 0, 0);
      DrawEngShadowText(@versionstr[1], CENTER_X - 320, CENTER_Y - 200, ColColor($63), ColColor($66));
      MStep := 0;
      DrawTitlePic(0, x, y);
      DrawTitlePic(menu + 1, x + 12, y + 10 + menu * 23);
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      continue;
    end;
    Walk;
    event.key.keysym.sym := 0;
    event.button.button := 0;
    Redraw;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  end;

  SDL_EnableKeyRepeat(30, (30 * gamespeed) div 10);
end;

//��ʼ����������

function InitialRole: boolean;
var
  i, battlemode2, x, y, t: integer;
  p: array[0..14] of integer;
  str, str0, Name: WideString;
  str1: string;
  p0, p1: pchar;
  LanId: word;
  lan: string;
begin
  fuli := 0;
  lanId := GetSystemDefaultLangID;
  battlemode2 := battlemode;
  LoadR(0);
  if debug = 1 then
  begin
    Rrole[0].Name := '�yԇ';
    Rrole[0].MaxHP := 9999;
    Rrole[0].CurrentHP := 9999;
    Rrole[0].MaxMP := 9999;
    Rrole[0].CurrentMP := 9999;
    Rrole[0].MPType := 2;
    Rrole[0].IncLife := 5;

    Rrole[0].Attack := 200;
    Rrole[0].Speed := 200;
    Rrole[0].Defence := 200;
    Rrole[0].Medcine := 0;
    Rrole[0].UsePoi := 0;
    Rrole[0].MedPoi := 0;
    Rrole[0].Fist := 200;
    Rrole[0].Sword := 200;
    Rrole[0].Knife := 200;
    Rrole[0].Unusual := 200;
    Rrole[0].HidWeapon := 200;

    Rrole[0].xiangxing := random(10);
    Rrole[0].Aptitude := 100;
    Rrole[0].fuyuan := 100;
    Rrole[0].LMagic[0] := 20;
    Rrole[0].LMagic[1] := 18;
    Rrole[0].MagLevel[0] := 100;
    Rrole[0].MagLevel[1] := 999;
    Rrole[0].Gongti := 0;
    Rrole[0].jhMagic[0] := 1;
    Rrole[0].level := 1;
    for i := 0 to length(Rscene) - 1 do
      setbuild(i);
    initialwugong;
    initialmpmagic;
    initialmp;
    initialrandom;
    initialwujishu;
    initialziyuan;
    for i := 0 to 19 do
    begin
      mpbdata[i].id := i;
      mpbdata[i].key := -1;
    end;
    M_idx[0] := 40 * 400 * 2;
    M_idx[1] := 40 * 400 * 2;
    initialeventtime;
    exit;
  end;

  if (lanId = 2052) or (lanId = 1028) then
  begin
    if lanid = 2052 then
      lan := 'SC';
    if lanId = 1028 then
      lan := 'TC';
  end
  else
    lan := 'E';
  t := 0;
  {for i := 1 to 6 do
  begin
    LoadR(i);
    t := max(gametime, t);
  end;  }


  {gametime := max(gametime, t);
  battlemode := battlemode2;
  if battlemode > gametime then
    battlemode := min(gametime, 2); }

  where := 3;
  //��ʾ���������ĶԻ���
  //form1.ShowModal;
  //str := form1.edit1.text;
  x := 275;
  y := 250;

  Redraw;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

  if lan = 'SC' then
  begin
    str1 := '����'; //Ĭ����
    str := '�����������������[��Ոݔ������Ї�������ʽ�����֡�';
  end;
  if lan = 'E' then
  begin
    str1 := '����'; //Ĭ����
    str := 'Mr.Kam, please input your name in Unicode              ';
  end;
  if lan = 'TC' then
  begin
    str1 := UnicodeToBig5('����'); //Ĭ����
    str := UnicodeToBig5('�����������������[��Ոݔ������Ї�������ʽ�����֡�');
  end;

  str1 := Simplified2Traditional(pinyinshuru(str));

  if str1 = '' then Result := False;
  if str1 <> '' then
  begin
    Name := str1;

    //str1 := unicodetogbk(@name[1]);
    p0 := @Rrole[0].Name;
    p1 := @str1[1];
    for i := 0 to 4 do
      Rrole[0].Data[4 + i] := 0;
    for i := 0 to 7 do
    begin
      (p0 + i)^ := (p1 + i)^;
    end;
    if Name = '�f��' then
      fuli := 1
    else if (Name = '��·����') or (name ='���TС�c')  then
      fuli := 2
    else if (Name = '�ǿ�') or (Name = '�o�h') then
      fuli := 3;
    Redraw;
    Result := RandomAttribute;
    if Result then
    begin //redraw;
      {if gametime > 0 then
        MenuDifficult; }
      for i := 0 to length(Rscene) - 1 do
        setbuild(i);
      initialwugong;
      initialmpmagic;
      initialmp;
      initialrandom;
      initialwujishu;
      initialziyuan;
      for i := 0 to 19 do
      begin
        mpbdata[i].id := i;
        mpbdata[i].key := -1;
      end;
      M_idx[0] := 40 * 400 * 2;
      M_idx[1] := 40 * 400 * 2;
      // PlayBeginningMovie(26, 0);
      initialeventtime;
      if fuli = 3 then
      begin
        instruct_2(141, 1);
        instruct_2(15, 3);
        instruct_2(0, 300);
      end;
      StartAmi;
      //EndAmi;
    end;
  end;

end;

procedure ShowRandomAttribute(ran: Bool);
var
  tip: WideString;
  maxnum, jichunum,HpMp: smallint;

begin
  maxnum := 100;
  if fuli = 1 then maxnum := 120;
  jichunum := 6;
  if fuli = 2 then jichunum := 7;
  HpMp := 50;
  if fuli = 2 then HpMp := 75;
  tip := '�x�������ᰴY';
  if (ran = True) then
  begin
    {Rrole[0].MaxHP := 51 + random(50);
    Rrole[0].CurrentHP := Rrole[0].MaxHP;
    Rrole[0].MaxMP := 51 + random(50);
    Rrole[0].CurrentMP := Rrole[0].MaxMP;
    Rrole[0].MPType := random(2);
    Rrole[0].IncLife := 1 + random(10);

    Rrole[0].Attack := 25 + random(6);
    Rrole[0].Speed := 25 + random(6);
    Rrole[0].Defence := 25 + random(6);
    Rrole[0].Medcine := 25 + random(6);
    Rrole[0].UsePoi := 25 + random(6);
    Rrole[0].MedPoi := 25 + random(6);
    Rrole[0].Fist := 25 + random(6);
    Rrole[0].Sword := 25 + random(6);
    Rrole[0].Knife := 25 + random(6);
    Rrole[0].Unusual := 25 + random(6);
    Rrole[0].HidWeapon := 25 + random(6);

    rrole[0].Aptitude := 1 + random(100);}

    Rrole[0].MaxHP := 50 + random(HpMp);
    Rrole[0].CurrentHP := Rrole[0].MaxHP;
    Rrole[0].MaxMP := 50 + random(HpMp);
    Rrole[0].CurrentMP := Rrole[0].MaxMP;
    Rrole[0].MPType := random(3);
    Rrole[0].IncLife := 1 + random(10);

    Rrole[0].Attack := 25 + random(jichunum);
    Rrole[0].Speed := 25 + random(jichunum);
    Rrole[0].Defence := 25 + random(jichunum);
    Rrole[0].Medcine := 0;
    Rrole[0].UsePoi := 0;
    Rrole[0].MedPoi := 0;
    Rrole[0].Fist := 25 + random(jichunum);
    Rrole[0].Sword := 25 + random(jichunum);
    Rrole[0].Knife := 25 + random(jichunum);
    Rrole[0].Unusual := 25 + random(jichunum);
    Rrole[0].HidWeapon := 25 + random(jichunum);

    Rrole[0].xiangxing := random(10);
    Rrole[0].Aptitude := 1 + random(100);
    Rrole[0].fuyuan := min(100, maxnum - Rrole[0].Aptitude + random(11));
    Rrole[0].level := 1;

  end;
  Redraw;
  ShowStatus(0);

  DrawShadowText(@tip[1], 210, CENTER_Y + 111, ColColor($5), ColColor($7));
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

function RandomAttribute: boolean;
var
  pwd: WideString;
  keyvalue: integer;
begin
  repeat
    ShowRandomAttribute(True);
    keyvalue := WaitAnyKey;
  until (keyvalue = SDLK_y) or (keyvalue = SDLK_ESCAPE);
  if (keyvalue = SDLK_y) then
  begin
    ShowRandomAttribute(False);
    Result := True;
  end
  else
    Result := False;
end;

procedure XorCount(Data: pbyte; xornum: byte; length: integer);
var
  i: integer;
begin
  for i := 0 to length - 1 do
  begin
    Data^ := byte(Data^ xor byte(xornum));
    Inc(Data);
  end;
end;


//����浵, ��Ϊ0�������ʼ�浵

procedure LoadR(num: integer);
var
  filename1, filename, filename2: string;
  idx, grp, i1, i2, len, len1, wei, tmp2: integer;
  BasicOffset, RoleOffset, ItemOffset, SceneOffset, MagicOffset, WeiShopOffset, dateoffset,
  zhaoshioffset, menpaioffset, i: integer;
  str: string;
  str1: WideString;
  p1, p0: pchar;
  key, pass: byte;
  data1: pbyte;
  m6len: array[0..19] of array[0..3] of smallint;
  tmp1: smallint;
begin
  RStishi.num := 0;
  SaveNum := num;
  filename := 'R' + IntToStr(num);
  filename1 := 'save\' + 'R' + IntToStr(num) + '.grp';

  if num = 0 then
    filename := 'ranger';

  if num = 0 then
  begin
    RccRole.Count := 0;
    setlength(Rrenwu, 0);
  end;

  idx := FileOpen('save\ranger.idx', fmopenread);
  grp := FileOpen('save\' + filename + '.grp', fmopenread);

  FileRead(idx, RoleOffset, 4);
  FileRead(idx, ItemOffset, 4);
  FileRead(idx, SceneOffset, 4);
  FileRead(idx, MagicOffset, 4);
  FileRead(idx, WeiShopOffset, 4);
  FileRead(idx, dateoffset, 4);
  FileRead(idx, zhaoshioffset, 4);
  FileRead(idx, menpaioffset, 4);
  FileRead(idx, len, 4);
  key := 182;
  wei := 0;
  FileSeek(grp, 0, 0);
  FileRead(grp, Inship, 2);
  data1 := @Inship;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;

  FileRead(grp, where, 2);
  data1 := @where;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, My, 2);
  data1 := @My;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, Mx, 2);
  data1 := @Mx;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, Sy, 2);
  data1 := @Sy;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, Sx, 2);
  data1 := @Sx;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, Mface, 2);
  data1 := @Mface;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, shipx, 2);
  data1 := @shipx;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, shipy, 2);
  data1 := @shipy;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, time, 2);
  data1 := @time;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, timeevent, 2);
  data1 := @timeevent;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, randomevent, 2);
  data1 := @randomevent;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, Sface, 2);
  data1 := @Sface;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, shipface, 2);
  data1 := @shipface;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, teamcount, 2);
  data1 := @teamcount;
  for i := 0 to 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, teamlist[0], 2 * 6);
  data1 := @teamlist[0];
  for i := 0 to 2 * 6 - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, Ritemlist[0], sizeof(Titemlist) * MAX_ITEM_AMOUNT);
  data1 := @Ritemlist[0];
  for i := 0 to sizeof(Titemlist) * MAX_ITEM_AMOUNT - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  setlength(Rrole, (ItemOffset - RoleOffset) div sizeof(Trole));
  FileRead(grp, Rrole[0], ItemOffset - RoleOffset);
  data1 := @Rrole[0];
  for i := 0 to ItemOffset - RoleOffset - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  setlength(Ritem, (SceneOffset - ItemOffset) div sizeof(TItem));
  FileRead(grp, Ritem[0], SceneOffset - ItemOffset);
  data1 := @Ritem[0];
  for i := 0 to SceneOffset - ItemOffset - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  setlength(ITEM_PIC, length(Ritem));
  setlength(RScene, (MagicOffset - SceneOffset) div sizeof(TScene));
  Setlength(SceAnpai, (MagicOffset - SceneOffset) div sizeof(TScene));
  FileRead(grp, RScene[0], MagicOffset - SceneOffset);
  data1 := @Rscene[0];
  for i := 0 to MagicOffset - SceneOffset - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  setlength(Rmagic, (WeiShopOffset - MagicOffset) div sizeof(TMagic));
  FileRead(grp, Rmagic[0], WeiShopOffset - MagicOffset);
  data1 := @Rmagic[0];
  for i := 0 to WeiShopOffset - MagicOffset - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  setlength(Rshop, (dateoffset - WeiShopOffset) div sizeof(Tshop));
  FileRead(grp, Rshop[0], dateoffset - WeiShopOffset);
  data1 := @Rshop[0];
  for i := 0 to dateoffset - WeiShopOffset - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  FileRead(grp, wdate[0], zhaoshioffset - dateoffset);
  data1 := @wdate[0];
  for i := 0 to zhaoshioffset - dateoffset - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  setlength(Rzhaoshi, (menpaioffset - zhaoshiOffset) div sizeof(Tzhaoshi));
  FileRead(grp, Rzhaoshi[0], menpaioffset - zhaoshiOffset);
  data1 := @Rzhaoshi[0];
  for i := 0 to menpaioffset - zhaoshiOffset - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;

  setlength(Rmenpai, (len - menpaioffset) div sizeof(Tmenpai));
  FileRead(grp, Rmenpai[0], len - menpaioffset);
  data1 := @Rmenpai[0];
  for i := 0 to len - menpaioffset - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;

  FileClose(idx);
  FileClose(grp);

  if SmallInt(where) < 0 then
  begin
    where := 0;
    Rrole[0].weizhi := -1;
  end
  else
  begin
    curScene := where;
    where := 1;
    Rrole[0].weizhi := CurScene;
  end;
  //��ʼ�����
  ReSetEntrance;
  len := length(RScene);
  setlength(Sdata, len);
  setlength(Ddata, len);
  filename := 'S' + IntToStr(num);
  if num = 0 then
    filename := 'Allsin';
  grp := FileOpen('save\' + filename + '.grp', fmopenread);
  FileRead(grp, Sdata[0], len * 64 * 64 * 6 * 2);
  FileClose(grp);
  wei := 0;
  data1 := @Sdata[0];
  for i := 0 to len * 64 * 64 * 6 * 2 - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;
  filename := 'D' + IntToStr(num);
  filename2 := 'save\' + 'D' + IntToStr(num) + '.grp';
  if num = 0 then
    filename := 'Alldef';
  grp := FileOpen('save\' + filename + '.grp', fmopenread);


  FileRead(grp, Ddata[0], len * 400 * 18 * 2);
  FileClose(grp);

  wei := 0;
  data1 := @Ddata[0];
  for i := 0 to len * 400 * 18 * 2 - 1 do
  begin
    pass := key shl (wei mod 5);
    data1^ := data1^ xor pass;
    Inc(data1);
    Inc(wei);
  end;

  { ��DDATA��ÿ����200���ݵ�400ʱ��ʱʹ��
  filename := 'D'+ inttostr(num);
  if num = 0 then
    filename := 'Alldef';
  grp := filecreate('save\'+ filename + '.grp');
  tmp1:=0;
  for i:=0 to len -1 do
  begin
    filewrite(grp, Ddata[i div 2][(i mod 2)*200], 200 * 18 * 2);
    for i1:=0 to 200*18-1 do
      filewrite(grp, tmp1, 2);
  end;
  fileclose(grp);
  jiami('save\'+ filename + '.grp');
  if num = 0 then
    filename := 'Alldef';
  idx := filecreate('save\'+ filename + '.idx');
  for i:=0 to len -1 do
  begin
    tmp2:=(i+1)*400*18*2;
    filewrite(idx, tmp2, 4);

  end;
  fileclose(idx); }



  if num > 0 then
  begin
    filename := 'M' + IntToStr(num);
    idx := FileOpen('save\' + filename + '.idx', fmopenread);
    FileRead(idx, M_idx[0], 11 * 4);
    FileClose(idx);

    setlength(songli, (M_idx[1] - M_idx[0]) div 12);
    setlength(wujishu, (M_idx[5] - M_idx[4]) div 2);
    setlength(Rtishi, (M_idx[6] - M_idx[5]) div 6);
    filename := 'M' + IntToStr(num);
    grp := FileOpen('save\' + filename + '.grp', fmopenread);
    FileRead(grp, Rmpmagic[0][0], M_idx[0]);
    FileRead(grp, songli[0][0], M_idx[1] - M_idx[0]);
    FileRead(grp, rdarr1[0], M_idx[2] - M_idx[1]);
    FileRead(grp, rdarr2[0], M_idx[3] - M_idx[2]);
    FileRead(grp, rdarr3[0], M_idx[4] - M_idx[3]);
    FileRead(grp, wujishu[0], M_idx[5] - M_idx[4]);
    FileRead(grp, Rtishi[0], M_idx[6] - M_idx[5]);

    FileRead(grp, RccRole.Count, 2);
    setlength(RccRole.adds, RccRole.Count);
    FileRead(grp, RccRole.adds[0], RccRole.Count * 4 * 2);

{$O-}for i1 := 0 to 19 do
    begin
      FileRead(grp, mpbdata[i1], 14);
{$O-}for i2 := 0 to 3 do
      begin
        FileRead(grp, m6len[i1][i2], 2);
        setlength(mpbdata[i1].BTeam[i2].RoleArr, m6len[i1][i2] div 8);
        FileRead(grp, mpbdata[i1].BTeam[i2].RoleArr[0], m6len[i1][i2]);
      end;
    end;
    FileRead(grp, x50[-$8000], M_idx[9] - M_idx[8]);
    FileRead(grp, len, 4);
    if len > 0 then
      setlength(Rrenwu, len)
    else
      setlength(Rrenwu, 0);
    for i := 0 to len - 1 do
    begin
      FileRead(grp, Rrenwu[i].num, 2);
      FileRead(grp, Rrenwu[i].talknum, 2);
      FileRead(grp, Rrenwu[i].status, 2);
      FileRead(grp, Rrenwu[i].moon, 2);
      FileRead(grp, Rrenwu[i].day, 2);
    end;

    FileRead(grp, RStishi.num, 4);
    setlength(RStishi.stishi, RStishi.num);
    for i := 0 to RStishi.num - 1 do
    begin
      FileRead(grp, RStishi.stishi[i].talklen, 2);
      FileRead(grp, RStishi.stishi[i].moon, 2);
      FileRead(grp, RStishi.stishi[i].day, 2);
      setlength(RStishi.stishi[i].talk, RStishi.stishi[i].talklen);
      FileRead(grp, RStishi.stishi[i].talk[0], RStishi.stishi[i].talklen);

    end;

    FileClose(grp);
  end;

  //gametime := min(gametime, 2);

  {if battlemode > min(gametime, 2) then battlemode := min(gametime, 2); }
  loadrenwus;
  if battlemode > 2 then battlemode := 2;
  MAX_LEVEL := 30;
  tipsx := -200;
  tipsy := CENTER_Y * 2 - 40;

end;

//����\����

procedure jiami(filename: string);
var
  f, len, i: integer;
  a: array of byte;
  key, pass: byte;
begin
  key := 182;
  F := FileOpen(filename, fmopenread);
  len := FileSeek(f, 0, 2);
  FileSeek(f, 0, 0);
  setlength(a, len);
  FileRead(F, a[0], len);
  FileClose(F);
  for I := 0 to len - 1 do
  begin
    pass := key shl (i mod 5);
    a[i] := a[i] xor pass;
  end;
  F := filecreate(filename);
  FileWrite(f, a[0], len);
  FileClose(f);

end;

//�浵

procedure SaveR(num: integer);
var
  filename: string;
  sgrp, dgrp, mgrp, ridx, rgrp, midx, i1, i2, len, SceneAmount: integer;
  BasicOffset, RoleOffset, ItemOffset, SceneOffset, MagicOffset, WeiShopOffset, dateoffset,
  zhaoshioffset, menpaioffset, i: integer;
  //key: uint16;
  str: WideString;
  Rkey: uint16;
  M6len: array[0..19] of array[0..3] of smallint;
begin
  Rkey := uint16(random($FFFF));

  SaveNum := num;
  filename := 'R' + IntToStr(num);
  if num = 0 then
    filename := 'ranger';
  ridx := FileOpen('save\ranger.idx', fmopenreadwrite);
  rgrp := filecreate('save\' + filename + '.grp', fmopenreadwrite);
  BasicOffset := 0;
  FileRead(ridx, RoleOffset, 4);
  FileRead(ridx, ItemOffset, 4);
  FileRead(ridx, SceneOffset, 4);
  FileRead(ridx, MagicOffset, 4);
  FileRead(ridx, WeiShopOffset, 4);
  FileRead(ridx, dateoffset, 4);
  FileRead(ridx, zhaoshioffset, 4);
  FileRead(ridx, menpaioffset, 4);
  FileRead(ridx, len, 4);

  FileSeek(rgrp, 0, 0);
  FileWrite(rgrp, Inship, 2);
  if where = 0 then
  begin
    useless1 := -1;
    FileWrite(rgrp, useless1, 2);
  end
  else
    FileWrite(rgrp, curScene, 2);
  FileWrite(rgrp, My, 2);
  FileWrite(rgrp, Mx, 2);
  FileWrite(rgrp, Sy, 2);
  FileWrite(rgrp, Sx, 2);
  FileWrite(rgrp, Mface, 2);
  FileWrite(rgrp, shipx, 2);
  FileWrite(rgrp, shipy, 2);
  FileWrite(rgrp, time, 2);
  FileWrite(rgrp, timeevent, 2);
  FileWrite(rgrp, randomevent, 2);
  FileWrite(rgrp, Sface, 2);
  FileWrite(rgrp, shipface, 2);
  FileWrite(rgrp, teamcount, 2);
  FileWrite(rgrp, teamlist[0], 2 * 6);
  FileWrite(rgrp, Ritemlist[0], sizeof(Titemlist) * MAX_ITEM_AMOUNT);

  FileWrite(rgrp, Rrole[0], ItemOffset - RoleOffset);
  FileWrite(rgrp, Ritem[0], SceneOffset - ItemOffset);
  FileWrite(rgrp, RScene[0], MagicOffset - SceneOffset);
  FileWrite(rgrp, Rmagic[0], WeiShopOffset - MagicOffset);
  FileWrite(rgrp, Rshop[0], dateoffset - WeiShopOffset);
  FileWrite(rgrp, wdate[0], zhaoshioffset - dateoffset);
  FileWrite(rgrp, Rzhaoshi[0], menpaioffset - zhaoshioffset);
  FileWrite(rgrp, Rmenpai[0], len - menpaioffset);

  FileClose(rgrp);
  FileClose(ridx);
  jiami('save\' + filename + '.grp');
  SceneAmount := length(RScene);

  filename := 'S' + IntToStr(num);
  if num = 0 then
    filename := 'Allsin';
  sgrp := filecreate('save\' + filename + '.grp');
  FileWrite(sgrp, Sdata[0], SceneAmount * 64 * 64 * 6 * 2);
  FileClose(sgrp);
  jiami('save\' + filename + '.grp');
  filename := 'D' + IntToStr(num);
  if num = 0 then
    filename := 'Alldef';
  dgrp := filecreate('save\' + filename + '.grp');
  FileWrite(dgrp, Ddata[0], SceneAmount * 400 * 18 * 2);
  FileClose(dgrp);
  jiami('save\' + filename + '.grp');

  M_idx[1] := M_idx[0] + length(songli) * 12;
  M_idx[2] := M_idx[1] + 10 * 2;
  M_idx[3] := M_idx[2] + 10 * 2;
  M_idx[4] := M_idx[3] + 10 * 2;
  M_idx[5] := M_idx[4] + length(wujishu) * 2;
  M_idx[6] := M_idx[5] + length(Rtishi) * 6;
  M_idx[7] := M_idx[6] + 2 + RccRole.Count * 2 * 4;
  M_idx[8] := M_idx[7];
  for i1 := 0 to 19 do
  begin
    M_idx[8] := M_idx[8] + 14 + 2 * 4;
    for i2 := 0 to 3 do
    begin
      m6len[i1][i2] := length(mpbdata[i1].BTeam[i2].RoleArr) * 8;
      M_idx[8] := M_idx[8] + m6len[i1][i2];
    end;
  end;
  M_idx[9] := M_idx[8] + length(x50) * 2;
  M_idx[10] := M_idx[9] + length(Rrenwu) * 10 + 4;
  filename := 'M' + IntToStr(num);
  midx := filecreate('save\' + filename + '.idx');
  FileWrite(midx, M_idx[0], 10 * 4);

  filename := 'M' + IntToStr(num);
  mgrp := filecreate('save\' + filename + '.grp');
  FileWrite(mgrp, Rmpmagic[0][0], M_idx[0]);
  FileWrite(mgrp, songli[0][0], M_idx[1] - M_idx[0]);
  FileWrite(mgrp, rdarr1[0], M_idx[2] - M_idx[1]);
  FileWrite(mgrp, rdarr2[0], M_idx[3] - M_idx[2]);
  FileWrite(mgrp, rdarr3[0], M_idx[4] - M_idx[3]);
  FileWrite(mgrp, wujishu[0], M_idx[5] - M_idx[4]);
  FileWrite(mgrp, Rtishi[0], M_idx[6] - M_idx[5]);
  FileWrite(mgrp, RccRole.Count, 2);
  FileWrite(mgrp, RccRole.adds[0], RccRole.Count * 4 * 2);
  for i1 := 0 to 19 do
  begin
    FileWrite(mgrp, MPBdata[i1], 14);
    for i2 := 0 to 3 do
    begin
      FileWrite(mgrp, m6len[i1][i2], 2);
      FileWrite(mgrp, MPBdata[i1].BTeam[i2].RoleArr[0], m6len[i1][i2]);
    end;
  end;
  FileWrite(mgrp, x50[-$8000], M_idx[9] - M_idx[8]);
  len := length(Rrenwu);
  if len < 0 then
    len := 0;
  FileWrite(mgrp, len, 4);
  for i := 0 to len - 1 do
  begin
    FileWrite(mgrp, Rrenwu[i].num, 2);
    FileWrite(mgrp, Rrenwu[i].talknum, 2);
    FileWrite(mgrp, Rrenwu[i].status, 2);
    FileWrite(mgrp, Rrenwu[i].moon, 2);
    FileWrite(mgrp, Rrenwu[i].day, 2);
  end;
  FileWrite(mgrp, RStishi.num, 4);
  for i := 0 to RStishi.num - 1 do
  begin
    FileWrite(mgrp, RStishi.stishi[i].talklen, 2);
    FileWrite(mgrp, RStishi.stishi[i].moon, 2);
    FileWrite(mgrp, RStishi.stishi[i].day, 2);
    FileWrite(mgrp, RStishi.stishi[i].talk[0], RStishi.stishi[i].talklen);

  end;
  FileClose(mgrp);
  FileClose(midx);

end;

//������ͼ����

procedure Walk;
var
  word: array[0..10] of uint16;
  x, y, i1, i, Ayp, menu, Axp, walking, Mx1, My1, Mx2, My2, before, n, speed: integer;
  now, next_time: uint32;
  worddate: WideString;
  isdraw: boolean;
  pos: tposition;
begin
  Rrole[0].weizhi := -1;
  Where := 0;
  next_time := SDL_GetTicks;
  before := next_time;
  walking := 0;
  speed := 0;
  resetpallet;
  DrawMMap;
  SDL_EnableKeyRepeat(30, 30);
  SDL_EventState(SDL_MOUSEMOTION, SDL_ignore);
  StopMP3;
  PlayMP3(16, -1);
  still := 0;
  n := 0;
  isdraw := False;
  event.key.keysym.sym := 0;
  //�¼���ѯ(���ǵȴ�)
  while SDL_PollEvent(@event) >= 0 do
  begin

    //�����ǰ���ڱ��⻭��, ���˳�, ����ս��ʧ��
    if where >= 3 then
    begin
      break;
    end;
    //����ͼ��̬Ч��, ʵ�ʽ������ǵĶ���,luke����С�Nʿ
    {if n >100 then
    begin
      now := sdl_getticks;
      n:=0;
    end;
    inc(n);}
    now := SDL_GetTicks;
    if (integer(now) - integer(before) > 40) then
    begin
      if tipsx < -400 then
      begin
        tipsstring := gettips;
        tipsx := CENTER_X * 2;
      end
      else
        Dec(tipsx, 10);
      before := now;
      isdraw := True;
      //DrawMMap;
      //SDL_UpdateRect2(screen, 0, tipsy, screen.w, tipsy +22);
      ChangeCol;
    end;
    if (integer(now) - integer(next_time) > 0) then
    begin
      if (Mx2 = Mx) and (My2 = My) then
      begin
        still := 1;
        mstep := mstep + 1;
        if mstep > 6 then
          mstep := 1;
      end;
      Mx2 := Mx;
      My2 := My;
      if still = 1 then
        next_time := integer(now) + 500
      else
        next_time := integer(now) + 2000;
      isdraw := True;
      //DrawMMap;
      //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    end;

    //���������������, ���������λ���ƶ�����, ������ʹ���������
    if (nowstep >= 0) and (walking = 1) then
    begin
      still := 0;
      if sign(linex[nowstep] - Mx) < 0 then
        MFace := 0
      else if sign(linex[nowstep] - Mx) > 0 then
        MFace := 3
      else if sign(liney[nowstep] - My) > 0 then
        MFace := 1
      else MFace := 2;
      MStep := 6 - nowstep mod 6;
      Mx := linex[nowstep];
      My := liney[nowstep];
      Dec(nowstep);
      //ÿ��һ�����ػ���Ļ, ������Ƿ���ĳ�������
      adddate(1);
      //DrawMMap;
      //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      isdraw := True;
      SDL_Delay(2 * (10 + GameSpeed));
      //sdl_delay(5);

      CheckEntrance;

      if inship = 1 then
      begin
        shipx := My;
        shipy := Mx;
      end;
      if (shipy = Mx) and (shipx = My) then
      begin
        inship := 1;
      end;
    end
    else
    begin
      walking := 0;
      SDL_Delay(2 * (10 + GameSpeed));
    end;
    //SDL_EnableKeyRepeat(30, (30*gamespeed) div 10);
    CheckBasicEvent;
    case event.type_ of
      //�����ʹ��ѹ�°����¼�
      SDL_KEYDOWN:
      begin
        speed := speed + 1;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          still := 0;
          MFace := 2;
          MStep := Mstep + 1;
          if MStep > 6 then
            MStep := 1;
          if CanWalk(Mx, My - 1) then
          begin
            My := My - 1;
          end;
          adddate(1);
          //DrawMMap;
          //sdl_delay(5);
          //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          isdraw := True;
          CheckEntrance;
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          still := 0;
          MFace := 1;
          MStep := Mstep + 1;
          if MStep > 6 then
            MStep := 1;
          if CanWalk(Mx, My + 1) then
          begin
            My := My + 1;
          end;
          adddate(1);
          //DrawMMap;
          //sdl_delay(5);
          //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          isdraw := True;
          CheckEntrance;
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          still := 0;
          MFace := 0;
          MStep := Mstep + 1;
          if MStep > 6 then
            MStep := 1;
          if CanWalk(Mx - 1, My) then
          begin
            Mx := Mx - 1;
          end;
          adddate(1);
          //DrawMMap;
          //sdl_delay(5);
          //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          isdraw := True;
          CheckEntrance;
        end;
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          still := 0;
          MFace := 3;
          MStep := Mstep + 1;
          if MStep > 6 then
            MStep := 1;
          if CanWalk(Mx + 1, My) then
          begin
            Mx := Mx + 1;
          end;
          adddate(1);
          //DrawMMap;
          //sdl_delay(5);
          //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          isdraw := True;
          CheckEntrance;
        end;
        if inship = 1 then
        begin
          shipx := My;
          shipy := Mx;
        end;

        //SDL_Delay(2 * (10 + GameSpeed));
        //event.key.keysym.sym := 0;
        //event.button.button := 0;
      end;
      //���ܼ�(esc)ʹ���ɿ������¼�
      SDL_KEYUP:
      begin
        speed := 0;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          //event.key.keysym.sym:=0;
          newMenuEsc;
          nowstep := -1;
          walking := 0;
        end;
          {if (event.key.keysym.sym = sdlk_f11) then
          begin
            execscript(pchar('script\1.lua'), pchar('f1'));
          end;
          if (event.key.keysym.sym = sdlk_f10) then
          begin
            callevent(1);
          end;}


          {if (event.key.keysym.sym = sdlk_f4) then
          begin

            menu := 0;
            setlength(Menustring, 0);
            setlength(menustring, 2);
               //showmessage('');
            setlength(menuengstring, 2);
            menustring[0] := GBKtoUnicode('�غ���');
            menustring[1] := GBKtoUnicode('�뼴�r');

            menu := commonmenu(27, 30, 90, 1, battlemode div 2);

            if menu >= 0 then
            begin
              battlemode := min(2, menu * 2);
              Kys_ini.WriteInteger('set', 'battlemode', battlemode);
            end;
            setlength(Menustring, 0);
            setlength(menuengstring, 0);

          end;}

        if (event.key.keysym.sym = SDLK_F3) then
        begin
          menu := 0;
          setlength(menuString, 0);
          setlength(menuString, 2);
          setlength(menuEngString, 2);
          menuString[0] := GBKtoUnicode('�����Ч���_');
          menuEngString[0] := '';
          menuString[1] := GBKtoUnicode('�����Ч���P');
          menuEngString[1] := '';

          menu := CommonMenu(27, 30, 180, 1, effect);

          if menu >= 0 then
          begin
            effect := menu;
            Kys_ini.WriteInteger('set', 'effect', effect);
          end;
          setlength(menuString, 0);
          setlength(menuEngString, 0);
        end;


        if (event.key.keysym.sym = SDLK_F1) then
        begin
          menu := 0;
          setlength(menuString, 0);
          setlength(menuString, 2);
          //showmessage('');
          setlength(menuEngString, 2);
          menuString[0] := GBKtoUnicode('���w��');
          menuEngString[0] := '';
          menuString[1] := GBKtoUnicode('���w��');
          menuEngString[1] := '';

          menu := CommonMenu(27, 30, 90, 1, SIMPLE);

          if menu >= 0 then
          begin
            SIMPLE := menu;
            Kys_ini.WriteInteger('set', 'simple', SIMPLE);
          end;
          setlength(menuString, 0);
          setlength(menuEngString, 0);
        end;

        if (event.key.keysym.sym = SDLK_F2) then
        begin
          menu := 0;
          setlength(menuString, 0);
          setlength(menuString, 3);
          //showmessage('');
          setlength(menuEngString, 3);
          menuString[0] := GBKtoUnicode('�[���ٶȣ���');
          menuEngString[0] := '';
          menuString[1] := GBKtoUnicode('�[���ٶȣ���');
          menuEngString[1] := '';
          menuString[2] := GBKtoUnicode('�[���ٶȣ���');
          menuEngString[2] := '';

          menu := CommonMenu(27, 30, 180, 2, min(gamespeed div 10, 2));

          if menu >= 0 then
          begin
            if menu = 0 then gamespeed := 1;
            if menu = 1 then gamespeed := 10;
            if menu = 2 then gamespeed := 20;
            Kys_ini.WriteInteger('constant', 'game_speed', gamespeed);
          end;
          setlength(menuString, 0);
          setlength(menuEngString, 0);
        end;

        //CheckHotkey(event.key.keysym.sym);
        //event.key.keysym.sym := 0;
        //event.button.button := 0;
      end;
      //�簴��������, ����״̬Ϊ����
      //���ɿ�������, ����״̬Ϊ������
      //�Ҽ������ϵͳѡ��
      SDL_MOUSEBUTTONUP:
      begin
        if event.button.button = SDL_BUTTON_RIGHT then
        begin
          event.button.button := 0;
          newmenuesc;
          nowstep := -1;
          walking := 0;
        end;
      end;
      SDL_MOUSEBUTTONDOWN:
      begin
        if event.button.button = SDL_BUTTON_LEFT then
        begin
          walking := 1;
          GetMousePosition(axp, ayp, Mx, My);
          if (ayp >= 0) and (ayp <= 479) and (axp >= 0) and (axp <= 479) then
          begin
            FillChar(Fway[0, 0], sizeof(Fway), -1);
            FindWay(Mx, My);
            Moveman(Mx, My, Axp, Ayp);
            nowstep := Fway[Axp, Ayp] - 1;
          end;
        end;
      end;
    end;
    //if isdraw then
    begin
      DrawMMap;
      if (walking = 0) and (speed = 0) then
      begin
        GetMousePosition(axp, ayp, Mx, My);
        pos := GetPositionOnScreen(axp, ayp, Mx, My);
        DrawMPic(1, pos.x, pos.y, 0);
      end;
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      //isdraw := false;
      if speed <= 1 then
      begin
        event.key.keysym.sym := 0;
        event.button.button := 0;
      end;
    end;
  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
  SDL_EnableKeyRepeat(0, 10);

end;

//�ж�����ͼĳ��λ���ܷ�����, �Ƿ��ɴ�
//function in kys_main.pas

function CanWalk(x, y: integer): boolean;
begin
  if (buildx[x, y] > 0) and (buildx[x, y] < 480) and (buildy[x, y] > 0) and (buildy[x, y] < 480) then
  begin
    if building[buildy[x, y], buildx[x, y]] > 0 then
    begin
      CanWalk := False;
    end;
  end
  else
    CanWalk := True;
  //canwalk:=true;  //This sentence is used to test.
  if (x <= 0) or (x >= 479) or (y <= 0) or (y >= 479) or ((surface[x, y] >= 1692) and (surface[x, y] <= 1700)) then
    CanWalk := False;
  if (earth[x, y] = 838) or ((earth[x, y] >= 612) and (earth[x, y] <= 670)) then
    CanWalk := False;
  if ((earth[x, y] >= 358) and (earth[x, y] <= 362)) or ((earth[x, y] >= 506) and (earth[x, y] <= 670)) or
    ((earth[x, y] >= 1016) and (earth[x, y] <= 1022)) then
  begin
    if (Inship = 1) then //isship
    begin
      if (earth[x, y] = 838) or ((earth[x, y] >= 612) and (earth[x, y] <= 670)) then
      begin
        CanWalk := False;
      end
      else if ((surface[x, y] >= 1746) and (surface[x, y] <= 1788)) then
      begin
        CanWalk := False;
      end
      else
        CanWalk := True;
    end

    else
    if (x = shipy) and (y = shipx) then //touch ship?
    begin
      CanWalk := True;
      InShip := 1;
    end
    else
      CanWalk := False;
  end
  else
  begin
    if (Inship = 1) then //isboat??
    begin
      shipy := Mx; //arrrive
      shipx := My;
      shipface := Mface;
    end;
    InShip := 0;
  end;
  if ((surface[x, y] div 2 >= 863) and (surface[x, y] div 2 <= 872)) or
    ((surface[x, y] div 2 >= 852) and (surface[x, y] div 2 <= 854)) or
    ((surface[x, y] div 2 >= 858) and (surface[x, y] div 2 <= 860)) then
    CanWalk := True;
end;

//Check able or not to ertrance a Scene.
//����Ƿ���ĳ���, ���Ƿ��ɽ�������

procedure CheckEntrance;
var
  x, y, i, snum: integer;
  CanEntrance: boolean;
  str: WideString;
begin
  x := Mx;
  y := My;
  str := '���Y�Пo���M��';
  case Mface of
    0: x := x - 1;
    1: y := y + 1;
    2: y := y - 1;
    3: x := x + 1;
  end;
  if (Entrance[x, y] >= 0) then
  begin
    canentrance := False;
    snum := entrance[x, y];
    if (RScene[snum].EnCondition = 0) then
      canentrance := True;
    //�Ƿ������Ṧ����70
    if (RScene[snum].EnCondition = 2) then
      for i := 0 to length(Rrole) - 1 do
        if Rrole[i].TeamState in [1, 2] then
          if GetRoleSpeed(i, True) >= 70 then
            canentrance := True;
    if canentrance = True then
    begin
      instruct_14;
      CurScene := Entrance[x, y];
      SFace := MFace;
      Mface := 3 - Mface;
      SStep := 0;
      Sx := RScene[CurScene].EntranceX;
      Sy := RScene[CurScene].EntranceY;
      //��������, ���볡������ʼ����������
      SaveR(6);

      WalkInScene(0);

      //waitanykey;
    end;
    //instruct_13;

  end;

end;

{
procedure UpdateSceneAmi;
var
  now, next_time: uint32;
  i: integer;
begin

  next_time:=sdl_getticks;
  now:=sdl_getticks;
  while true do
  begin
    now:=sdl_getticks;
    if now>=next_time then
    begin
      LockScene:=true;
      for i:=0 to 199 do
      if DData[CurScene, [i,6]<>DData[CurScene, [i,7] then
      begin
        if (DData[CurScene, [i,5]<5498) or (DData[CurScene, [i,5]>5692) then
        begin
          DData[CurScene, [i,5]:=DData[CurScene, [i,5]+2;
          if DData[CurScene, [i,5]>DData[CurScene, [i,6] then DData[CurScene, [i,5]:=DData[CurScene, [i,7];
          updateScene(DData[CurScene, [i,10],DData[CurScene, [i,9]);
        end;
      end;
      //initialScene;
      sdl_delay(10);
      next_time:=next_time+200;
      LockScene:=false;
    end;
  end;

end;}

//Walk in a Scene, the returned value is the Scene number when you exit. If it is -1.
//InScene(1) means the new game.
//���ڳ�������, �����Ϊ1��ʾ����Ϸ

function WalkInScene(Open: integer): integer;
var
  grp, idx, offset, axp, ayp, just, i3, i1, i2, x, y, old, id: integer;
  Sx1, Sy1, updatearea, r, s, i, menu, walking, PreScene, speed: integer;
  filename: string;
  Scenename: WideString;
  now, next_time, next_time2, before: uint32;
  isdraw: boolean;
  pos: tposition;
  //UpDate: PSDL_Thread;
begin
  //UpDate:=SDL_CreateThread(@UpdateSceneAmi, nil);
  //LockScene:=false;

  Where := 1;

  Rrole[0].weizhi := CurScene;

  next_time := SDL_GetTicks;
  next_time2 := next_time + 800;
  before := next_time;
  nowstep := -1;
  updatearea := 0;

  isdraw := False;

  now2 := 0;
  resetpallet;
  walking := 0;
  speed := 0;
  just := 0;
  CurEvent := -1;
  SDL_EnableKeyRepeat(30, 30);
  SDL_EventState(SDL_MOUSEMOTION, SDL_ignore);
  InitialScene;
  event.key.keysym.sym := 0;
  if Open = 1 then
  begin
    Sx := BEGIN_Sx;
    Sy := BEGIN_Sy;
    Cx := Sx;
    Cy := Sy;
    CurEvent := BEGIN_EVENT;
    DrawScene;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    CallEvent(BEGIN_EVENT);
    CurEvent := -1;

  end;
  DrawScene;
  ShowSceneName(CurScene);

  if (Rscene[CurScene].inbattle = 1) and (Rrole[0].menpai = Rscene[CurScene].menpai) then
  begin
    for i := 0 to 19 do
    begin
      if (mpbdata[i].key >= 0) and (mpbdata[i].snum = curscene) and (timetonum >= mpbdata[i].daytime) then
      begin
        NewTalk(0, 205, -2, 0, 0, 0, 0, 1);
        timetompbattle(i, 1);
        InitialScene;
        DrawScene;
        ShowSceneName(CurScene);
        break;
      end;
    end;

  end;
  //�Ƿ��е�3���¼�λ�ڳ������
  CheckEvent3;
  i3 := 0;
  Rs := 0;
  while (SDL_PollEvent(@event) >= 0) do
  begin

    // i3:=i3+1;
    // if i3>12 then i3:=0;

    if where >= 3 then
    begin
      break;
    end;
    if where = 0 then
    begin
      exit;
    end;
    if Sx > 63 then
      Sx := 63;
    if Sy > 63 then
      Sy := 63;
    if Sx < 0 then
      Sx := 0;
    if Sy < 0 then
      Sy := 0;
    //�����ڶ�̬Ч��
    now := SDL_GetTicks;
    // if i3=0 then

    //����Ƿ�λ�ڳ���, �������˳�
    if (((Sx = RScene[CurScene].ExitX[0]) and (Sy = RScene[CurScene].ExitY[0])) or
      ((Sx = RScene[CurScene].ExitX[1]) and (Sy = RScene[CurScene].ExitY[1])) or
      ((Sx = RScene[CurScene].ExitX[2]) and (Sy = RScene[CurScene].ExitY[2]))) then
    begin
      nowstep := -1;
      ReSetEntrance;
      Where := 0;
      Rrole[0].weizhi := -1;
      resetpallet;
      Result := -1;
      break;
    end

    else if (integer(now) - integer(before) > 40) then
    begin
      ChangeCol;
      if tipsx < -400 then
      begin
        tipsstring := gettips;
        tipsx := CENTER_X * 2;
      end
      else
        Dec(tipsx, 10);
      if (integer(now) - integer(next_time) > 0) then
      begin
        if (water >= 0) then
        begin
          Inc(water, 6);
          if (water > 180) then water := 0;
        end;
        if Showanimation = 0 then
        begin
          for i := 0 to 399 do
            if ((DData[CurScene, i, 8] <> 0) or (abs(DData[CurScene, i, 7]) < abs(DData[CurScene, i, 6]))) then
            begin
              //���������ӵĶ�̬Ч��, ����ͼ̫�󲻺ô���
              old := DData[CurScene, i, 5];
              DData[CurScene, i, 5] := DData[CurScene, i, 5] + 2 * sign(DData[CurScene, i, 5]);
              if abs(DData[CurScene, i, 5]) > abs(DData[CurScene, i, 6]) then
                DData[CurScene, i, 5] := DData[CurScene, i, 7];
              updateScene(DData[CurScene, i, 10], DData[CurScene, i, 9], old, DData[CurScene, i, 5]);

            end;
        end;
        if time >= 0 then
        begin
          if integer(now) - integer(next_time2) > 0 then
          begin
            if (timeevent > 0) then
            begin
              time := time - 1;
            end;
            if time < 0 then
            begin
              CallEvent(timeevent);
            end;
            next_time2 := integer(now) + 1000;
          end;
        end;
        next_time := integer(now) + 200;
        rs := 0;
        rs := 1;
      end;
      before := now;
      //DrawScene;
      //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      isdraw := True;
    end;

    //�Ƿ�������״̬, �ο�Walk
    if walking = 1 then
    begin
      if nowstep >= 0 then
      begin
        if sign(liney[nowstep] - Sy) < 0 then
          SFace := 2
        else if sign(liney[nowstep] - Sy) > 0 then
          sFace := 1
        else if sign(linex[nowstep] - Sx) > 0 then
          SFace := 3
        else sFace := 0;
        SStep := SStep + 1;
        if SStep >= 7 then SStep := 1;
        // if (SData[CurScene, 3, liney[nowstep], linex[nowstep]] >= 0) and (DData[CurScene, SData[CurScene, 3, liney[nowstep], linex[nowstep]], 4] > 0) then
        // saver(6);
        Sx := linex[nowstep];
        Sy := liney[nowstep];
        rs := 1;
        //DrawScene;
        //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        isdraw := True;
        CheckEvent3;
        if RandomEvent > 0 then
          if Random(100) = 0 then
          begin
            //  saver(6);
            CallEvent(RandomEvent);
            nowstep := -1;
          end;
        Dec(nowstep);
        if nowstep < 0 then
          walking := 0;
      end
      else
      begin
        walking := 0;
        rs := 1;
      end;
    end;

    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        speed := 0;
        rs := 1;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          newMenuEsc;
          if where = 0 then
          begin
            if RScene[CurScene].ExitMusic >= 0 then
            begin
              StopMP3;
              PlayMP3(RScene[CurScene].ExitMusic, -1);
            end;
            Redraw;
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            exit;
          end;
          walking := 0;
        end
        //���»س���ո�, �����Է����Ƿ��е�1���¼�
        else if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          x := Sx;
          y := Sy;
          case SFace of
            0: x := x - 1;
            1: y := y + 1;
            2: y := y - 1;
            3: x := x + 1;
          end;
          //����������¼�
          if (x > -1) and (x < 64) and (y > -1) and (y < 64) then
            if (SData[CurScene, 3, x, y] >= 0) and IsEventActive(CurScene, SData[CurScene, 3, x, y]) then
            begin
              CurEvent := SData[CurScene, 3, x, y];
              walking := 0;
              if (DData[CurScene, CurEvent, 2] >= 0) then
              begin
                CallEvent(DData[CurScene, SData[CurScene, 3, x, y], 2]);
              end;
            end;
          CurEvent := -1;
        end

          {else if (event.key.keysym.sym = sdlk_f4) then
          begin

            menu := 0;
            setlength(Menustring, 0);
            setlength(menustring, 2);
               //showmessage('');
            setlength(menuengstring, 2);
            menustring[0] := GBKtoUnicode('�غ���');
            menustring[1] := GBKtoUnicode('�뼴�r');
            menu := commonmenu(27, 30, 90, 1, battlemode div 2);
            if menu >= 0 then
            begin
              battlemode := min(2, menu * 2);
              Kys_ini.WriteInteger('set', 'battlemode', battlemode);
            end;
            setlength(Menustring, 0);
            setlength(menuengstring, 0);

          end}

        else if (event.key.keysym.sym = SDLK_F3) then
        begin
          menu := 0;
          setlength(menuString, 0);
          setlength(menuString, 2);
          //showmessage('');
          setlength(menuEngString, 2);
          menuString[0] := GBKtoUnicode('�����Ч���_');
          menuEngString[0] := '';
          menuString[1] := GBKtoUnicode('�����Ч���P');
          menuEngString[1] := '';
          menu := CommonMenu(27, 30, 180, 1, effect);
          if menu >= 0 then
          begin
            effect := menu;
            Kys_ini.WriteInteger('set', 'effect', effect);
          end;
          setlength(menuString, 0);
          setlength(menuEngString, 0);
        end


        else if (event.key.keysym.sym = SDLK_F1) then
        begin
          menu := 0;
          setlength(menuString, 0);
          setlength(menuString, 2);
          //showmessage('');
          setlength(menuEngString, 2);
          menuString[0] := GBKtoUnicode('���w��');
          menuEngString[0] := '';
          menuString[1] := GBKtoUnicode('���w��');
          menuEngString[1] := '';
          menu := CommonMenu(27, 30, 90, 1, SIMPLE);
          if menu >= 0 then
          begin
            SIMPLE := menu;
            Kys_ini.WriteInteger('set', 'simple', SIMPLE);
          end;
          setlength(menuString, 0);
          setlength(menuEngString, 0);
        end

        else if (event.key.keysym.sym = SDLK_F2) then
        begin
          menu := 0;
          setlength(menuString, 0);
          setlength(menuString, 3);
          //showmessage('');
          setlength(menuEngString, 3);
          menuString[0] := GBKtoUnicode('�[���ٶȣ���');
          menuEngString[0] := '';
          menuString[1] := GBKtoUnicode('�[���ٶȣ���');
          menuEngString[1] := '';
          menuString[2] := GBKtoUnicode('�[���ٶȣ���');
          menuEngString[2] := '';
          menu := CommonMenu(27, 30, 180, 2, min(gamespeed div 10, 2));
          if menu >= 0 then
          begin
            if menu = 0 then gamespeed := 1;
            if menu = 1 then gamespeed := 10;
            if menu = 2 then gamespeed := 20;
            Kys_ini.WriteInteger('constant', 'game_speed', gamespeed);
          end;
          setlength(menuString, 0);
          setlength(menuEngString, 0);
        end

        else if (event.key.keysym.sym = SDLK_F6) then
        begin
          SaveR(6);
          ShowSaveSuccess;
        end;

        //CheckHotkey(event.key.keysym.sym);
        event.key.keysym.sym := 0;
        event.button.button := 0;
      end;
      SDL_KEYDOWN:
      begin
        speed := speed + 1;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          S_eventx := -1; //�������ƾ������¼���ͣ��ʱ�����ظ�����
          S_eventy := -1;
          SFace := 2;
          SStep := Sstep + 1;
          if SStep = 7 then
            SStep := 1;
          if canwalkinScene(Sx, Sy - 1) = True then
          begin
            Sy := Sy - 1;
          end;

        end
        else if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          S_eventx := -1; //�������ƾ������¼���ͣ��ʱ�����ظ�����
          S_eventy := -1;
          SFace := 1;
          SStep := Sstep + 1;
          if SStep = 7 then
            SStep := 1;
          if canwalkinScene(Sx, Sy + 1) = True then
          begin
            Sy := Sy + 1;
          end;
        end
        else if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          S_eventx := -1; //�������ƾ������¼���ͣ��ʱ�����ظ�����
          S_eventy := -1;
          SFace := 0;
          SStep := Sstep + 1;
          if SStep = 7 then
            SStep := 1;
          if canwalkinScene(Sx - 1, Sy) = True then
          begin
            Sx := Sx - 1;
          end;
        end
        else if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          S_eventx := -1; //�������ƾ������¼���ͣ��ʱ�����ظ�����
          S_eventy := -1;
          SFace := 3;
          SStep := Sstep + 1;
          if SStep = 7 then
            SStep := 1;
          if canwalkinScene(Sx + 1, Sy) = True then
          begin
            Sx := Sx + 1;
          end;
        end;
        rs := 1;

        nowstep := -1;

        CheckEvent3;
        if (RandomEvent > 0) and (Random(100) = 0) then
        begin
          //   saver(6);
          CallEvent(RandomEvent);
          nowstep := -1;
        end;
        //event.key.keysym.sym := 0;
        //event.button.button := 0;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if event.button.button = SDL_BUTTON_RIGHT then
        begin
          newmenuesc;
          nowstep := 0;
          walking := 0;
        end;
        if where = 0 then
        begin
          if RScene[CurScene].ExitMusic >= 0 then
          begin
            StopMP3;
            PlayMP3(RScene[CurScene].ExitMusic, -1);
          end;
          Redraw;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          exit;
        end
        else if event.button.button = SDL_BUTTON_LEFT then
        begin
          S_eventx := -1; //�������ƾ������¼���ͣ��ʱ�����ظ�����
          S_eventy := -1;
          if walking = 0 then
          begin
            walking := 1;
            GetMousePosition(Axp, Ayp, Sx, Sy, SData[CurScene, 4, Sx, Sy]);
            if (ayp in [0..63]) and (axp in [0..63]) then
            begin
              FillChar(Fway[0, 0], sizeof(Fway), -1);
              FindWay(Sx, Sy);
              Moveman(Sx, Sy, axp, ayp);
              nowstep := Fway[axp, ayp] - 1;
              rs := 1;
            end
            else
            begin
              walking := 0;
              rs := 1;
            end;
          end;
        end;
      end;
    end;

    {if water >= 0 then
      SDL_Delay(2 * (10 + GameSpeed))
    else}
    SDL_Delay(2 * (10 + GameSpeed));

    //if isdraw then
    begin
      DrawScene;
      if (walking = 0) and (speed = 0) then
      begin
        GetMousePosition(Axp, Ayp, Sx, Sy, SData[CurScene, 4, Sx, Sy]);
        if (axp >= 0) and (axp < 64) and (ayp >= 0) and (ayp < 64) then
        begin
          pos := GetPositionOnScreen(axp, ayp, Sx, Sy);
          DrawMPic(1, pos.x, pos.y - SData[CurScene, 4, axp, ayp], 0);
          //DrawMPic(1, pos.x, pos.y);
            {if not CanWalkInScence(axp, ayp) then
            begin
              if SData[CurScence, 3, axp, ayp] >= 0 then
                DrawMPic(2001, pos.x, pos.y - SData[CurScence, 4, axp, ayp], 0, 75, 0, 0)
              else
                DrawMPic(2001, pos.x, pos.y - SData[CurScence, 4, axp, ayp], 0, 50, 0, 0);
            end;}
        end;
      end;
      SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      //isdraw := false;
      if speed <= 1 then
      begin
        event.key.keysym.sym := 0;
        event.button.button := 0;
      end;
    end;

  end;
  event.key.keysym.sym := 0;
  event.button.button := 0;
  instruct_14; //����
  SDL_EnableKeyRepeat(10, 0);
  //ReDraw;
  //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  if RScene[CurScene].ExitMusic >= 0 then
  begin
    StopMP3;
    PlayMP3(RScene[CurScene].ExitMusic, -1);
  end;

end;

procedure ShowSceneName(snum: integer);
var
  Scenename: WideString;
  p: pbyte;
  Name: array[0..11] of byte;
  i: integer;
begin
  //��ʾ������
  p := @rScene[snum].Name[0];
  for i := 0 to 9 do
  begin
    Name[i] := p^;
    Inc(p);
  end;
  Name[10] := byte(0);
  Name[11] := byte(0);
  Scenename := gbktounicode(@Name[0]);
  DrawTextWithRect(@Scenename[1], 320 - length(pchar(@Name)) * 5 + 7, 100, length(pchar(@Name)) *
    10 + 6, ColColor(0, 5), ColColor(0, 7));
  //waitanykey;
  //�ı�����
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  if RScene[snum].EntranceMusic >= 0 then
  begin
    StopMP3;
    PlayMP3(RScene[snum].EntranceMusic, -1);
  end;
  SDL_Delay(500 + (50 * GameSpeed));

end;

procedure ShowSaveSuccess;
var
  Scenename: WideString;
begin
  //��ʾ������
  Scenename := ' ����ɹ�';
  DrawTextWithRect(@Scenename[1], 320 - 50 + 7, 100, 100 + 6, ColColor(0, 5), ColColor(0, 7));
  //waitanykey;
  //�ı�����
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

  WaitAnyKey;

end;
//�ж�������ĳ��λ���ܷ�����

function CanWalkInScene(x, y: integer): boolean;
begin
  Result := True;
  if (SData[CurScene, 1, x, y] <= 0) and (SData[CurScene, 1, x, y] >= -2) then
    Result := True
  else
    Result := False;
  if (abs(SData[CurScene, 4, x, y] - SData[CurScene, 4, Sx, Sy]) > 10) then
    Result := False;
  if (SData[CurScene, 3, x, y] >= 0) and (Result) and ((DData[CurScene, SData[CurScene, 3, x, y], 0] mod 10) = 1) then
    if IsEventActive(CurScene, SData[CurScene, 3, x, y]) then Result := False;
  //ֱ���ж���ͼ��Χ
  if ((SData[CurScene, 0, x, y] >= 358) and (SData[CurScene, 0, x, y] <= 362)) or
    (SData[CurScene, 0, x, y] = 522) or (SData[CurScene, 0, x, y] = 1022) or
    ((SData[CurScene, 0, x, y] >= 1324) and (SData[CurScene, 0, x, y] <= 1330)) or
    (SData[CurScene, 0, x, y] = 1348) then
    Result := False;
  //if SData[CurScene, 0, x, y] = 1358 * 2 then result := true;

end;



//��ѡ��

procedure MenuEsc;
var
  menu, menup: integer;
begin
  menu := 0;
  while menu >= 0 do
  begin
    if where >= 3 then
      exit;
    setlength(menuString, 0);
    setlength(menuString, 8);
    //showmessage('');
    setlength(menuEngString, 8);
    menuString[0] := '��B';
    menuString[1] := '��Ʒ';
    menuString[2] := '��W';
    menuString[3] := '����';
    menuString[4] := '�ȹ�';
    menuString[5] := '�x�';
    menuString[6] := 'ϵ�y';
    menuString[7] := '�f��';
    menu := CommonMenu(27, 30, 46, 7, menu);
    //ShowCommonMenu(15, 15, 75, 3, r);
    //SDL_UpdateRect2(screen, 15, 15, 76, 316);
    case menu of
      0:
      begin
        SelectShowStatus;
        Redraw;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      1:
      begin
        // MenuItem; redraw;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      2:
      begin
        SelectShowMagic;
        Redraw;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      3:
      begin
        //FourPets;
        selectshowallmagic;
        Redraw;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      4: ExecScript('test.lua', 'f1');
      5:
      begin
        //  MenuLeave;
        Redraw;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
      6:
      begin
        NewMenuSystem;
        Redraw;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        break;
      end;
      7:
      begin
        ResistTheater;
        Redraw;
        SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
      end;
    end;
  end;
  SDL_EnableKeyRepeat(100, 30);

end;

//��ʾ��ѡ��

procedure ShowMenu(menu: integer);
var
  word: array[0..5] of WideString;
  i, max0: integer;
begin
  word[0] := '�t��';
  word[1] := '�ⶾ';
  word[2] := '��Ʒ';
  word[3] := '��B';
  word[4] := '�x�';
  word[5] := 'ϵ�y';
  if where = 0 then
    max0 := 5
  else
    max0 := 3;
  Redraw;
  DrawRectangle(27, 30, 46, max0 * 22 + 28, 0, ColColor(255), 30);
  //��ǰ����λ���ð�ɫ, �����û�ɫ
  for i := 0 to max0 do
    if i = menu then
    begin
      DrawText(screen, @word[i][1], 11, 32 + 22 * i, ColColor($64));
      DrawText(screen, @word[i][1], 10, 32 + 22 * i, ColColor($66));
    end
    else
    begin
      DrawText(screen, @word[i][1], 11, 32 + 22 * i, ColColor($5));
      DrawText(screen, @word[i][1], 10, 32 + 22 * i, ColColor($7));
    end;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

//ҽ��ѡ��, ������ѡ���Ա

procedure MenuMedcine;
var
  role1, role2, menu: integer;
  str: WideString;
begin
  str := '꠆T�t������';
  DrawTextWithRect(@str[1], 80, 30, 139, ColColor($21), ColColor($23));
  menu := SelectOneTeamMember(80, 65, '%3d', 46, 0);
  ShowMenu(0);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  if menu >= 0 then
  begin
    role1 := TeamList[menu];
    str := '꠆TĿǰ����';
    DrawTextWithRect(@str[1], 80, 30, 139, ColColor($21), ColColor($23));
    menu := SelectOneTeamMember(80, 65, '%4d/%4d', 17, 18);
    role2 := TeamList[menu];
    if menu >= 0 then
      EffectMedcine(role1, role2);
  end;
  //waitanykey;
  Redraw;
  //SDL_UpdateRect2(screen,0,0,screen.w,screen.h);

end;

//�ⶾѡ��

procedure MenuMedPoision;
var
  role1, role2, menu: integer;
  str: WideString;
begin
  str := '꠆T�ⶾ����';
  DrawTextWithRect(@str[1], 80, 30, 139, ColColor($21), ColColor($23));
  menu := SelectOneTeamMember(80, 65, '%3d', 48, 0);
  ShowMenu(1);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  if menu >= 0 then
  begin
    role1 := TeamList[menu];
    str := '꠆T�ж��̶�';
    DrawTextWithRect(@str[1], 80, 30, 139, ColColor($21), ColColor($23));
    menu := SelectOneTeamMember(80, 65, '%3d', 20, 0);
    role2 := TeamList[menu];
    if menu >= 0 then
      EffectMedPoision(role1, role2);
  end;
  //waitanykey;
  Redraw;
  //showmenu(1);
  //SDL_UpdateRect2(screen,0,0,screen.w,screen.h);

end;

//��Ʒѡ��

function MenuItem(menu: integer): boolean;
var
  point, atlu, x, y, col, row, xp, yp, iamount, max0: integer;
  //point�ƺ�δʹ��, atluΪ�������Ͻǵ���Ʒ���б��е����, x, yΪ���λ��
  //col, rowΪ������������
begin
  col := 6;
  row := 3;
  x := 0;
  y := 0;
  atlu := 0;

  if menu = 0 then menu := 101;
  menu := menu - 1;

  iamount := ReadItemList(menu);
  ShowMenuItem(row, col, x, y, atlu);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  Result := True;
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          y := y + 1;
          if y < 0 then
            y := 0;
          if (y >= row) then
          begin
            if (ItemList[atlu + col * row] >= 0) then
              atlu := atlu + col;
            y := row - 1;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          y := y - 1;
          if y < 0 then
          begin
            y := 0;
            if atlu > 0 then
              atlu := atlu - col;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_PAGEDOWN) then
        begin
          //y := y + row;
          atlu := atlu + col * row;
          if y < 0 then
            y := 0;
          if (ItemList[atlu + col * row] < 0) and (iamount > col * row) then
          begin
            y := y - (iamount - atlu) div col - 1 + row;
            atlu := (iamount div col - row + 1) * col;
            if y >= row then
              y := row - 1;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_PAGEUP) then
        begin
          //y := y - row;
          atlu := atlu - col * row;
          if atlu < 0 then
          begin
            y := y + atlu div col;
            atlu := 0;
            if y < 0 then
              y := 0;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          x := x + 1;
          if x >= col then
            x := 0;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          x := x - 1;
          if x < 0 then
            x := col - 1;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          //ShowMenu(2);
          Result := True;
          event.key.keysym.sym := 0;
          event.button.button := 0;
          SDL_Delay(5 + GameSpeed div 3);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          // ReDraw;
          CurItem := RItemlist[itemlist[(y * col + x + atlu)]].Number;
          if (where <> 2) and (CurItem >= 0) and (itemlist[(y * col + x + atlu)] >= 0) then
            UseItem(CurItem);

          iamount := ReadItemList(menu);
          //ShowMenu(2);
          ShowMenuItem(row, col, x, y, atlu);
          if (Ritem[CurItem].ItemType <> 0) and (where <> 2) then Result := True
          else
          begin
            Result := False;
            break;
          end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          //  break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          //ShowMenu(2);
          Result := False;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          //  ReDraw;
          CurItem := RItemlist[itemlist[(y * col + x + atlu)]].Number;
          if (where <> 2) and (CurItem >= 0) and (itemlist[(y * col + x + atlu)] >= 0) then
            UseItem(CurItem);

          iamount := ReadItemList(menu);
          ShowMenuItem(row, col, x, y, atlu);
          //ShowMenu(2);
          if (Ritem[CurItem].ItemType <> 0) and (where <> 2) then Result := True
          else
          begin
            Result := False;
            break;
          end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          //  break;
        end;
        if (event.button.button = sdl_button_wheeldown) then
        begin
          y := y + 1;
          if y < 0 then
            y := 0;
          if (y >= row) then
          begin
            if (ItemList[atlu + col * row] >= 0) then
              atlu := atlu + col;
            y := row - 1;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.button.button = sdl_button_wheelup) then
        begin
          y := y - 1;
          if y < 0 then
          begin
            y := 0;
            if atlu > 0 then
              atlu := atlu - col;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x < 122) then
        begin
          //   result := false;
          if where <> 2 then break;
        end;
        if (event.button.x >= 110) and (event.button.x < 612) and (event.button.y > 90) and
          (event.button.y < 316) then
        begin
          xp := x;
          yp := y;
          x := (event.button.x - 115) div 82;
          y := (event.button.y - 95) div 82;
          if x >= col then
            x := col - 1;
          if y >= row then
            y := row - 1;
          if x < 0 then
            x := 0;
          if y < 0 then
            y := 0;
          //����ƶ�ʱ����x, y�����仯ʱ���ػ�
          if (x <> xp) or (y <> yp) then
          begin
            ShowMenuItem(row, col, x, y, atlu);
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
        end;
        if (event.button.x >= 110) and (event.button.x < 612) and (event.button.y > 312) then
        begin
          //atlu := atlu+col;
          y := y + 1;
          if y < 0 then
            y := 0;
          if (y >= row) then
          begin
            if (ItemList[atlu + col * row] >= 0) then
              atlu := atlu + col;
            y := row - 1;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.button.x >= 110) and (event.button.x < 612) and (event.button.y < 90) then
        begin
          if atlu > 0 then
            atlu := atlu - col;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
    end;
  end;
  //SDL_UpdateRect2(screen,0,0,screen.w,screen.h);

end;
//���ɲ˵�ʹ����Ʒ

function MPMenuItem(menu: integer): boolean;
var
  point, atlu, x, y, col, row, xp, yp, iamount, max0: integer;
  //point�ƺ�δʹ��, atluΪ�������Ͻǵ���Ʒ���б��е����, x, yΪ���λ��
  //col, rowΪ������������
begin
  col := 6;
  row := 3;
  x := 0;
  y := 0;
  atlu := 0;

  if menu = 0 then
    menu := 1
  else
    menu := 3;

  iamount := ReadItemList(menu);
  ShowMenuItem(row, col, x, y, atlu);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  Result := True;
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          y := y + 1;
          if y < 0 then
            y := 0;
          if (y >= row) then
          begin
            if (ItemList[atlu + col * row] >= 0) then
              atlu := atlu + col;
            y := row - 1;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          y := y - 1;
          if y < 0 then
          begin
            y := 0;
            if atlu > 0 then
              atlu := atlu - col;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_PAGEDOWN) then
        begin
          //y := y + row;
          atlu := atlu + col * row;
          if y < 0 then
            y := 0;
          if (ItemList[atlu + col * row] < 0) and (iamount > col * row) then
          begin
            y := y - (iamount - atlu) div col - 1 + row;
            atlu := (iamount div col - row + 1) * col;
            if y >= row then
              y := row - 1;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_PAGEUP) then
        begin
          //y := y - row;
          atlu := atlu - col * row;
          if atlu < 0 then
          begin
            y := y + atlu div col;
            atlu := 0;
            if y < 0 then
              y := 0;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          x := x + 1;
          if x >= col then
            x := 0;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          x := x - 1;
          if x < 0 then
            x := col - 1;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          //ShowMenu(2);
          Result := True;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          // ReDraw;
          CurItem := RItemlist[itemlist[(y * col + x + atlu)]].Number;
          if (where <> 2) and (CurItem >= 0) and (itemlist[(y * col + x + atlu)] >= 0) then
            MPUseItem(CurItem);

          iamount := ReadItemList(menu);
          //ShowMenu(2);
          ShowMenuItem(row, col, x, y, atlu);
          if (Ritem[CurItem].ItemType <> 0) and (where <> 2) then Result := True
          else
          begin
            Result := False;
            break;
          end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          //  break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          //ShowMenu(2);
          Result := False;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          //  ReDraw;
          CurItem := RItemlist[itemlist[(y * col + x + atlu)]].Number;
          if (where <> 2) and (CurItem >= 0) and (itemlist[(y * col + x + atlu)] >= 0) then
            MPUseItem(CurItem);

          iamount := ReadItemList(menu);
          ShowMenuItem(row, col, x, y, atlu);
          //ShowMenu(2);
          if (Ritem[CurItem].ItemType <> 0) and (where <> 2) then Result := True
          else
          begin
            Result := False;
            break;
          end;
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          //  break;
        end;
        if (event.button.button = sdl_button_wheeldown) then
        begin
          y := y + 1;
          if y < 0 then
            y := 0;
          if (y >= row) then
          begin
            if (ItemList[atlu + col * row] >= 0) then
              atlu := atlu + col;
            y := row - 1;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.button.button = sdl_button_wheelup) then
        begin
          y := y - 1;
          if y < 0 then
          begin
            y := 0;
            if atlu > 0 then
              atlu := atlu - col;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x < 122) then
        begin
          //   result := false;
          if where <> 2 then break;
        end;
        if (event.button.x >= 110) and (event.button.x < 612) and (event.button.y > 90) and
          (event.button.y < 316) then
        begin
          xp := x;
          yp := y;
          x := (event.button.x - 115) div 82;
          y := (event.button.y - 95) div 82;
          if x >= col then
            x := col - 1;
          if y >= row then
            y := row - 1;
          if x < 0 then
            x := 0;
          if y < 0 then
            y := 0;
          //����ƶ�ʱ����x, y�����仯ʱ���ػ�
          if (x <> xp) or (y <> yp) then
          begin
            ShowMenuItem(row, col, x, y, atlu);
            SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
        end;
        if (event.button.x >= 110) and (event.button.x < 612) and (event.button.y > 312) then
        begin
          //atlu := atlu+col;
          y := y + 1;
          if y < 0 then
            y := 0;
          if (y >= row) then
          begin
            if (ItemList[atlu + col * row] >= 0) then
              atlu := atlu + col;
            y := row - 1;
          end;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
        if (event.button.x >= 110) and (event.button.x < 612) and (event.button.y < 90) then
        begin
          if atlu > 0 then
            atlu := atlu - col;
          ShowMenuItem(row, col, x, y, atlu);
          SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
        end;
      end;
    end;
  end;
  //SDL_UpdateRect2(screen,0,0,screen.w,screen.h);

end;
//����Ʒ�б�, ��Ҫ��ս����������һ������Ʒ
//����һ���������õ�����ֵ��100������ʾ��ȡ������Ʒ

function ReadItemList(ItemType: integer): integer;
var
  i, p: integer;
begin
  p := 0;
  for i := 0 to length(ItemList) - 1 do
    ItemList[i] := -1;
  for i := 0 to MAX_ITEM_AMOUNT - 1 do
  begin
    if (RItemlist[i].Number >= 0) then
    begin
      if where = 2 then
      begin
        if (Ritem[RItemlist[i].Number].ItemType = 3) or (Ritem[RItemlist[i].Number].ItemType = 4) then
        begin
          Itemlist[p] := i;
          p := p + 1;
        end;
      end
      else if (Ritem[RItemlist[i].Number].ItemType = ItemType) or (ItemType = 100) then
      begin
        Itemlist[p] := i;
        p := p + 1;
      end;
    end;
  end;
  Result := p;

end;

//��ʾ��Ʒѡ��

procedure ShowMenuItem(row, col, x, y, atlu: integer);
var
  item, i, i1, i2, len, len2, len3, listnum: integer;
  str: WideString;
  words: array[0..10] of WideString;
  words2: array[0..23] of WideString;
  words3: array[0..13] of WideString;
  p2: array[0..23] of integer;
  p3: array[0..13] of integer;
begin
  words[0] := '������Ʒ';
  words[1] := '�������';
  words[2] := '�书����';
  words[3] := '�`����ˎ';
  words[4] := '���˰���';
  words2[0] := '����';
  words2[1] := '����';
  words2[2] := '�ж�';
  words2[3] := '�w��';
  words2[4] := '����';
  words2[5] := '����';
  words2[6] := '����';
  words2[7] := '����';
  words2[8] := '�p��';
  words2[9] := '���R';
  words2[10] := '�t��';
  words2[11] := '�ö�';
  words2[12] := '�ⶾ';
  words2[13] := '����';
  words2[14] := 'ȭ��';
  words2[15] := '����';
  words2[16] := 'ˣ��';
  words2[17] := '���T';
  words2[18] := '����';
  words2[19] := '��W';
  words2[20] := 'Ʒ��';
  words2[21] := '����';
  words2[22] := '����';
  words2[23] := '����';
  words3[0] := '����';
  words3[1] := '����';
  words3[2] := '����';
  words3[3] := '�p��';
  words3[4] := '�ö�';
  words3[5] := '�t��';
  words3[6] := '�ⶾ';
  words3[7] := 'ȭ��';
  words3[8] := '����';
  words3[9] := 'ˣ��';
  words3[10] := '���T';
  words3[11] := '����';
  words3[12] := '�Y�|';
  words3[13] := '�Ԅe';

  if where = 2 then
  begin
    Redraw;
  end
  else
    display_imgFromSurface(MENUITEM_PIC, 110, 0, 110, 0, 530, 440);
  //ReDraw;
  DrawRectangle(110 + 12, 16, 499, 25, 0, ColColor(0, 255), 40);
  DrawRectangle(110 + 12, 46, 499, 25, 0, ColColor(0, 255), 40);
  DrawRectangle(110 + 12, 76, 499, 252, 0, ColColor(0, 255), 40);
  DrawRectangle(110 + 12, 335, 499, 86, 0, ColColor(0, 255), 40);
  //i:=0;
  for i1 := 0 to row - 1 do
    for i2 := 0 to col - 1 do
    begin
      listnum := ItemList[i1 * col + i2 + atlu];
      if (listnum >= 0) and (listnum < MAX_ITEM_AMOUNT) and (RItemlist[listnum].Number < length(Ritem)) and
        (RItemlist[listnum].Number >= 0) then
      begin
        DrawItemPic(RItemlist[listnum].Number, i2 * 82 + 12 + 115, i1 * 82 + 95 - 14);
        //DrawMPic(ITEM_BEGIN_PIC + RItemlist[listnum].Number, i2 * 42 + 115, i1 * 42 + 95);
      end;
    end;
  listnum := itemlist[y * col + x + atlu];
  item := RItemlist[listnum].Number;

  if (listnum < MAX_ITEM_AMOUNT) and (listnum >= 0) and (RItemlist[listnum].Amount > 0) and
    (RItemlist[listnum].Number < length(Ritem)) and (RItemlist[listnum].Number >= 0) then
  begin
    str := format('%5d', [RItemlist[listnum].Amount]);
    DrawEngShadowText(@str[1], 431 + 62 + 12, 32 - 14, ColColor(0, $64), ColColor(0, $66));
    len := length(pchar(@Ritem[item].Name));
    drawgbkshadowtext(@Ritem[item].Name, 357 - len * 5 + 12, 32 - 14, ColColor(0, $21), ColColor(0, $23));
    len := length(pchar(@Ritem[item].Introduction));
    drawgbkshadowtext(@Ritem[item].Introduction, 357 - len * 5 + 12, 62 - 14, ColColor(0, $5), ColColor(0, $7));
    DrawShadowText(@words[Ritem[item].ItemType, 1], 97 + 12, 315 + 36 - 14, ColColor(0, $21), ColColor(0, $23));
    //������ʹ������ʾ
    if Ritem[item].User >= 0 then
    begin
      str := 'ʹ���ˣ�';
      DrawShadowText(@str[1], 187 + 12, 315, ColColor(0, $21), ColColor(0, $23));
      drawgbkshadowtext(@Rrole[Ritem[item].User].Name, 277 + 12, 315 + 36 - 14, ColColor(0, $64), ColColor(0, $66));
    end;
    //������������ʾ����
    if item = COMPASS_ID then
    begin
      str := '���λ�ã�';
      DrawShadowText(@str[1], 187 + 12, 315 + 36 - 14, ColColor(0, $21), ColColor(0, $23));
      str := format('%3d, %3d', [My, Mx]);
      DrawEngShadowText(@str[1], 300 + 12, 315 + 36 - 14, ColColor(0, $64), ColColor(0, $66));
      str := '����λ�ã�';
      DrawShadowText(@str[1], 387 + 12, 315 + 36 - 14, ColColor(0, $21), ColColor(0, $23));
      str := format('%3d, %3d', [Shipx, shipy]);
      DrawEngShadowText(@str[1], 500 + 12, 315 + 36 - 14, ColColor(0, $64), ColColor(0, $66));
    end;
  end;

  if (RItemlist[listnum].Amount > 0) and (listnum < MAX_ITEM_AMOUNT) and (listnum >= 0) and
    (Ritem[item].ItemType > 0) then
  begin
    len2 := 0;
    for i := 0 to 22 do
    begin
      p2[i] := 0;
      if (Ritem[item].Data[45 + i] <> 0) and (i <> 4) then
      begin
        p2[i] := 1;
        len2 := len2 + 1;
      end;
    end;
    if Ritem[item].ChangeMPType in [0..2] then
    begin
      p2[4] := 1;
      len2 := len2 + 1;
    end;
    if Ritem[item].rehurt > 0 then
    begin
      p2[23] := 1;
      len2 := len2 + 1;
    end;
    len3 := 0;
    for i := 0 to 12 do
    begin
      p3[i] := 0;
      if (Ritem[item].Data[69 + i] <> 0) and (i <> 0) then
      begin
        p3[i] := 1;
        len3 := len3 + 1;
      end;
    end;
    if (Ritem[item].NeedMPType in [0, 1]) and (Ritem[item].ItemType <> 3) and
      (Ritem[item].ItemType <> 0) and (Ritem[item].ItemType <> 4) then
    begin
      p3[0] := 1;
      len3 := len3 + 1;
    end;
    if (Ritem[item].needSex in [0..2]) and (Ritem[item].ItemType <> 3) and (Ritem[item].ItemType <> 0) and
      (Ritem[item].ItemType <> 4) then
    begin
      p3[13] := 1;
      len3 := len3 + 1;
    end;

    if len2 + len3 > 0 then
      //   drawrectangle(110+12, 344 + 36-14, 499, 20 * ((len2 + 2) div 3 + (len3 + 2) div 3) + 5, 0, colcolor(255), 30);

      i1 := 0;
    for i := 0 to 23 do
    begin
      if (p2[i] = 1) then
      begin

        if i = 4 then
          case Ritem[item].ChangeMPType of
            0: str := '�';
            1: str := '�';
            2: str := '�{��';
          end
        else if i = 23 then
          str := '+' + format('%d', [Ritem[item].rehurt])
        else if Ritem[item].Data[45 + i] > 0 then
          str := '+' + format('%d', [Ritem[item].Data[45 + i]])
        else str := format('%d', [Ritem[item].Data[45 + i]]);

        DrawShadowText(@words2[i][1], 97 + i1 mod 5 * 98 + 12, i1 div 5 * 20 + 355, ColColor(0, $5), ColColor(0, $7));
        DrawShadowText(@str[1], 147 + i1 mod 5 * 98 + 12, i1 div 5 * 20 + 355, ColColor(0, $64), ColColor(0, $66));
        i1 := i1 + 1;
      end;
    end;




    i1 := 0;
    for i := 0 to 13 do
    begin
      if (p3[i] = 1) then
      begin

        if i = 0 then
          case Ritem[item].NeedMPType of
            0: str := '�';
            1: str := '�';
            2: str := '�{��';
          end
        else if i = 13 then
          case Ritem[item].needSex of
            0: str := '��';
            1: str := 'Ů';
            2: str := '�Թ�';
          end
        else if Ritem[item].Data[69 + i] > 0 then
          str := '' + format('%d', [Ritem[item].Data[69 + i]])
        else str := format('%d', [Ritem[item].Data[69 + i]]);

        DrawShadowText(@words3[i][1], 97 + i1 mod 5 * 98 + 12, ((len2 + 4) div 5 + i1 div 5) *
          20 + 355, ColColor(0, $FF), ColColor(0, $50));
        DrawShadowText(@str[1], 147 + i1 mod 5 * 98 + 12, ((len2 + 4) div 5 + i1 div 5) *
          20 + 355, ColColor(0, $64), ColColor(0, $66));
        i1 := i1 + 1;
      end;
    end;

    if (Ritem[item].BattleEffect > 0) then
    begin
      case Ritem[item].BattleEffect of
        1: str := GBKtoUnicode('�b����Ч���w�����p');
        2: str := GBKtoUnicode('�b����Ч��Ů���书�����ӳ�');
        3: str := GBKtoUnicode('�b����Ч��ƹ�Ч�ӱ�');
        4: str := GBKtoUnicode('�b����Ч���S�C�����D��');
        5: str := GBKtoUnicode('�b����Ч���S�C��������');
        6: str := GBKtoUnicode('�b����Ч���Ȃ�����');
        7: str := GBKtoUnicode('�b����Ч�������w��');
        8: str := GBKtoUnicode('�b����Ч�������W�����');
        9: str := GBKtoUnicode('�b����Ч���������S�ȼ�ѭ������');
        10: str := GBKtoUnicode('�b����Ч���������Ĝp��');
        11: str := GBKtoUnicode('�b����Ч��ÿ�غϻ֏�����');
        12: str := GBKtoUnicode('�b����Ч��ؓ���B����');
        13: str := GBKtoUnicode('�b����Ч��ȫ���书�����ӳ�');
        14: str := GBKtoUnicode('�b����Ч���S�C���ι���');
        15: str := GBKtoUnicode('�b����Ч��ȭ���书�����ӳ�');
        16: str := GBKtoUnicode('�b����Ч�����g�书�����ӳ�');
        17: str := GBKtoUnicode('�b����Ч�������书�����ӳ�');
        18: str := GBKtoUnicode('�b����Ч�����T�书�����ӳ�');
        19: str := GBKtoUnicode('�b����Ч�����ӃȂ�����');
        20: str := GBKtoUnicode('�b����Ч�����ӷ�Ѩ����');
        21: str := GBKtoUnicode('�b����Ч������΢����Ѫ');
        22: str := GBKtoUnicode('�b����Ч���������x����');
        23: str := GBKtoUnicode('�b����Ч��ÿ�غϻ֏̓���');
        24: str := GBKtoUnicode('�b����Ч��ʹ�ð������x����');
        25: str := GBKtoUnicode('�b����Ч�����Ӛ������Ճ���');
      end;
      DrawShadowText(@str[1], 97 + 12, ((len2 + 4) div 5 + (i1 + 4) div 5) * 20 + 355,
        ColColor(0, $5), ColColor(0, $7));
    end;
  end;

  DrawItemFrame(x, y);

end;


//����ɫ�߿���Ϊ��Ʒѡ���Ĺ��

procedure DrawItemFrame(x, y: integer);
var
  i: integer;
begin
  for i := 0 to 79 do
  begin
    PutPixel(screen, x * 82 + 115 + 12 + i, y * 82 + 97 - 14, ColColor(0, 255));
    PutPixel(screen, x * 82 + 115 + 12 + i, y * 82 + 91 + 81 - 14, ColColor(0, 255));
    PutPixel(screen, x * 82 + 117 + 12, y * 82 + 95 + i - 14, ColColor(0, 255));
    PutPixel(screen, x * 82 + 111 + 12 + 81, y * 82 + 95 + i - 14, ColColor(0, 255));

    PutPixel(screen, x * 82 + 115 + 12 + i, y * 82 + 96 - 14, ColColor(0, 255));
    PutPixel(screen, x * 82 + 115 + 12 + i, y * 82 + 92 + 81 - 14, ColColor(0, 255));
    PutPixel(screen, x * 82 + 116 + 12, y * 82 + 95 + i - 14, ColColor(0, 255));
    PutPixel(screen, x * 82 + 112 + 12 + 81, y * 82 + 95 + i - 14, ColColor(0, 255));

    PutPixel(screen, x * 82 + 115 + 12 + i, y * 82 + 95 - 14, ColColor(0, 255));
    PutPixel(screen, x * 82 + 115 + 12 + i, y * 82 + 93 + 81 - 14, ColColor(0, 255));
    PutPixel(screen, x * 82 + 115 + 12, y * 82 + 95 + i - 14, ColColor(0, 255));
    PutPixel(screen, x * 82 + 113 + 12 + 81, y * 82 + 95 + i - 14, ColColor(0, 255));
  end;

end;

//ʹ����Ʒ

procedure UseItem(inum: integer);
var
  x, y, menu, rnum, p: integer;
  str, str1: WideString;
begin
  CurItem := inum;
  if inum = MAP_ID then
  begin
    ShowMap;
    exit;
  end;

  case Ritem[inum].ItemType of
    0: //������Ʒ
    begin
      //��ĳ���Դ���0, ֱ�ӵ����¼�
      if Ritem[inum].EventNum > 0 then
        CallEvent(Ritem[inum].EventNum)
      else
      begin
        if where = 1 then
        begin
          x := Sx;
          y := Sy;
          case SFace of
            0: x := x - 1;
            1: y := y + 1;
            2: y := y - 1;
            3: x := x + 1;
          end;
          //������λ���е�2���¼������
          if SData[CurScene, 3, x, y] >= 0 then
          begin
            CurEvent := SData[CurScene, 3, x, y];
            if (DData[CurScene, SData[CurScene, 3, x, y], 3] >= 0) and
              (IsEventActive(CurScene, SData[CurScene, 3, x, y])) then
            begin
              //  SaveR(6);
              CallEvent(DData[CurScene, SData[CurScene, 3, x, y], 3]);
            end;
          end;
          CurEvent := -1;
        end;
      end;
    end;
    1: //װ��
    begin
      menu := 1;
      if menu = 1 then
      begin
        menu := SelectItemUser(inum);
        if menu >= 0 then
        begin
          rnum := menu;
          p := Ritem[inum].EquipType;
          if CanEquip(rnum, inum) then
          begin
            if Rrole[rnum].Equip[p] >= 0 then
            begin
              if Ritem[Rrole[rnum].Equip[p]].Magic > 0 then
              begin
                Ritem[Rrole[rnum].Equip[p]].ExpOfMagic := GetMagicLevel(rnum, Ritem[Rrole[rnum].Equip[p]].Magic);
                StudyMagic(rnum, Ritem[Rrole[rnum].Equip[p]].Magic, 0, 0, 1);
              end;
              Dec(Rrole[rnum].MaxHP, Ritem[Rrole[rnum].Equip[p]].AddMaxHP);
              Dec(Rrole[rnum].CurrentHP, Ritem[Rrole[rnum].Equip[p]].AddMaxHP);
              Dec(Rrole[rnum].MaxMP, Ritem[Rrole[rnum].Equip[p]].AddMaxMP);
              Dec(Rrole[rnum].CurrentMP, Ritem[Rrole[rnum].Equip[p]].AddMaxMP);
              instruct_32(Rrole[rnum].Equip[p], 1);
            end;
            instruct_32(inum, -1);
            Rrole[rnum].Equip[p] := inum;

            if Ritem[Rrole[rnum].Equip[p]].Magic > 0 then
              StudyMagic(rnum, 0, Ritem[Rrole[rnum].Equip[p]].Magic, Ritem[Rrole[rnum].Equip[p]].ExpOfMagic, 1);

            Inc(Rrole[rnum].MaxHP, Ritem[Rrole[rnum].Equip[p]].AddMaxHP);
            Inc(Rrole[rnum].CurrentHP, Ritem[Rrole[rnum].Equip[p]].AddMaxHP);
            Inc(Rrole[rnum].MaxMP, Ritem[Rrole[rnum].Equip[p]].AddMaxMP);
            Inc(Rrole[rnum].CurrentMP, Ritem[Rrole[rnum].Equip[p]].AddMaxMP);
            Rrole[rnum].CurrentMP := max(1, Rrole[rnum].CurrentMP);
            Rrole[rnum].CurrentHP := max(1, Rrole[rnum].CurrentHP);
          end
          else
          begin
            str := '�������������˲��m���b�����Ʒ';
            DrawShadowText(@str[1], 162, 391, ColColor(0, 5), ColColor(0, 7));
            SDL_UpdateRect2(screen, 140, 391, 500, 25);
            WaitAnyKey;
            //redraw;
          end;
        end;
      end;
    end;
    2: //����
    begin
      menu := 1;
      if menu = 1 then
      begin
        menu := SelectItemUser(inum);
        if menu >= 0 then
        begin
          rnum := menu;
          if CanEquip(rnum, inum) then
          begin
            if Rrole[rnum].PracticeBook <> inum then
            begin
              if Rrole[rnum].PracticeBook >= 0 then
                instruct_32(Rrole[rnum].PracticeBook, 1);
              instruct_32(inum, -1);
              Rrole[rnum].PracticeBook := inum;
              //Rrole[rnum].ExpForBook := 0;
            end;
          end
          else
          begin
            str := '�������������˲��m���ޟ�������';
            DrawShadowText(@str[1], 162, 391, ColColor(0, 5), ColColor(0, 7));
            SDL_UpdateRect2(screen, 140, 391, 500, 25);
            WaitAnyKey;
            // redraw;
          end;
        end;
      end;
    end;

    3:
    begin
      if Ritem[inum].EventNum <= 0 then
        SelectItemUser(inum)
      else
        CallEvent(Ritem[inum].EventNum);
    end;
    4: //��������������Ʒ
    begin
      //if where<>3 then break;
    end;
  end;

end;
//���ɲ˵�ʹ����Ʒ

procedure MPUseItem(inum: integer);
var
  x, y, menu, rnum, p: integer;
  str, str1: WideString;
begin
  CurItem := inum;

  case Ritem[inum].ItemType of
    1: //װ��
    begin
      menu := 1;
      if menu = 1 then
      begin
        menu := SelectMPItemUser(inum);
        if menu >= 0 then
        begin
          rnum := menu;
          p := Ritem[inum].EquipType;
          if CanEquip(rnum, inum) then
          begin
            if Rrole[rnum].Equip[p] >= 0 then
            begin
              if Ritem[Rrole[rnum].Equip[p]].Magic > 0 then
              begin
                Ritem[Rrole[rnum].Equip[p]].ExpOfMagic := GetMagicLevel(rnum, Ritem[Rrole[rnum].Equip[p]].Magic);
                StudyMagic(rnum, Ritem[Rrole[rnum].Equip[p]].Magic, 0, 0, 1);
              end;
              Dec(Rrole[rnum].MaxHP, Ritem[Rrole[rnum].Equip[p]].AddMaxHP);
              Dec(Rrole[rnum].CurrentHP, Ritem[Rrole[rnum].Equip[p]].AddMaxHP);
              Dec(Rrole[rnum].MaxMP, Ritem[Rrole[rnum].Equip[p]].AddMaxMP);
              Dec(Rrole[rnum].CurrentMP, Ritem[Rrole[rnum].Equip[p]].AddMaxMP);
              instruct_32(Rrole[rnum].Equip[p], 1);
            end;
            instruct_32(inum, -1);
            Rrole[rnum].Equip[p] := inum;

            if Ritem[Rrole[rnum].Equip[p]].Magic > 0 then
              StudyMagic(rnum, 0, Ritem[Rrole[rnum].Equip[p]].Magic, Ritem[Rrole[rnum].Equip[p]].ExpOfMagic, 1);

            Inc(Rrole[rnum].MaxHP, Ritem[Rrole[rnum].Equip[p]].AddMaxHP);
            Inc(Rrole[rnum].CurrentHP, Ritem[Rrole[rnum].Equip[p]].AddMaxHP);
            Inc(Rrole[rnum].MaxMP, Ritem[Rrole[rnum].Equip[p]].AddMaxMP);
            Inc(Rrole[rnum].CurrentMP, Ritem[Rrole[rnum].Equip[p]].AddMaxMP);
            Rrole[rnum].CurrentMP := max(1, Rrole[rnum].CurrentMP);
            Rrole[rnum].CurrentHP := max(1, Rrole[rnum].CurrentHP);
          end
          else
          begin
            str := '�������������˲��m���b�����Ʒ';
            DrawShadowText(@str[1], 162, 391, ColColor(0, 5), ColColor(0, 7));
            SDL_UpdateRect2(screen, 140, 391, 500, 25);
            WaitAnyKey;
            //redraw;
          end;
        end;
      end;
    end;
    3:
    begin
      if Ritem[inum].EventNum <= 0 then
        SelectMPItemUser(inum)
      else
        CallEvent(Ritem[inum].EventNum);
    end;
  end;

end;

//�ܷ�װ��

function CanEquip(rnum, inum: integer): boolean;
var
  i, r, ng, Aptitude: integer;
begin

  //�ж��Ƿ����
  //ע�������'��������'Ϊ��ֵʱ������ԭ���������ʵĴ���

  Result := True;
  if sign(Ritem[inum].NeedMP) * Rrole[rnum].CurrentMP < Ritem[inum].NeedMP then
    Result := False;
  if sign(Ritem[inum].NeedAttack) * GetRoleAttack(rnum, False) < Ritem[inum].NeedAttack then
    Result := False;
  if sign(Ritem[inum].NeedSpeed) * GetRoleSpeed(rnum, False) < Ritem[inum].NeedSpeed then
    Result := False;
  if sign(Ritem[inum].NeedUsePoi) * GetRoleUsePoi(rnum, False) < Ritem[inum].NeedUsepoi then
    Result := False;
  if sign(Ritem[inum].NeedMedcine) * GetRoleMedcine(rnum, False) < Ritem[inum].NeedMedcine then
    Result := False;
  if sign(Ritem[inum].NeedMedPoi) * GetRoleMedPoi(rnum, False) < Ritem[inum].NeedMedPoi then
    Result := False;
  if sign(Ritem[inum].NeedFist) * GetRoleFist(rnum, False) < Ritem[inum].NeedFist then
    Result := False;
  if sign(Ritem[inum].NeedSword) * GetRoleSword(rnum, False) < Ritem[inum].NeedSword then
    Result := False;
  if sign(Ritem[inum].NeedKnife) * GetRoleKnife(rnum, False) < Ritem[inum].NeedKnife then
    Result := False;
  if sign(Ritem[inum].NeedUnusual) * GetRoleUnusual(rnum, False) < Ritem[inum].NeedUnusual then
    Result := False;
  if sign(Ritem[inum].NeedHidWeapon) * GetRoleHidWeapon(rnum, False) < Ritem[inum].NeedHidWeapon then
    Result := False;

  if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2], Rrole[rnum].equip[3]) = 2 then
    Aptitude := 100
  else Aptitude := Rrole[rnum].Aptitude;

  if sign(Ritem[inum].NeedAptitude) * Aptitude < Ritem[inum].NeedAptitude then
    Result := False;

  //��������
  if (Rrole[rnum].MPType < 2) and (Ritem[inum].NeedMPType < 2) then
    if Rrole[rnum].MPType <> Ritem[inum].NeedMPType then
      Result := False;

  //����ר������, ǰ��Ķ�����
  if (Ritem[inum].OnlyPracRole >= 0) and (Result = True) then
    if (Ritem[inum].OnlyPracRole = rnum) then
      Result := True
    else
      Result := False;

  //������30���书, ����ƷҲ�������书, ����Ϊ�� ,���߃ȹ��ѽ���10���ˣ�Ҳ���
  r := 0;
  ng := 0;
  if Ritem[inum].Magic > 0 then
  begin
    for i := 0 to 29 do
      if Rrole[rnum].lMagic[i] > 0 then
      begin
        r := r + 1;
        if Rmagic[Rrole[rnum].lMagic[i]].MagicType = 5 then ng := ng + 1;
      end;
    if ((r >= 30) and (Ritem[inum].Magic > 0)) or ((ng >= 10) and (Rmagic[Ritem[inum].Magic].MagicType = 5)) then
      Result := False;

    for i := 0 to 29 do
      if Rrole[rnum].lMagic[i] = Ritem[inum].Magic then
      begin
        Result := True;
        break;
      end;

    //�����书�Ѿ�������������Ϊ��
    if (GetMagicLevel(rnum, Ritem[inum].Magic) >= 0) and (Rmagic[Ritem[inum].Magic].MagicType = 5) then
      Result := False
    else if (GetMagicLevel(rnum, Ritem[inum].Magic) >= 100) then
      Result := False;

  end;
  if Result then
  begin
    if (Ritem[inum].needSex = 2) and (Rrole[rnum].Sexual = 0) then
    begin
      setlength(menustring2, 3);
      menustring2[0] := '�j���񹦣��]���Ԍm��';
      menustring2[1] := '�_��';
      menustring2[2] := 'ȡ��';
      if commonMenu22(CENTER_X - 120, CENTER_Y - 80, 240) = 0 then
        Rrole[rnum].Sexual := 2;
    end;
  end;
  if (Ritem[inum].needSex >= 0) and (Ritem[inum].needSex <> Rrole[rnum].Sexual) then
    Result := False;

end;

//�鿴״̬ѡ��

procedure MenuStatus;
var
  str: WideString;
  menu: integer;
begin
  str := '�鿴꠆T��B';
  DrawTextWithRect(@str[1], 80, 30, 139, ColColor($21), ColColor($23));
  menu := SelectOneTeamMember(80, 65, '%3d', 15, 0);
  if menu >= 0 then
  begin
    ShowStatus(TeamList[menu]);
    WaitAnyKey;
    Redraw;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  end;

end;

//��ʾ״̬

procedure ShowStatus(rnum: integer);
var
  i, n, magicnum, Aptitude, mlevel, needexp, x, y: integer;
  p: array[0..10] of integer;
  addatk, adddef, addspeed: integer;
  str: WideString;
  strs: array[0..27] of WideString;
  color1, color2: uint32;
  Name: WideString;

begin
  strs[0] := '�ȼ�';
  strs[1] := '����';
  strs[2] := '����';
  strs[3] := '�w��';
  strs[4] := '���';
  strs[5] := '����';
  strs[6] := '����';
  strs[7] := '���R';
  strs[8] := '�p��';
  strs[9] := '�t������';
  strs[10] := '�ö�����';
  strs[11] := '�ⶾ����';
  strs[12] := 'ȭ�ƹ���';
  strs[13] := '��������';
  strs[14] := 'ˣ������';
  strs[15] := '���T����';
  strs[16] := '��������';
  strs[17] := '�b����Ʒ';
  strs[18] := '�ޟ���Ʒ';
  strs[19] := '�����书';
  strs[20] := '�܂�';
  strs[21] := '�ж�';
  strs[22] := '����';
  strs[23] := '����';
  strs[24] := '�P�S';
  strs[25] := '�Ը�';
  strs[26] := '�ۺ�';
  strs[27] := '����';
  p[0] := 43;
  p[1] := 45;
  p[2] := 44;
  p[3] := 46;
  p[4] := 47;
  p[5] := 48;
  p[6] := 50;
  p[7] := 51;
  p[8] := 52;
  p[9] := 53;
  p[10] := 54;
  Redraw;
  x := 40;
  y := CENTER_Y - 160;

  DrawRectangle(x, y, 560, 315, 0, ColColor(255), 50);
  //��ʾͷ��
  //drawheadpic(Rrole[rnum].HeadNum, x + 60, y + 80);
  ZoomPic(head_pic[Rrole[rnum].HeadNum].pic, 0, x + 60, y + 80 - 60, 58, 60);
  //��ʾ����

  Name := gbktounicode(@Rrole[rnum].Name);
  DrawShadowText(@Name[1], x + 68 - length(pchar(@Rrole[rnum].Name)) * 5, y + 85, ColColor($64), ColColor($66));
  //��ʾ�����ַ�
  for i := 0 to 5 do
    DrawShadowText(@strs[i, 1], x - 10, y + 110 + 21 * i, ColColor($21), ColColor($23));
  for i := 6 to 16 do
    DrawShadowText(@strs[i, 1], x + 160, y + 5 + 21 * (i - 6), ColColor($64), ColColor($66));
  DrawShadowText(@strs[19, 1], x + 410, y + 5, ColColor($21), ColColor($23));

  addatk := 0;
  adddef := 0;
  addspeed := 0;
  for n := 0 to 3 do
  begin
    if Rrole[rnum].Equip[n] >= 0 then
    begin
      addatk := addatk + Ritem[Rrole[rnum].Equip[n]].AddAttack;
      adddef := adddef + Ritem[Rrole[rnum].Equip[n]].AddDefence;
      addspeed := addspeed + Ritem[Rrole[rnum].Equip[n]].AddSpeed;
    end;

  end;

  //����, ����, �Ṧ
  //������������Ϊ��ʾ˳��ʹ洢˳��ͬ
  str := format('%4d', [Rrole[rnum].Attack + addatk]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 0, ColColor($5), ColColor($7));
  str := format('%4d', [Rrole[rnum].Defence + adddef]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 1, ColColor($5), ColColor($7));
  str := format('%4d', [Rrole[rnum].Speed + addspeed]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 2, ColColor($5), ColColor($7));

  //��������
  str := format('%4d', [Rrole[rnum].Medcine]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 3, ColColor($5), ColColor($7));

  str := format('%4d', [Rrole[rnum].UsePoi]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 4, ColColor($5), ColColor($7));

  str := format('%4d', [Rrole[rnum].MedPoi]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 5, ColColor($5), ColColor($7));

  str := format('%4d', [Rrole[rnum].Fist]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 6, ColColor($5), ColColor($7));

  str := format('%4d', [Rrole[rnum].Sword]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 7, ColColor($5), ColColor($7));

  str := format('%4d', [Rrole[rnum].Knife]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 8, ColColor($5), ColColor($7));

  str := format('%4d', [Rrole[rnum].Unusual]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 9, ColColor($5), ColColor($7));

  str := format('%4d', [Rrole[rnum].HidWeapon]);
  DrawEngShadowText(@str[1], x + 260, y + 5 + 21 * 10, ColColor($5), ColColor($7));

  //�书
  for i := 0 to 9 do
  begin
    if Rrole[rnum].jhmagic[i] > 0 then
    begin
      magicnum := Rrole[rnum].lmagic[Rrole[rnum].jhmagic[i]];
      if magicnum > 0 then
      begin
        drawgbkshadowtext(@Rmagic[magicnum].Name, x + 410, y + 26 + 21 * i, ColColor($5), ColColor($7));
        str := format('%3d', [Rrole[rnum].MagLevel[Rrole[rnum].jhmagic[i]] div 100 + 1]);
        DrawEngShadowText(@str[1], x + 570, y + 26 + 21 * i, ColColor($64), ColColor($66));
      end;
    end;
  end;
  str := format('%4d', [Rrole[rnum].Level]);
  DrawEngShadowText(@str[1], x + 110, y + 110, ColColor($5), ColColor($7));
  //����ֵ, �����˺��ж�ֵ��ͬʱʹ�ò�ͬ��ɫ
  case Rrole[rnum].Hurt of
    34..66:
    begin
      color1 := ColColor($E);
      color2 := ColColor($10);
    end;
    67..1000:
    begin
      color1 := ColColor($14);
      color2 := ColColor($16);
    end;
    else
    begin
      color1 := ColColor($5);
      color2 := ColColor($7);
    end;
  end;
  str := format('%4d', [Rrole[rnum].CurrentHP]);
  DrawEngShadowText(@str[1], x + 60, y + 131, color1, color2);

  str := '/';
  DrawEngShadowText(@str[1], x + 100, y + 131, ColColor($64), ColColor($66));

  case Rrole[rnum].Poision of
    34..66:
    begin
      color1 := ColColor($30);
      color2 := ColColor($32);
    end;
    67..1000:
    begin
      color1 := ColColor($35);
      color2 := ColColor($37);
    end;
    else
    begin
      color1 := ColColor($21);
      color2 := ColColor($23);
    end;
  end;
  str := format('%4d', [Rrole[rnum].MaxHP]);
  DrawEngShadowText(@str[1], x + 110, y + 131, color1, color2);
  //����, ������������ʹ����ɫ
  if Rrole[rnum].MPType = 1 then
  begin
    color1 := ColColor($4E);
    color2 := ColColor($50);
  end
  else if Rrole[rnum].MPType = 0 then
  begin
    color1 := ColColor($5);
    color2 := ColColor($7);
  end
  else
  begin
    color1 := ColColor($63);
    color2 := ColColor($66);
  end;
  str := format('%4d/%4d', [Rrole[rnum].CurrentMP, Rrole[rnum].MaxMP]);
  DrawEngShadowText(@str[1], x + 60, y + 152, color1, color2);
  //����
  str := format('%4d/%4d', [Rrole[rnum].PhyPower, MAX_PHYSICAL_POWER]);
  DrawEngShadowText(@str[1], x + 60, y + 173, ColColor($5), ColColor($7));
  //����
  str := format('%5d', [uint16(Rrole[rnum].Exp)]);
  DrawEngShadowText(@str[1], x + 100, y + 194, ColColor($5), ColColor($7));
  if Rrole[rnum].Level = MAX_LEVEL then
    str := '='
  else
    str := format('%5d', [uint16(Leveluplist[Rrole[rnum].Level - 1])]);
  DrawEngShadowText(@str[1], x + 100, y + 215, ColColor($5), ColColor($7));

  //str:=format('%5d', [Rrole[rnum,21]]);
  //drawengshadowtext(@str[1],150,295,colcolor($7),colcolor($5));

  //drawshadowtext(@strs[20, 1], 30, 341, colcolor($21), colcolor($23));
  //drawshadowtext(@strs[21, 1], 30, 362, colcolor($21), colcolor($23));

  //drawrectanglewithoutframe(100,351,Rrole[rnum,19],10,colcolor($16),50);
  //�ж�, ����
  //str := format('%4d', [RRole[rnum].Hurt]);
  //drawengshadowtext(@str[1], 150, 341, colcolor($14), colcolor($16));
  //str := format('%4d', [RRole[rnum].Poision]);
  //drawengshadowtext(@str[1], 150, 362, colcolor($35), colcolor($37));

  //װ��, ����
  DrawShadowText(@strs[17, 1], x + 160, y + 240, ColColor($21), ColColor($23));
  DrawShadowText(@strs[18, 1], x + 410, y + 240, ColColor($21), ColColor($23));
  if Rrole[rnum].Equip[0] >= 0 then
    drawgbkshadowtext(@Ritem[Rrole[rnum].Equip[0]].Name, x + 170, y + 261, ColColor($5), ColColor($7));
  if Rrole[rnum].Equip[1] >= 0 then
    drawgbkshadowtext(@Ritem[Rrole[rnum].Equip[1]].Name, x + 170, y + 282, ColColor($5), ColColor($7));

  //����������Ҫ����
  if Rrole[rnum].PracticeBook >= 0 then
  begin
    mlevel := 1;
    magicnum := Ritem[Rrole[rnum].PracticeBook].Magic;
    if magicnum > 0 then
      for i := 0 to 29 do
        if Rrole[rnum].lMagic[i] = magicnum then
        begin
          mlevel := Rrole[rnum].MagLevel[i] div 100 + 1;
          break;
        end;
    if CheckEquipSet(Rrole[rnum].equip[0], Rrole[rnum].equip[1], Rrole[rnum].equip[2], Rrole[rnum].equip[3]) = 2 then
      Aptitude := 100
    else Aptitude := Rrole[rnum].Aptitude;
    if Ritem[Rrole[rnum].PracticeBook].NeedExp > 0 then
      needexp := mlevel * (Ritem[Rrole[rnum].PracticeBook].NeedExp * (8 - Aptitude div 15)) div 2
    else
      needexp := mlevel * (Ritem[Rrole[rnum].PracticeBook].NeedExp * (1 + Aptitude div 15)) div 2;
    drawgbkshadowtext(@Ritem[Rrole[rnum].PracticeBook].Name, x + 370, y + 261, ColColor($5), ColColor($7));
    str := format('%5d/%5d', [uint16(Rrole[rnum].ExpForBook), needexp]);
    if mlevel = 10 then
      str := format('%5d/=', [uint16(Rrole[rnum].ExpForBook)]);
    DrawEngShadowText(@str[1], x + 400, y + 282, ColColor($64), ColColor($66));
  end;

  DrawShadowText(@strs[22, 1], 30, 320, ColColor($21), ColColor($23));
  str := format('%4d', [Rrole[rnum].Aptitude]);
  DrawEngShadowText(@str[1], 150, 320, ColColor($63), ColColor($66));
  DrawShadowText(@strs[23, 1], 30, 342, ColColor($21), ColColor($23));
  str := format('%4d', [Rrole[rnum].fuyuan]);
  DrawEngShadowText(@str[1], 150, 342, ColColor($63), ColColor($66));


  if rnum > 0 then
  begin
    DrawShadowText(@strs[24, 1], x + 300, y + 5, ColColor(0, $21), ColColor(0, $23));
    if getyouhao(rnum) < 0 then
    begin
      str := '����';
      DrawShadowText(@str[1], x + 340, y + 5, ColColor(0, $13), ColColor(0, $16));
    end
    else if getyouhao(rnum) <= -10 then
    begin
      str := '��ҕ';
      DrawShadowText(@str[1], x + 340, y + 5, ColColor(0, $13), ColColor(0, $16));
    end
    else if getyouhao(rnum) = 0 then
    begin
      str := '�䵭';
      DrawShadowText(@str[1], x + 340, y + 5, ColColor($63), ColColor($66));
    end
    else if getyouhao(rnum) < 10 then
    begin
      str := '�澉';
      DrawShadowText(@str[1], x + 340, y + 5, ColColor($1), ColColor($2));
    end
    else if getyouhao(rnum) < 15 then
    begin
      str := '�Ѻ�';
      DrawShadowText(@str[1], x + 340, y + 5, ColColor($29), ColColor($30));
    end
    else if getyouhao(rnum) < 20 then
    begin
      str := '�H��';
      DrawShadowText(@str[1], x + 340, y + 5, ColColor($29), ColColor($30));
    end
    else if getyouhao(rnum) < 30 then
    begin
      str := '����';
      DrawShadowText(@str[1], x + 340, y + 5, ColColor($14), ColColor($15));
    end
    else
    begin
      str := '�Y�x';
      DrawShadowText(@str[1], x + 340, y + 5, ColColor($16), ColColor($17));
    end;

    DrawShadowText(@strs[25, 1], x + 300, y + 5 + 21, ColColor(0, $21), ColColor(0, $23));
    i := 0;
    if Rrole[rnum].swq > 33 then
    begin
      str := '����';
      DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21, ColColor($5), ColColor($7));
      Inc(i);
    end;
    if Rrole[rnum].pdq > 33 then
    begin
      str := '�ص�';
      if i = 1 then
        str := '��';
      DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21, ColColor($5), ColColor($7));
      Inc(i);
    end;
    if Rrole[rnum].xxq > 33 then
    begin
      str := '�ؾ�';
      if i = 1 then
        str := '��';
      DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21, ColColor($5), ColColor($7));
      Inc(i);
    end;
    if Rrole[rnum].jqq > 33 then
    begin
      str := '���x';
      if i = 1 then
        str := '�x';
      DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21, ColColor($5), ColColor($7));
      Inc(i);
    end;
    DrawShadowText(@strs[26, 1], x + 300, y + 5 + 21 * 2, ColColor(0, $21), ColColor(0, $23));
    i := 0;
    if Rrole[rnum].lwq > 33 then
    begin
      str := '�ھ�';
      DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21 * 2, ColColor($5), ColColor($7));
      Inc(i);
    end;
    if Rrole[rnum].msq > 33 then
    begin
      str := '��˼';
      DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21 * 2, ColColor($5), ColColor($7));
      Inc(i);
    end;
    if Rrole[rnum].ldq > 33 then
    begin
      str := '�ڄ�';
      DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21 * 2, ColColor($5), ColColor($7));
      Inc(i);
    end;
    if Rrole[rnum].qtq > 33 then
    begin
      str := '����';
      DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21 * 2, ColColor($5), ColColor($7));
      Inc(i);
    end;
    if i < 1 then
    begin
      if Rrole[rnum].lwq < 11 then
      begin
        str := '�y��';
        DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21 * 2, ColColor($5), ColColor($7));
        Inc(i);
      end;
      if Rrole[rnum].msq > 33 then
      begin
        str := '�y˼';
        DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21 * 2, ColColor($5), ColColor($7));
        Inc(i);
      end;
      if Rrole[rnum].ldq > 33 then
      begin
        str := '�y��';
        DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21 * 2, ColColor($5), ColColor($7));
        Inc(i);
      end;
      if Rrole[rnum].qtq > 33 then
      begin
        str := '�y��';
        DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21 * 2, ColColor($5), ColColor($7));
        Inc(i);
      end;
    end;
    if i < 1 then
    begin
      str := 'ƽ��';
      DrawShadowText(@str[1], x + 340 + 40 * i, y + 5 + 21 * 2, ColColor($5), ColColor($7));
      Inc(i);
    end;
  end;
  DrawShadowText(@strs[27, 1], x + 300, y + 5 + 21 * 3, ColColor(0, $21), ColColor(0, $23));
  str := '';
  case Rrole[rnum].xiangxing of
    0: str := '����';
    1: str := 'ֱ��';
    2: str := '���';
    3: str := '����';
    4: str := '�Ȕ�';
    5: str := '��Ӌ';
    6: str := '�`��';
    7: str := '���S';
    8: str := '����';
    9: str := '�̈�';
  end;
  DrawShadowText(@str[1], x + 340, y + 5 + 21 * 3, ColColor($5), ColColor($7));


  SDL_UpdateRect2(screen, x, y, 561, 316);

end;

//���ѡ��
             {
procedure MenuLeave;
var
  str: widestring;
  i, menu: integer;
begin
  str := 'Ҫ���l�xꠣ�';
  drawtextwithrect(@str[1], 80, 30, 132, colcolor($21), colcolor($23));
  menu := SelectOneTeamMember(80, 65, '%3d', 15, 0);
  if menu >= 0 then
  begin
    for i := 0 to 99 do
      if leavelist[i] = TeamList[menu] then
      begin
        callevent(BEGIN_LEAVE_EVENT + i * 2);
        SDL_EnableKeyRepeat(0, 10);
        break;
      end;
  end;
  redraw;

end;          }

//ϵͳѡ��

procedure MenuSystem;
var
  i, menu, menup: integer;
begin
  menu := 0;
  ShowMenuSystem(menu);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    if where = 3 then
      break;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          menu := menu + 1;
          if menu > 3 then
            menu := 0;
          ShowMenuSystem(menu);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          menu := menu - 1;
          if menu < 0 then
            menu := 3;
          ShowMenuSystem(menu);
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          Redraw;
          SDL_UpdateRect2(screen, 80, 30, 47, 95);
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          case menu of
            3:
            begin
              MenuQuit;
            end;
            1:
            begin
              MenuSave;
            end;
            0:
            begin
              MenuLoad;
            end;
            2:
            begin
              SwitchFullscreen;
            end;
          end;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Redraw;
          SDL_UpdateRect2(screen, 80, 30, 47, 95);
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
          case menu of
            3:
            begin
              MenuQuit;
            end;
            1:
            begin
              MenuSave;
            end;
            0:
            begin
              MenuLoad;
            end;
            2:
            begin
              if FULLSCREEN = 1 then
              begin
                if HW = 0 then screen :=
                    SDL_SetVideoMode(CENTER_X * 2, CENTER_Y * 2, 32, SDL_HWSURFACE or SDL_DOUBLEBUF or SDL_ANYFORMAT)
                else screen := SDL_SetVideoMode(CENTER_X * 2, CENTER_Y * 2, 32, SDL_SWSURFACE or
                    SDL_DOUBLEBUF or SDL_ANYFORMAT);
              end
              else
                screen := SDL_SetVideoMode(CENTER_X * 2, CENTER_Y * 2, 32, SDL_FULLSCREEN);
              FULLSCREEN := 1 - FULLSCREEN;
              Kys_ini.WriteInteger('set', 'fullscreen', FULLSCREEN);
              break;
            end;
          end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x >= 80) and (event.button.x < 127) and (event.button.y > 47) and
          (event.button.y < 120) then
        begin
          menup := menu;
          menu := (event.button.y - 32) div 22;
          if menu > 3 then
            menu := 3;
          if menu < 0 then
            menu := 0;
          if menup <> menu then
            ShowMenuSystem(menu);
        end;
      end;
    end;
  end;

end;

//��ʾϵͳѡ��

procedure ShowMenuSystem(menu: integer);
var
  word: array[0..3] of WideString;
  i: integer;
begin
  word[0] := '�xȡ';
  word[1] := '��n';
  word[2] := 'ȫ��';
  word[3] := '�x�_';
  if FULLSCREEN = 1 then
    word[2] := '����';
  Redraw;
  DrawRectangle(80, 30, 46, 92, 0, ColColor(255), 30);
  for i := 0 to 3 do
    if i = menu then
    begin
      DrawText(screen, @word[i][1], 64, 32 + 22 * i, ColColor($64));
      DrawText(screen, @word[i][1], 63, 32 + 22 * i, ColColor($66));
    end
    else
    begin
      DrawText(screen, @word[i][1], 64, 32 + 22 * i, ColColor($5));
      DrawText(screen, @word[i][1], 63, 32 + 22 * i, ColColor($7));
    end;
  SDL_UpdateRect2(screen, 80, 30, 47, 93);

end;

//����ѡ��

procedure MenuLoad;
var
  menu, i: integer;
begin
  setlength(menuString, 0);
  setlength(menuString, 5);
  setlength(menuEngString, 0);
  menuString[0] := '�M��һ';
  menuString[1] := '�M�ȶ�';
  menuString[2] := '�M����';
  menuString[3] := '�M����';
  menuString[4] := '�M����';
  menu := CommonMenu(133, 30, 67, 4);
  if menu >= 0 then
  begin
    LoadR(menu + 1);
    if where = 1 then
    begin
      JmpScene(curScene, Sy, Sx);
    end;
    Redraw;
    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
    ShowMenu(5);
    ShowMenuSystem(0);
  end;

end;

//����Ķ���ѡ��, �����ڿ�ʼʱ����

function MenuLoadAtBeginning: boolean;
var
  menu: integer;
begin
  Redraw;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  setlength(menuString, 0);
  setlength(menuString, 6);
  setlength(menuEngString, 0);
  menuString[0] := '�d���M��һ';
  menuString[1] := '�d���M�ȶ�';
  menuString[2] := '�d���M����';
  menuString[3] := '�d���M����';
  menuString[4] := '�d���M����';
  menuString[5] := '�d���Ԅәn';
  menu := CommonMenu(265, 280, 107, 5);
  Result := False;
  if menu >= 0 then
  begin
    Result := True;
    LoadR(menu + 1);
    initialWimage;
  end;

end;

//�浵ѡ��

procedure MenuSave;
var
  menu: integer;
begin
  setlength(menuString, 0);
  setlength(menuString, 5);
  menuString[0] := '�M��һ';
  menuString[1] := '�M�ȶ�';
  menuString[2] := '�M����';
  menuString[3] := '�M����';
  menuString[4] := '�M����';
  menu := CommonMenu(133, 30, 67, 4);
  if menu >= 0 then
    SaveR(menu + 1);

end;

//�˳�ѡ��

procedure MenuQuit;
var
  menu: integer;
begin
  setlength(menuString, 0);
  setlength(menuString, 2);
  menuString[0] := 'ȡ��';
  menuString[1] := '�_��';
  menu := CommonMenu(133, 30, 45, 1);
  if menu = 1 then
  begin
    Quit;
  end;

end;

//ҽ�Ƶ�Ч��

procedure EffectMedcine(role1, role2: integer);
var
  word: WideString;
  addlife: integer;
begin
  if Rrole[role1].PhyPower < 50 then exit;
  addlife := GetRoleMedcine(role1, True) * (10 - Rrole[role2].Hurt div 8) div 5;
  if Rrole[role2].Hurt - GetRoleMedcine(role1, True) > 20 then
    addlife := 0;
  Rrole[role2].Hurt := Rrole[role2].Hurt - (addlife + 10) div LIFE_HURT;
  if Rrole[role2].Hurt < 0 then
    Rrole[role2].Hurt := 0;
  if addlife > Rrole[role2].MaxHP - Rrole[role2].CurrentHP then
    addlife := Rrole[role2].MaxHP - Rrole[role2].CurrentHP;
  Rrole[role2].CurrentHP := Rrole[role2].CurrentHP + addlife;
  if addlife > 0 then
    if (not GetEquipState(role1, 1)) and (not GetGongtiState(role1, 1)) then
      Rrole[role1].PhyPower := Rrole[role1].PhyPower - 3;

end;

//�ⶾ��Ч��

procedure EffectMedPoision(role1, role2: integer);
var
  word: WideString;
  minuspoi: integer;
begin
  if Rrole[role1].PhyPower < 50 then exit;
  minuspoi := GetRoleMedPoi(role1, True);
  if minuspoi < (Rrole[role2].Poision div 2) then
    minuspoi := 0
  else if minuspoi > Rrole[role2].Poision then
    minuspoi := Rrole[role2].Poision;
  Rrole[role2].Poision := Rrole[role2].Poision - minuspoi;

  if minuspoi > 0 then
    if (not GetEquipState(role1, 1)) and (not GetGongtiState(role1, 1)) then
      Rrole[role1].PhyPower := Rrole[role1].PhyPower - 3;
end;

//ʹ����Ʒ��Ч��
//�������ŵ�Ч��

procedure EatOneItem(rnum, inum: integer; isshow: boolean);
var
  i, p, l, x, y: integer;
  word: array[0..24] of WideString;
  addvalue, rolelist: array[0..24] of integer;
  str: WideString;

begin

  word[0] := '��������';
  word[1] := '�����������ֵ';
  word[2] := '�ж��̶�';
  word[3] := '�����w��';
  word[4] := '�����T·�ı��';
  word[5] := '���Ӄ���';
  word[6] := '���Ӄ������ֵ';
  word[7] := '���ӹ�����';
  word[8] := '�����p��';
  word[9] := '���ӷ��R��';
  word[10] := '�����t������';
  word[11] := '�����ö�����';
  word[12] := '���ӽⶾ����';
  word[13] := '���ӿ�������';
  word[14] := '����ȭ������';
  word[15] := '������������';
  word[16] := '����ˣ������';
  word[17] := '�������T����';
  word[18] := '���Ӱ�������';
  word[19] := '������W���R';
  word[20] := '����Ʒ��ָ��';
  word[21] := '�������һ���';
  word[22] := '���ӹ��􎧶�';
  word[23] := '�܂��̶�';
  word[24] := '�֏͂���';
  rolelist[0] := 17;
  rolelist[1] := 18;
  rolelist[2] := 20;
  rolelist[3] := 21;
  rolelist[4] := 40;
  rolelist[5] := 41;
  rolelist[6] := 42;
  rolelist[7] := 43;
  rolelist[8] := 44;
  rolelist[9] := 45;
  rolelist[10] := 46;
  rolelist[11] := 47;
  rolelist[12] := 48;
  rolelist[13] := 49;
  rolelist[14] := 50;
  rolelist[15] := 51;
  rolelist[16] := 52;
  rolelist[17] := 53;
  rolelist[18] := 54;
  rolelist[19] := 55;
  rolelist[20] := 56;
  rolelist[21] := 58;
  rolelist[22] := 57;
  rolelist[23] := 19;
  rolelist[24] := 39;
  //rolelist:=(17,18,20,21,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,58,57);
  for i := 0 to 22 do
  begin
    addvalue[i] := Ritem[inum].Data[45 + i];
  end;
  //��������
  addvalue[23] := -(addvalue[0] div (LIFE_HURT));
  addvalue[24] := Ritem[inum].rehurt;
  if -addvalue[23] > Rrole[rnum].Data[19] then
    addvalue[23] := -Rrole[rnum].Data[19];

  //��������, �������ֵ�Ĵ���
  if addvalue[1] + Rrole[rnum].Data[18] > MAX_HP then
    addvalue[1] := MAX_HP - Rrole[rnum].Data[18];
  if addvalue[6] + Rrole[rnum].Data[42] > MAX_MP then
    addvalue[6] := MAX_MP - Rrole[rnum].Data[42];
  if addvalue[1] + Rrole[rnum].Data[18] < 0 then
    addvalue[1] := -Rrole[rnum].Data[18];
  if addvalue[6] + Rrole[rnum].Data[42] < 0 then
    addvalue[6] := -Rrole[rnum].Data[42];

  for i := 7 to 22 do
  begin
    if addvalue[i] + Rrole[rnum].Data[rolelist[i]] > MaxProList[rolelist[i]] then
      addvalue[i] := MaxProList[rolelist[i]] - Rrole[rnum].Data[rolelist[i]];
    if addvalue[i] + Rrole[rnum].Data[rolelist[i]] < 0 then
      addvalue[i] := -Rrole[rnum].Data[rolelist[i]];
  end;
  //�������ܳ������ֵ
  if addvalue[0] + Rrole[rnum].Data[17] > addvalue[1] + Rrole[rnum].Data[18] then
    addvalue[0] := addvalue[1] + Rrole[rnum].Data[18] - Rrole[rnum].Data[17];
  //�ж�����С��0
  if addvalue[2] + Rrole[rnum].Data[20] < 0 then
    addvalue[2] := -Rrole[rnum].Data[20];
  //�������ܳ���100
  if addvalue[3] + Rrole[rnum].Data[21] > MAX_PHYSICAL_POWER then
    addvalue[3] := MAX_PHYSICAL_POWER - Rrole[rnum].Data[21];
  //�������ܳ������ֵ
  if addvalue[5] + Rrole[rnum].Data[41] > addvalue[6] + Rrole[rnum].Data[42] then
    addvalue[5] := addvalue[6] + Rrole[rnum].Data[42] - Rrole[rnum].Data[41];
  p := 0;
  for i := 0 to 23 do
  begin
    if (i <> 4) and (i <> 21) and (addvalue[i] <> 0) then
      p := p + 1;
  end;
  if (addvalue[4] >= 0) and (Rrole[rnum].Data[40] <> 2) then
    p := p + 1;
  if (addvalue[21] = 1) and (Rrole[rnum].Data[58] <> 1) then
    p := p + 1;

  if isshow and (where = 2) then
    ShowSimpleStatus(rnum, 50, 240);
  if isshow and ((where = 2) or (Ritem[inum].ItemType = 3)) then
  begin
    DrawRectangle(100 + (1 - (where div 2)) * 180, 70, 200, 25, 0, ColColor(255), 55);
    str := '����';
    if Ritem[inum].ItemType = 2 then
      str := '����';
    DrawShadowText(@str[1], 83 + (1 - (where div 2)) * 180, 72, ColColor($21), ColColor($23));
    Drawgbkshadowtext(@Ritem[inum].Name, 143 + (1 - (where div 2)) * 180, 72, ColColor($64), ColColor($66));
    //������ӵ����11��, ��������ʾ
    if p < 11 then
    begin
      l := p;
      DrawRectangle(100 + (1 - (where div 2)) * 180, 100, 200, 22 * l + 25, 0, ColColor($FF), 55);
    end
    else
    begin
      l := p div 2 + 1;
      DrawRectangle(100 + (1 - (where div 2)) * 180, 100, 400, 22 * l + 25, 0, ColColor($FF), 55);
    end;
    drawgbkshadowtext(@Rrole[rnum].Data[4], 83 + (1 - (where div 2)) * 180, 102, ColColor($21), ColColor($23));
    str := 'δ���ӌ���';
    if p = 0 then
      DrawShadowText(@str[1], 163 + (1 - (where div 2)) * 180, 102, ColColor(5), ColColor(7));
    p := 0;
  end;
  for i := 0 to 24 do
  begin
    if p < l then
    begin
      x := 0;
      y := 0;
    end
    else
    begin
      x := 200;
      y := -l * 22;
    end;
    if (i <> 4) and (i <> 21) and (addvalue[i] <> 0) then
    begin
      Rrole[rnum].Data[rolelist[i]] := Rrole[rnum].Data[rolelist[i]] + addvalue[i];
      if isshow and ((where = 2) or (Ritem[inum].ItemType = 3)) then
      begin
        DrawShadowText(@word[i, 1], 83 + x + (1 - (where div 2)) * 180, 124 + y + p * 22, ColColor(5), ColColor(7));
        str := format('%4d', [addvalue[i]]);
        DrawEngShadowText(@str[1], 243 + x + (1 - (where div 2)) * 180, 124 + y + p * 22,
          ColColor($64), ColColor($66));

      end;

      p := p + 1;
    end;
    //�������������⴦��
    if (i = 4) and (addvalue[i] >= 0) and (Rrole[rnum].Data[40] <> 2) then
    begin
      if (Rrole[rnum].Data[rolelist[i]] <> 2) then Rrole[rnum].Data[rolelist[i]] := addvalue[i];

      if isshow then
      begin
        if addvalue[i] = 0 then str := word[i] + '���'
        else if addvalue[i] = 1 then str := word[i] + '���'
        else str := word[i] + '�{��';
        DrawShadowText(@str[1], 83 + x + (1 - (where div 2)) * 180, 124 + y + p * 22, ColColor(5), ColColor(7));
        p := p + 1;
      end;
    end;
    //�����һ������⴦��
    if (i = 21) and (addvalue[i] = 1) then
    begin
      if Rrole[rnum].Data[rolelist[i]] <> 1 then
      begin
        Rrole[rnum].Data[rolelist[i]] := 1;
        if isshow and ((where = 2) or (Ritem[inum].ItemType <> 3)) then
        begin
          DrawShadowText(@word[i, 1], 83 + (1 - (where div 2)) * 180 + x, 124 + y + p * 22, ColColor(5), ColColor(7));
        end;
        p := p + 1;
      end;
    end;
  end;
  if isshow then

    SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

//Event.
//�¼�ϵͳ

procedure CallEvent(num: integer);
var
  e: array of smallint;
  i, idx, grp, offset, len, p, n, i1: integer;
  check: boolean;
  cc: uint16;
begin
  //CurEvent:=num;
  SDL_EventState(SDL_MOUSEMOTION, SDL_enable);
  if debug = 1 then
    ShowMessage('�¼�' + IntToStr(num) + '�ѽ��|�l');
  Cx := Sx;
  Cy := Sy;
  xunchou.num:=0;
  setlength(xunchou.rnumlist,0);
  RShowpic.repeated:=-1;
  Sstep := 0;
  //SDL_EnableKeyRepeat(0, 10);
  idx := FileOpen('resource\kdef.idx', fmopenread);
  grp := FileOpen('resource\kdef.grp', fmopenread);
  if num = 0 then
  begin
    offset := 0;
    FileRead(idx, len, 4);
  end
  else
  begin
    FileSeek(idx, (num - 1) * 4, 0);
    FileRead(idx, offset, 4);
    FileRead(idx, len, 4);
  end;
  len := (len - offset) div 2;
  setlength(e, len + 1);
  FileSeek(grp, offset, 0);
  FileRead(grp, e[0], len * 2);
  FileClose(idx);
  FileClose(grp);

  for i1 := 0 to length(Rrole) - 1 do
  begin
    Rrole[i1].israndomed := 0;
  end;
  i := 0;
  //��ͨ�¼�д���ӳ�, ����ת�¼�д�ɺ���
  while e[i] >= 0 do
  begin
    //SDL_EnableKeyRepeat(0, 10);
    case e[i] of
      0:
      begin
        i := i + 1;
        instruct_0;
        continue;
      end;
      1:
      begin
        instruct_1(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      2:
      begin
        instruct_2(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      3:
      begin
        instruct_3([e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5], e[i + 6], e[i + 7],
          e[i + 8], e[i + 9], e[i + 10], e[i + 11], e[i + 12], e[i + 13], e[i + 14], e[i + 15],
          e[i + 16], e[i + 17], e[i + 18], e[i + 19], e[i + 20]]);
        i := i + 21;
      end;
      4:
      begin
        i := i + instruct_4(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      5:
      begin
        i := i + instruct_5(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      6:
      begin
        i := i + instruct_6(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      7: //Break the event.
      begin
        break;
      end;
      8:
      begin
        instruct_8(e[i + 1]);
        i := i + 2;
      end;
      9:
      begin
        i := i + instruct_9(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      10:
      begin
        instruct_10(e[i + 1]);
        i := i + 2;
      end;
      11:
      begin
        i := i + instruct_11(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      12:
      begin
        instruct_12;
        i := i + 1;
      end;
      13:
      begin
        instruct_13;
        i := i + 1;
      end;
      14:
      begin
        instruct_14;
        i := i + 1;
      end;
      15:
      begin
        instruct_15;
        i := i + 1;
        break;
      end;
      16:
      begin
        i := i + instruct_16(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      17:
      begin
        instruct_17([e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]]);
        i := i + 6;
      end;
      18:
      begin
        i := i + instruct_18(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      19:
      begin
        instruct_19(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      20:
      begin
        i := i + instruct_20(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      21:
      begin
        instruct_21(e[i + 1]);
        i := i + 2;
      end;
      22:
      begin
        instruct_22;
        i := i + 1;
      end;
      23:
      begin
        instruct_23(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      24:
      begin
        instruct_24;
        i := i + 1;
      end;
      25:
      begin
        instruct_25(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      26:
      begin
        instruct_26(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;
      27:
      begin
        instruct_27(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      28:
      begin
        i := i + instruct_28(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;
      29:
      begin
        i := i + instruct_29(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;
      30:
      begin
        instruct_30(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      31:
      begin
        i := i + instruct_31(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      32:
      begin
        instruct_32(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      33:
      begin
        instruct_33(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      34:
      begin
        instruct_34(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      35:
      begin
        instruct_35(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      36:
      begin
        i := i + instruct_36(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      37:
      begin
        instruct_37(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      38:
      begin
        instruct_38(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      39:
      begin
        instruct_39(e[i + 1]);
        i := i + 2;
      end;
      40:
      begin
        instruct_40(e[i + 1]);
        i := i + 2;
      end;
      41:
      begin
        instruct_41(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      42:
      begin
        i := i + instruct_42(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      43:
      begin
        i := i + instruct_43(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      44:
      begin
        instruct_44(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5], e[i + 6]);
        i := i + 7;
      end;
      45:
      begin
        instruct_45(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      46:
      begin
        instruct_46(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      47:
      begin
        instruct_47(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      48:
      begin
        instruct_48(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      49:
      begin
        instruct_49(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      50:
      begin
        p := instruct_50([e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5], e[i + 6], e[i + 7]]);
        i := i + 8;
        if p < 622592 then
          i := i + p
        else
        begin
          n := 0;
          while ((e[i + 8 * n] = 50) and (e[i + 8 * n + 1] = 32)) do
          begin
            Inc(n);
          end;
          e[i + 8 * n + ((p + 32768) div 655360) - 1] := p mod 655360;
        end;
      end;
      51:
      begin
        instruct_51;
        i := i + 1;
      end;
      52:
      begin
        instruct_52;
        i := i + 1;
      end;
      53:
      begin
        instruct_53;
        i := i + 1;
      end;
      54:
      begin
        instruct_54;
        i := i + 1;
      end;
      55:
      begin
        i := i + instruct_55(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      56:
      begin
        instruct_56(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      57:
      begin
        i := i + 1;
      end;
      58:
      begin
        instruct_58;
        i := i + 1;
      end;
      59:
      begin
        instruct_59;
        i := i + 1;
      end;
      60:
      begin
        i := i + instruct_60(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;
      61:
      begin
        i := i + e[i + 1];
        i := i + 3;
      end;
      62:
      begin
        instruct_62;
        i := i + 1;
        break;
      end;
      63:
      begin
        instruct_63(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      64:
      begin
        NewShop(e[i + 1]);
        i := i + 2;
      end;
      65:
      begin
        i := i + 1;
      end;
      66:
      begin
        instruct_66(e[i + 1]);
        i := i + 2;
      end;
      67:
      begin
        instruct_67(e[i + 1]);
        i := i + 2;
      end;
      68:
      begin
        NewTalk(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5], e[i + 6], e[i + 7]);
        i := i + 8;
      end;
      69:
      begin
        ReSetName(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      70:
      begin
        ShowTitle(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      71:
      begin
        JmpScene(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      //ljyinvader edit start
      73:
      begin
        xuewu(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      74:
      begin
        newtalk2(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5], e[i + 6], e[i + 7]);
        i := i + 8;
      end;
      75:
      begin
        showmenpai(e[i + 1]);
        i := i + 2;
      end;
      76:
      begin
        tiaose;
        i := i + 1;
      end;
      77:
      begin
        givezhangmen(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      78:
      begin
        i := i + iszhangmen(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      79:
      begin
        menpaimenu(e[i + 1]);
        i := i + 2;
      end;
      80:
      begin
        joinmenpai(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      81:
      begin
        i := i + IsInMenpai(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      83:
      begin
        i := i + chkyouhao(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;

      //luke edit

      82:
      begin
        addziyuan(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      84:
      begin
        changejiaoqing(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      85:
      begin
        i := i + checkmpgx(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;
      86:
      begin
        changempgx(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      87:
      begin
        i := i + checkmpsw(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;
      88:
      begin
        addmpshengwang(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      89:
      begin
        i := i + checkmpse(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;
      90:
      begin
        changempse(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      91:
      begin
        i := i + xuanze2(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      92:
      begin
        i := i + checkeventpar(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5], e[i + 6], e[i + 7]);
        i := i + 8;
      end;
      93:
      begin
        xiugaievent(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;
      94:
      begin
        SecChangeMp(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      95:
      begin
        i := i + sjqiecuo(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      96:
      begin
        dayto(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      97:
      begin
        i := i + checkfy(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      98:
      begin
        ShowStatus(e[i + 1]);
        WaitAnyKey;
        i := i + 2;
      end;
      99:
      begin
        gotommap(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      100:
      begin
        zjcjg;
        i := i + 1;
      end;
      101:
      begin
        zjbgsmenu;
        i := i + 1;
      end;
      102:
      begin
        zjldl;
        i := i + 1;
      end;
      103:
      begin
        zjdzt;
        i := i + 1;
      end;
      104:
      begin
        roledie(e[i + 1]);
        i := i + 2;
      end;
      105:
      begin
        changezhongcheng(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      106:
      begin
        talktotips(e[i + 1]);
        i := i + 2;
      end;
      107:
      begin
        suijijiangli(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      108:
      begin
        addteamjiaoqing(e[i + 1]);
        i := i + 2;
      end;
      109:
      begin
        randomrole(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5], e[i + 6], e[i + 7],
          e[i + 8], e[i + 9], e[i + 10], e[i + 11], e[i + 12]);
        i := i + 13;
      end;
      110:
      begin
        clearrole(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      111:
      begin
        i := i + checkjiaoqing(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;
      112:
      begin
        changewardata(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      113:
      begin
        rolejicheng(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      114:
      begin
        addtishi(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
      115:
      begin
        gettishi(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      116:
      begin
        aotobuildrole(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      117:
      begin
        ShutSceSheshi(e[i + 1]);
        i := i + 2;
      end;
      118:
      begin
        BuildBattle(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5], e[i + 6]);
        i := i + 7;
      end;
      119:
      begin
        AddBattleRole(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5], e[i + 6], e[i + 7], e[i + 8]);
        i := i + 9;
      end;
      120:
      begin
        addexpn(e[i + 1], e[i + 2]);
        i := i + 3;
      end;
      121:
      begin
        showdizi2(e[i + 1]);
        i := i + 2;
      end;
      122: //��ȡ��ǰ�¼�������.
      begin
        Feventcaller(e[i + 1], e[i + 2], e[i + 3], e[i + 4]);
        i := i + 5;
      end;
      123: //ֱ�ӽ�����ŵ���ͼ
      begin
        i := i + RoleEvent(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5], e[i + 6],
          e[i + 7], e[i + 8], e[i + 9], e[i + 10], e[i + 11], e[i + 12], e[i + 13], e[i + 14],
          e[i + 15], e[i + 16], e[i + 17], e[i + 18], e[i + 19], e[i + 20], e[i + 21],
          e[i + 22], e[i + 23], e[i + 24], e[i + 25]);

        i := i + 26;
      end;
      124: //���ӻ��޸�������ʾ
      begin
        addrenwu(e[i + 1], e[i + 2], e[i + 3], e[i + 4], e[i + 5]);
        i := i + 6;
      end;
      125: //�³�ս��������Ա
      begin
        AddEnemyNextFight(e[i + 1], e[i + 2], e[i + 3]);
        i := i + 4;
      end;
    end;

  end;
  SDL_EventState(SDL_MOUSEMOTION, SDL_ignore);
  event.key.keysym.sym := 0;
  event.button.button := 0;

  //InitialScene;
  //if where <> 2 then CurEvent := -1;
  //redraw;
  //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  // SDL_EnableKeyRepeat(30, 30);

end;

procedure FourPets;
var
  r, i, r1: integer;
begin
  //setlength(Menuengstring, 4);
  r := 0;
  display_imgFromSurface(SKILL_PIC, 0, 0);
  ShowPetStatus(r + 1, 0);
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  SDL_EnableKeyRepeat(10, 100);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYDOWN:
      begin
        if (event.key.keysym.sym = SDLK_DOWN) or (event.key.keysym.sym = SDLK_KP2) then
        begin
          r := r + 1;
          if r >= Rrole[0].PetAmount then
            r := 0;
          ShowPetStatus(r + 1, 0);
        end;
        if (event.key.keysym.sym = SDLK_UP) or (event.key.keysym.sym = SDLK_KP8) then
        begin
          r := r - 1;
          if r < 0 then
            r := Rrole[0].PetAmount - 1;
          ShowPetStatus(r + 1, 0);
        end;
      end;

      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          if PetStatus(r + 1) = False then
            break;
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          if (event.button.x >= 10) and (event.button.x < 90) and (event.button.y > 20) and
            (event.button.y < (Rrole[0].PetAmount * 23) + 20) then
          begin
            r1 := r;
            r := (event.button.y - 20) div 23;
            //����ƶ�ʱ����x, y�����仯ʱ���ػ�
            if (r <> r1) then
            begin
              if PetStatus(r + 1) = False then
                break;
              //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            end;
          end;
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x < 120) then
        begin
          if (event.button.x >= 10) and (event.button.x < 90) and (event.button.y >= 20) and
            (event.button.y < (Rrole[0].PetAmount * 23) + 20) then
          begin
            r1 := r;
            r := (event.button.y - 20) div 23;
            //����ƶ�ʱ����x, y�����仯ʱ���ػ�
            if (r <> r1) then
            begin
              ShowPetStatus(r + 1, 0);
              //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            end;
          end;
        end
        else //����ƶ�ʱ����x, y�����仯ʱ���ػ�

        if PetStatus(r + 1) = False then
          break;
      end;
    end;
  end;
  //r := CommonMenu(80, 30, 75, 3, r);
  //ShowCommonMenu(15, 15, 75, 3, r);
  //SDL_UpdateRect2(screen, 15, 15, 76, 316);
  SDL_EnableKeyRepeat(30, (30 * gamespeed) div 10);

end;

procedure ShowSkillMenu(menu: integer);
var
  i: integer;
begin
  display_imgFromSurface(SKILL_PIC, 10, 10, 10, 10, 110, 180);
  setlength(menuString, 0);
  setlength(menuString, 5);
  menuString[0] := gbktounicode(@Rrole[1].Name[0]);

  menuString[1] := gbktounicode(@Rrole[2].Name[0]);

  menuString[2] := gbktounicode(@Rrole[3].Name[0]);

  menuString[3] := gbktounicode(@Rrole[4].Name[0]);

  menuString[4] := gbktounicode(@Rrole[5].Name[0]);

  DrawRectangle(15, 16, 100, Rrole[0].PetAmount * 23 + 10, 0, ColColor(0, 255), 40);
  for I := 0 to Rrole[0].PetAmount - 1 do
  begin
    if i = menu then
    begin
      DrawText(screen, @menuString[i][1], 5, 20 + 23 * i, ColColor($64));
      DrawText(screen, @menuString[i][1], 6, 20 + 23 * i, ColColor($66));
    end
    else
    begin
      DrawText(screen, @menuString[i][1], 5, 20 + 23 * i, ColColor($5));
      DrawText(screen, @menuString[i][1], 6, 20 + 23 * i, ColColor($7));
    end;
  end;
  //  SDL_UpdateRect2(screen, 0, 0, 120, 440);
end;

function PetStatus(r: integer): boolean;
var
  i, menu, menup, p: integer;
  x, y, w: integer;
begin
  x := 100 + 40;
  y := 180 - 60;
  w := 50;
  p := 0;
  Result := False;

  menu := 0;
  ShowPetStatus(r, menu);
  while (SDL_WaitEvent(@event) >= 0) do
  begin
    CheckBasicEvent;
    case event.type_ of
      SDL_KEYUP:
      begin
        if (event.key.keysym.sym = SDLK_RIGHT) or (event.key.keysym.sym = SDLK_KP6) then
        begin
          menu := menu + 1;
          if menu >= 5 then
            menu := 0;
          Result := True;
          ShowPetStatus(r, menu);
        end;
        if (event.key.keysym.sym = SDLK_LEFT) or (event.key.keysym.sym = SDLK_KP4) then
        begin
          menu := menu - 1;
          if menu < 0 then
            menu := 4;
          Result := True;
          ShowPetStatus(r, menu);
        end;
        if (event.key.keysym.sym = SDLK_ESCAPE) then
        begin
          break;
        end;
        if (event.key.keysym.sym = SDLK_RETURN) or (event.key.keysym.sym = SDLK_SPACE) then
        begin
          PetLearnSkill(r, menu);
        end;
      end;
      SDL_MOUSEBUTTONUP:
      begin
        if (event.button.button = SDL_BUTTON_RIGHT) then
        begin
          Result := False;
          break;
        end;
        if (event.button.button = SDL_BUTTON_LEFT) then
        begin
          if (event.button.x >= x) and (event.button.x < x + w * 5) and (event.button.y > y) and
            (event.button.y < y * 5) then
          begin
            menup := menu;
            menu := (event.button.x - x) div w;
            //����ƶ�ʱ����x, y�����仯ʱ���ػ�
            if (menu <> menup) then
            begin
              Result := False;
              showPetStatus(r, menu);
              //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
            end;
          end;
          PetLearnSkill(r, menu);
        end;
      end;
      SDL_MOUSEMOTION:
      begin
        if (event.button.x < 120) then
        begin
          Result := True;
          break;
        end
        else if (event.button.x >= x) and (event.button.x < x + w * 5) and (event.button.y > y) and
          (event.button.y < y * 5) then
        begin
          menup := menu;
          menu := (event.button.x - x) div w;
          Result := False;
          //����ƶ�ʱ����x, y�����仯ʱ���ػ�
          if (menu <> menup) then
          begin
            showPetStatus(r, menu);
            //SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
          end;
        end;
      end;
    end;
  end;

end;

procedure ShowPetStatus(r, p: integer);
var
  i, x, y, w, col1, col2: integer;
  words: array[1..5, 0..4] of WideString;
  str: WideString;
begin
  ShowSkillMenu(r - 1);
  x := 100;
  y := 180;
  w := 50;
  //writeln(p);
  words[1, 0] := '���䣺 30�������ڑ��Y��ь����书���������š�';

  words[1, 1] := '���x��' + gbktounicode(@Rrole[0].Name[0]) + '���Y������ӡ�';
  words[1, 2] := 'ͨ�䣺 60�������ڑ��Y��ь����书���������š�';
  words[1, 3] := '��У� �ҷ�ȫ�T���Y������ӡ�';
  words[1, 4] := '���䣺 100�����ʰё��Y��ь����书���������š�';

  words[2, 0] := '��ؔ�� ���Y�������y�����롣';
  words[2, 1] := 'Ԓ�g�� �ľ�����д�̽���龀����';
  words[2, 2] := '��͵�� ���Y��͵�Ì����S����Ʒ���b�䡣';
  words[2, 3] := '���r�� ���н��״��ۿۡ�';
  words[2, 4] := 'ͨ�`�� �̵���ُ�I�[�،��';

  words[3, 0] := '�ռ��� �ռ�ˎ���c��ͨʳ�ġ�';
  words[3, 1] := 'ᄾƣ� �ھƽѺ��M���X�c��ͨʳ����Ƹ��N�ơ�';
  words[3, 2] := 'ʳ�� �ռ������ϡ�';
  words[3, 3] := '��ˎ�� ��ˎ�t���M���X�cˎ���u��؏��w�ȣ��ⶾ֮*��ˎ��';
  words[3, 4] := '�񵤣� ��ˎ�t���M���X������ˎ�ğ��u��׃�w�|֮��*ˎ�������S�r��׃�����w�|������';

  words[4, 0] := '�ѹΣ� �ռ���ʯ����ͨ�Vʯ��';
  words[4, 1] := '�㶾�� �ڟ��F�t���M���X����ͨ�Vʯ��ˎ���u�쎧��*������';
  words[4, 2] := '�C�P�� �C�P�y�Ƚ��͡�';
  words[4, 3] := '�T���� �ڟ��F�t�����������錚�ס�';
  words[4, 4] := '����� �ڟ��F�t�����������������';

  words[5, 0] := '��̽�� ���Y�п��^������������B��';
  words[5, 1] := '���裺' + gbktounicode(@Rrole[0].Name[0]) + '���Y�������Єӡ�';
  words[5, 2] := '���ۣ� �t���ⶾ�����õ�������������ѡ�';
  words[5, 3] := '��� ���Y���ҷ��ɆT�����Ƅӡ�';
  words[5, 4] := '��h�� ���w��Ч�����õ�������������ѡ�';

  display_imgFromSurface(SKILL_PIC, 120, 0, 120, 0, 520, 440);
  // DrawRectangle(40, 60, 560, 315, 0, colcolor(255), 40);
  //DrawHeadPic(r, 100 + 40, 150 - 60);   �^��׃����
  ZoomPic(head_pic[r].pic, 0, 100 + 40, 150 - 60 - 60, 58, 60);
  if Rrole[r].lMagic[p] > 0 then
  begin
    Rrole[r].lMagic[p] := 1;
    str := '������';
    col1 := ColColor(255);
    col2 := ColColor(255);
  end
  else
  begin
    str := 'δ����';
    col1 := $808080;
    col2 := $808080;
  end;
  DrawShadowText(@str[1], 90 + 40, 320 - 60, col1, col2);
  str := 'ʣ�N�����c����';
  Rrole[0].AddSkillPoint := min(Rrole[0].AddSkillPoint, 10);
  DrawShadowText(@str[1], 180 + 40, 130 - 60, ColColor(0, 5), ColColor(0, 7));
  str := format('%3d', [Rrole[0].AddSkillPoint + Rrole[0].level - Rrole[1].lMagic[0] -
    Rrole[2].lMagic[0] - Rrole[3].lMagic[0] - Rrole[4].lMagic[0] - Rrole[5].lMagic[0] -
    (Rrole[1].lMagic[1] + Rrole[2].lMagic[1] + Rrole[3].lMagic[1] + Rrole[4].lMagic[1] + Rrole[5].lMagic[1]) *
    2 - (Rrole[1].lMagic[2] + Rrole[2].lMagic[2] + Rrole[3].lMagic[2] + Rrole[4].lMagic[2] + Rrole[5].lMagic[2]) *
    3 - (Rrole[1].lMagic[3] + Rrole[2].lMagic[3] + Rrole[3].lMagic[3] + Rrole[4].lMagic[3] + Rrole[5].lMagic[3]) *
    4 - (Rrole[1].lMagic[4] + Rrole[2].lMagic[4] + Rrole[3].lMagic[4] + Rrole[4].lMagic[4] +
    Rrole[5].lMagic[4]) * 5]);
  DrawShadowText(@str[1], 180 + 140 + 40, 130 - 60, ColColor(0, 5), ColColor(0, 7));

  for i := 0 to 4 do
  begin
    if Rrole[r].lMagic[i] > 0 then
    begin
      DrawPngPic(SkillPic[(r - 1) * 5 + i], i * w + x + 40, y - 60, 0);
    end
    else
    begin
      drawframe(i * w + x + 1 + 40, y + 1 - 60, 39, ColColor(0, 0));
    end;
  end;

  drawframe(p * w + x + 40, y - 60, 41, ColColor(255));
  DrawShadowText(@words[r, p, 1], 90 + 20, 230 - 60, ColColor(0, 255), ColColor(0, 255));

  str := '���輼���c����';

  DrawShadowText(@str[1], 90 + 20, 290 - 60, ColColor(0, 5), ColColor(0, 7));

  str := format('%3d', [p + 1]);
  DrawShadowText(@str[1], 90 + 20 + 140, 290 - 60, ColColor(0, 5), ColColor(0, 7));

  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);

end;

procedure DrawFrame(x, y, w: integer; color: uint32);
var
  i: integer;
begin
  for i := 0 to w do
  begin
    PutPixel(screen, x + i, y, color);
    PutPixel(screen, x + i, y + w, color);
    PutPixel(screen, x, y + i, color);
    PutPixel(screen, x + w, y + i, color);
  end;

end;

procedure PetLearnSkill(r, s: integer);
var
  menu, x, y, w: integer;
begin
  x := 100;
  y := 180;
  w := 50;
  if (Rrole[r].lMagic[s] = 0) then
  begin
    setlength(menuString, 0);
    setlength(menuString, 2);
    menuString[0] := '�W��';
    menuString[1] := 'ȡ��';


    if ((s = 0) or (Rrole[r].lMagic[s - 1] > 0)) and
      (s < (Rrole[0].AddSkillPoint + Rrole[0].level - Rrole[1].lMagic[0] - Rrole[2].lMagic[0] -
      Rrole[3].lMagic[0] - Rrole[4].lMagic[0] - Rrole[5].lMagic[0] - (Rrole[1].lMagic[1] +
      Rrole[2].lMagic[1] + Rrole[3].lMagic[1] + Rrole[4].lMagic[1] + Rrole[5].lMagic[1]) *
      2 - (Rrole[1].lMagic[2] + Rrole[2].lMagic[2] + Rrole[3].lMagic[2] + Rrole[4].lMagic[2] + Rrole[5].lMagic[2]) *
      3 - (Rrole[1].lMagic[3] + Rrole[2].lMagic[3] + Rrole[3].lMagic[3] + Rrole[4].lMagic[3] + Rrole[5].lMagic[3]) *
      4 - (Rrole[1].lMagic[4] + Rrole[2].lMagic[4] + Rrole[3].lMagic[4] + Rrole[4].lMagic[4] +
      Rrole[5].lMagic[4]) * 5)) then
      if StadySkillMenu(x + 30 + w * s, y + 18, 98) = 0 then
      begin
        Rrole[r].lMagic[s] := 1;
        // rrole[r].Attack := rrole[r].Attack - rrole[r].MagLevel[s];
      end;
  end;
  setlength(menuString, 0);
  showPetStatus(r, s);
end;

procedure ResistTheater;
var
  i: integer;
  str: array[0..9] of WideString;
begin

end;

procedure ReSetEntrance;
var
  i1, i2, i: integer;
begin
  for i1 := 0 to 479 do
    for i2 := 0 to 479 do
      Entrance[i1, i2] := -1;
  for i := 0 to length(RScene) - 1 do
  begin
    Entrance[RScene[i].MainEntranceX1, RScene[i].MainEntranceY1] := i;
    Entrance[RScene[i].MainEntranceX2, RScene[i].MainEntranceY2] := i;
  end;
end;

procedure CheckHotkey(key: cardinal);
begin
  if key = SDLK_ESCAPE then exit;

  key := key - SDLK_1;
  resetpallet(0);
  case key of
    0:
    begin
      SelectShowStatus;
    end;
    1:
    begin
      SelectShowMagic;
    end;
    2:
    begin
      newMenuItem;
    end;
    3:
    begin
      NewMenuTeammate;
    end;
    4:
    begin
      //FourPets;
      selectshowallmagic;
    end;
    5:
    begin
      NewMenuSystem;
    end;
  end;
  resetpallet;
  Redraw;
  SDL_UpdateRect2(screen, 0, 0, screen.w, screen.h);
  event.key.keysym.sym := 0;
  event.button.button := 0;
end;

procedure MenuDifficult;
var
  str: WideString;
  menu: integer;
begin
  str := '�x���y��';
  Redraw;
  DrawTextWithRect(@str[1], 275, 270, 97, ColColor($21), ColColor($23));
  setlength(menuString, 0);
  setlength(menuString, 6);
  //showmessage('');
  setlength(menuEngString, 6);
  menuString[0] := '  �O��';
  menuString[1] := '  ����';
  menuString[2] := '  ����';
  menuString[3] := '  ���y';
  menuString[4] := '  ���y';
  menuString[5] := '  �O�y';
  menu := CommonMenu(275, 300, 90, 5);
  if menu >= 0 then
  begin
    Rrole[0].difficulty := menu * 20;
  end;

end;


procedure setbuild(snum: integer);
var
  i, tmpx, tmpy: integer;
begin
  if (Rscene[snum].qizhix >= 0) and (Rscene[snum].qizhiy >= 0) and (Rscene[snum].menpai > 0) then
  begin
    SData[snum, 3, Rscene[snum].qizhiy, Rscene[snum].qizhix] := 399;
    for i := 0 to 17 do
      DData[snum, 399, i] := 0;

    DData[snum, 399, 0] := 1;
    DData[snum, 399, 1] := 399;
    DData[snum, 399, 2] := 3;
    DData[snum, 399, 5] := Rmenpai[Rscene[snum].menpai].qizhi * 2;
    DData[snum, 399, 7] := Rmenpai[Rscene[snum].menpai].qizhi * 2;
    DData[snum, 399, 6] := (Rmenpai[Rscene[snum].menpai].qizhi + 6) * 2;
    DData[snum, 399, 9] := Rscene[snum].qizhix;
    DData[snum, 399, 10] := Rscene[snum].qizhiy;
    DData[snum, 399, 15] := 0;
  end;
  if (Rscene[snum].zlwc > -1) then
  begin
    if (Rscene[snum].lwc > -1) then
    begin
      for i := 0 to Rscene[snum].lwc do
      begin
        tmpy := Rscene[snum].lwcx[i];
        tmpx := Rscene[snum].lwcy[i];
        DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 1;
        //DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 2568 ;
        DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 0;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 19;
      end;
    end;
    if (Rscene[snum].zcjg > -1) and (Rscene[snum].cjg > -1) then
    begin
      for i := 0 to Rscene[snum].cjg do
      begin
        tmpy := Rscene[snum].cjgx[i];
        tmpx := Rscene[snum].cjgy[i];
        DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 1;
        //DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 2404 ;
        DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 0;
        Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 20;
      end;
    end;
    if (Rscene[snum].bgskg = 1) then
    begin
      tmpy := Rscene[snum].bgsx;
      tmpx := Rscene[snum].bgsy;
      DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 1;
      //DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 2898 ;
      DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 0;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 21;
    end;
    if (Rscene[snum].ldlkg = 1) then
    begin
      tmpy := Rscene[snum].ldlx;
      tmpx := Rscene[snum].ldly;
      DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 1;
      //DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 2702 ;
      DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 0;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 22;
    end;
    if (Rscene[snum].bqckg = 1) then
    begin
      tmpy := Rscene[snum].bqcx;
      tmpx := Rscene[snum].bqcy;
      DData[snum, SData[snum, 3, tmpx, tmpy], 0] := 1;
      //DData[snum, SData[snum, 3, tmpx, tmpy], 5] := 2620;
      DData[snum, SData[snum, 3, tmpx, tmpy], 15] := 0;
      Ddata[snum, Sdata[snum, 3, tmpx, tmpy], 2] := 23;
    end;
  end;
end;

procedure initialmp;
var
  i: integer;
begin
  for i := 0 to length(Rmenpai) - 1 do
  begin
    Rmenpai[i].dizi := 0;
    Rmenpai[i].jvdian := 0;
  end;
  for i := 0 to length(Rrole) - 1 do
  begin
    if (Rrole[i].MenPai > 0) and (Rrole[i].Menpai < 40) then
    begin
      Inc(Rmenpai[Rrole[i].MenPai].dizi);
    end;
  end;
  for i := 0 to length(Rscene) - 1 do
  begin
    if (Rscene[i].MenPai > 0) and (Rscene[i].Menpai < 40) then
    begin
      Inc(Rmenpai[Rscene[i].MenPai].jvdian);
    end;
  end;
end;

procedure initialmpmagic;
var
  i, i1, i2: integer;

begin

  for i := 0 to 39 do
    for i1 := 0 to 399 do
      Rmpmagic[i][i1] := -1;
  //�������T�ɣ����ǵ��ӕ����书�������T���书
  for i := 0 to length(Rrole) - 1 do
  begin
    if (Rrole[i].MenPai > 0) and (Rrole[i].MenPai < 40) then
    begin
      if Rrole[i].MenPai <> Rrole[0].MenPai then
      begin
        for i1 := 0 to 29 do
        begin

          if Rrole[i].LMagic[i1] <= 0 then break;
          if Rmagic[Rrole[i].LMagic[i1]].Ismichuan > 0 then continue;
          for i2 := 0 to 399 do
          begin
            if Rmpmagic[Rrole[i].MenPai][i2] < 0 then
            begin
              if i2 < 400 then Rmpmagic[Rrole[i].MenPai][i2] := Rrole[i].LMagic[i1];
              break;
            end;
            if Rmpmagic[Rrole[i].MenPai][i2] = Rrole[i].LMagic[i1] then
            begin
              break;
            end;
          end;
        end;
      end;
    end;
  end;
  //�����T�ɣ����������ŵ��书�����T���书
  i2 := 0;
  for i := 0 to MAX_ITEM_AMOUNT - 1 do
  begin
    if Ritemlist[i].Number < 0 then break;
    if (Ritem[Ritemlist[i].Number].ItemType = 2) and (Ritem[Ritemlist[i].Number].Magic > 0) then
    begin
      Rmpmagic[Rrole[0].MenPai][i2] := Ritem[Ritemlist[i].Number].Magic;
      Inc(i2);
    end;
  end;
end;

procedure initialeventtime;
var
  i, j: integer;
begin

  for i := 0 to length(ddata) - 1 do
    for j := 0 to 399 do
      if (ddata[i, j, 11] = 0) and (ddata[i, j, 13] > 0) then
      begin
        ddata[i, j, 11] := 1 + random(ddata[i, j, 13]);
      end;
end;

procedure initialrandom;
var
  i: integer;
begin
  for i := 0 to 9 do
  begin
    rdarr1[i] := random(10000);
    rdarr2[i] := random(10000);
    rdarr3[i] := random(10000);
  end;
end;


function randomf1: integer;
var
  i: integer;
begin
  Result := rdarr1[0];
  for i := 0 to 8 do
  begin
    rdarr1[i] := rdarr1[i + 1];
  end;
  rdarr1[9] := random(10000);
end;

function randomf2: integer;
var
  i: integer;
begin
  Result := rdarr2[0];
  for i := 0 to 8 do
  begin
    rdarr2[i] := rdarr2[i + 1];
  end;
  rdarr2[9] := random(10000);
end;

function randomf3: integer;
var
  i: integer;
begin
  Result := rdarr3[0];
  for i := 0 to 8 do
  begin
    rdarr3[i] := rdarr3[i + 1];
  end;
  rdarr3[9] := random(10000);
end;

procedure initialwujishu;
var
  i, k: integer;
begin
  setlength(wujishu, length(Rmagic));
  for i := 0 to length(wujishu) - 1 do
  begin
    if (Rmagic[i].miji > 0) and (instruct_18(Rmagic[i].miji, 1, 2) = 1) then wujishu[i] := 40
    else wujishu[i] := 0;
  end;
end;

procedure initialziyuan;
var
  i1, i2: integer;
begin
  for i1 := 0 to length(Rscene) - 1 do
  begin
    if (Rscene[i1].menpai >= 0) and (Rscene[i1].menpai < 40) then
    begin
      for i2 := 0 to 9 do
      begin
        if Rscene[i1].addziyuan[i2] > 0 then
        begin
          Inc(Rmenpai[Rscene[i1].menpai].aziyuan[i2], Rscene[i1].addziyuan[i2]);
        end;
      end;
    end;
  end;
  for i1 := 0 to length(Rmenpai) - 1 do
  begin
    Dec(Rmenpai[i1].aziyuan[3], Rmenpai[i1].dizi);
  end;
end;

procedure initialWimage;
var
  i, i1, i2, grp, Count, address, len: integer;
  filename, modestr, rolestr: string;

  offset: array of integer;
begin

  filename := 'resource\wmp.pic';
  grp := FileOpen(filename, fmopenread);
  FileSeek(grp, 0, 0);
  FileRead(grp, Count, 4);
  if Count > 0 then
  begin
    setlength(RBimage, Count div 4);
    setlength(offset, Count + 1);
    offset[0] := (Count + 1) * 4;
    FileRead(grp, offset[1], 4 * Count);
    for i := 0 to Count - 1 do
    begin
      len := offset[i + 1] - offset[i] - 12;
      RBimage[i div 4][i mod 4].len := len;
      FileSeek(grp, offset[i], 0);
      FileRead(grp, RBimage[i div 4][i mod 4].pic.x, 4);
      FileRead(grp, RBimage[i div 4][i mod 4].pic.y, 4);
      FileRead(grp, RBimage[i div 4][i mod 4].pic.black, 4);

      setlength(RBimage[i div 4][i mod 4].Data, len);
      FileRead(grp, RBimage[i div 4][i mod 4].Data[0], len);
      RBimage[i div 4][i mod 4].ispic := False;

    end;
  end;
  FileClose(grp);

end;




end.