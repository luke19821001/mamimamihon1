unit kys_type;

interface

uses
  SDL,
  SDL_ttf,
  lua52,
  bass,
  inifiles;

type
  TRShowpic = record
    repeated,tp,pnum,x,y:smallint;
  end;
  TXunchou = record
    num: smallint;
    rnumlist,team: array of smallint;
  end;
  TStishi = record
    talklen, moon, day: smallint;
    talk: array of char;
  end;

  Tsavtishi = record
    num: integer;
    stishi: array of TStishi;
  end;

  Ttishi = record
    talknum, btime, dtime: smallint;
  end;

  Trenwu = record
    num, talknum, status, moon, day: smallint;
    talks: WideString;
  end;

  pyword = record
    hanzi: array[0..3] of char;
    pinyin: array[0..8] of char;
  end;

  TPosition = record
    x, y: integer;
  end;

  TRect = record
    x, y, w, h: integer;
  end;

  TPic = record
    x, y, black: integer;
    pic: PSDL_Surface;
  end;

  TPicdata = record
    ispic: boolean;
    len: integer;
    Data: array of byte;
    pic: Tpic;
  end;

  TItemList = record
    Number, Amount: Smallint;
  end;

  TCallType = (Element, Address);

  Ttexiao = record
    x, y: smallint;
  end;
  Tshopitem = record
    inum, amount: smallint;
  end;
  //�����������;����������÷�ʽ�����ձ������ã����ն�������������

  TRole = record
    case TCallType of
      Element: (ListNum, HeadNum, IncLife, fuyuan: Smallint;
        Name, Nick: array[0..9] of char;
        Sexual, Level: Smallint;
        Exp: uint16; //17
        CurrentHP, MaxHP, Hurt, Poision, PhyPower: Smallint; //22
        ExpForItem: uint16;
        Equip: array[0..4] of Smallint;
        Gongti: smallint;
        TeamState: smallint; //30
        Angry: smallint;
        israndomed: smallint;
        Moveable, AddSkillPoint, PetAmount: smallint;
        Impression, dtime, difficulty: smallint;
        zhongcheng: smallint;
        rehurt: smallint; //40
        MPType, CurrentMP, MaxMP: Smallint;
        Attack, Speed, Defence, Medcine, UsePoi, MedPoi, DefPoi, Fist, Sword, Knife, Unusual, HidWeapon: Smallint;
        Knowledge, Ethics, AttPoi, AttTwice, Repute, Aptitude, PracticeBook: Smallint;
        ExpForBook: uint16; //63
        xiangxing, jiaoqing, Rtype, swq, pdq, xxq, jqq, MenPai, shifu, scsx, bssx: smallint; //74
        Choushi: array[0..1] of smallint;
        weizhi, nweizhi, nfangxiang, unuse0, lwq, msq, ldq, qtq, lsweizhi, lsnweizhi, lsfangxiang: smallint;
        Sx, Sy, unuse3, unuse4, unuse5, unuse6, unuse7, unuse8, unuse9, unuse10: smallint; //97
        LMagic, MagLevel: array[0..29] of smallint; //157
        TakingItem, TakingItemAmount: array[0..3] of smallint;
        jhMagic: array[0..9] of smallint; //175
        LZhaoshi: array[0..29] of smallint;
        MRevent: smallint;
        AllEvent: array[0..8] of smallint;
        leaveevent: smallint);
      Address: (Data: array[0..215] of Smallint);
  end;

  TItem = record
    case TCallType of
      Element: (ListNum: Smallint;
        Name: array[0..19] of char;
        ExpOfMagic: smallint;
        SetNum, BattleEffect, WineEffect, needSex, rehurt: smallint;
        unuse: array[0..3] of smallint; //21
        Introduction: array[0..29] of char; //36
        Magic, AmiNum, User, EquipType, ShowIntro, ItemType, inventory, price, EventNum: Smallint; //45
        AddCurrentHP, AddMaxHP, AddPoi, AddPhyPower, ChangeMPType, AddCurrentMP, AddMaxMP: Smallint;
        AddAttack, AddSpeed, AddDefence, AddMedcine, AddUsePoi, AddMedPoi, AddDefPoi: Smallint; //59
        AddFist, AddSword, AddKnife, AddUnusual, AddHidWeapon, AddKnowledge, AddEthics,
        AddAttTwice, AddAttPoi: Smallint; //68
        OnlyPracRole, NeedMPType, NeedMP, NeedAttack, NeedSpeed, NeedUsePoi, NeedMedcine, NeedMedPoi: Smallint; //76
        NeedFist, NeedSword, NeedKnife, NeedUnusual, NeedHidWeapon, NeedAptitude: Smallint; //82
        NeedExp, Count, Rate: Smallint; //85
        NeedItem, NeedMatAmount: array[0..4] of Smallint);
      Address: (Data: array[0..94] of Smallint);
  end;

  TScene = record
    case TCallType of
      Element: (ListNum: Smallint;
        Name: array[0..9] of char;
        ExitMusic, EntranceMusic: Smallint;
        Pallet, EnCondition: Smallint; //10
        MainEntranceY1, MainEntranceX1, MainEntranceY2, MainEntranceX2: Smallint;
        EntranceY, EntranceX: Smallint;
        ExitY, ExitX: array[0..2] of Smallint; //22
        Mapmode, unuse, menpai, inbattle, zlwc, lwc, zcjg, cjg: Smallint; //30
        lwcx, lwcy, cjgx, cjgy: array[0..4] of smallint; //50
        bgskg, bgsx, bgsy, ldlkg, ldlx, ldly, bqckg, bqcx, bqcy, qizhix, qizhiy, ldjd, dzjd, fyjc, fyss: smallint; //65
        addziyuan: array[0..9] of smallint;
        lianjie: array[0..9] of smallint);
      Address: (Data: array[0..84] of Smallint);
  end;

  TMagic = record
    case TCallType of
      Element: (ListNum: Smallint;
        Name: array[0..9] of char;
        useness, miji, NeedHP, MinStep, bigami, EventNum: Smallint;
        SoundNum, MagicType, AmiNum, HurtType, AttAreaType, NeedMP, Poision: Smallint;
        MinHurt, MaxHurt, HurtModulus, AttackModulus, MPModulus, SpeedModulus, WeaponModulus,
        Ismichuan, AddMpScale, AddHpScale: Smallint;
        MoveDistance, AttDistance: array[0..9] of Smallint;
        AddHP, AddMP, AddAtt, AddDef, AddSpd: array[0..2] of smallint;
        MinPeg, MaxPeg, MinInjury, MaxInjury, AddMedcine, AddUsePoi, AddMedPoi, AddDefPoi: Smallint;
        AddFist, AddSword, AddKnife, AddUnusual, AddHidWeapon, BattleState: smallint;
        NeedExp: array[0..2] of smallint;
        MaxLevel: smallint;
        Introduction: array[0..59] of char;
        zhaoshi: array[0..4] of smallint;
        teshu: array[0..9] of smallint;
        teshumod: array[0..9] of smallint);
      Address: (Data: array[0..136] of Smallint);
  end;

  TShop = record
    case TCallType of
      Element: (shopItem: array[0..17] of Tshopitem;

      );
      Address: (Data: array[0..35] of Smallint);
  end;

  Tzhaoshi = record
    case TCallType of
      Element: (daihao, congshu, shunwei: Smallint;
        Name: array[0..19] of char;
        ygongji, gongji, yfangyu, fangyu: Smallint;
        shuoming: array[0..45] of char; //40
        texiao: array[0..23] of Ttexiao); //88
      Address: (Data: array[0..87] of Smallint);
  end;

  Tmenpai = record
    case TCallType of
      Element: (num: Smallint;
        Name: array[0..19] of char;
        jvdian, zongduo, zmr, dizi, shengwang, shane: Smallint; //17
        ziyuan: array[0..9] of Smallint;
        aziyuan: array[0..9] of Smallint;
        neigong: array[0..19] of Smallint; //57
        guanxi: array[0..39] of Smallint; //97
        zhiwu: array[0..9] of smallint; //107
        kzq, dzq, czsd, qizhi, mdizigrp, mdizipic, fdizigrp, fdizipic, sexy, identity, endevent: smallint);
      Address: (Data: array[0..117] of Smallint);
  end;

  TBattleRole = record
    case TCallType of
      Element: (rnum, Team, Y, X, Face, Dead, Step, Acted: Smallint;
        Pic, ShowNumber, showgongji, showfangyu, szhaoshi, Progress, round, speed: Smallint; //16
        ExpGot, Auto, Show, Wait, frozen, killed, Knowledge, LifeAdd, Zhuanzhu, pozhao, wanfang: Smallint; //25
        //AddAtt, AddDef, AddSpd, addfenfa,addjingzhun,AddStep, AddDodge,addtime: Smallint; //32 lukeɾ������Ϊÿ�غ�˥��
        zhuangtai: array[0..13] of smallint;
        lzhuangtai: array[0..9] of smallint);
      Address: (Data: array[0..50] of Smallint);
  end;

  //ս������, ��war.sta�ļ���ӳ��
  TWarSta = record
    case TcallType of
      Element: (BattleNum: smallint;
        BattleName: array[0..9] of byte;
        battlemap, exp, battlemusic: smallint; //9
        mate, automate, mate_x, mate_y: array[0..11] of smallint; //57
        enemy, enemy_x, enemy_y: array[0..29] of smallint; //147
        BoutEvent, OperationEvent: smallint;
        GetKongfu: array[0..2] of smallint;
        GetItems: array[0..2] of smallint; //155
        GetMoney: smallint);
      Address: (Data: array[0..155] of smallint;)
  end;

  //����ս����Ч
  TBRoleColor = record
    case tcalltype of
      Element: (green, red, yellow, blue, gray: integer;)
  end;
  //�T�ɑ𔵓�

  TBTRole = record
    rnum, snum, isin, mag: smallint;
  end;
  TBTeam = record
    RoleArr: array of TBTRole;
  end;
  TMpBdata = record
    id: smallint;
    key: smallint;
    daytime: integer;
    attmp, defmp, snum: smallint;
    BTeam: array[0..3] of TBTeam;
  end;
  Tscenediaodu = record
    //������ţ����ڱ��ɾݵ�������ϵ������ɣ���ϵ������Ŀ��ݵ�
    snum, Count, dmenpai, dguanxi, dsnum: smallint;
  end;

  TMpdiaodu = record
    mpnum, scount, rcount: smallint; //���ɺţ�ӵ�оݵ���+1��������+1
    sce: array of tscenediaodu; //����
    rnum, isin: array of smallint; //��������ţ��Ƿ����

  end;



  TRccRoleArr = record
    Rnum, snum, DNum, Dtime: smallint; //���ճ�������
  end;
  TRccRole = record
    Count: smallint;
    adds: array of TRccRoleArr;
  end;
  TShowBWord = record
    sign: smallint; //0�����������㹥��,1������ʽ,2����,3���,4��ŭ,5ս��,6����ս��
    rnum: array[0..7] of smallint;
    col1, col2, x, y: array[0..7] of smallint;
    words: array[0..7] of WideString;
    starttime: array[0..7] of uint32;
    delay: array[0..7] of smallint;
    Sx, Sy: array[0..7] of single;
  end;

  //�����Z�

  TAllBTalk = record
    talk: array[0..1] of array[0..2] of array[0..9] of array[0..9] of WideString;
    etalk: array[0..2] of array[0..9] of WideString;
  end;


var
  teststr: string;
  HW: integer = 0;
  AppPath: string; //�����·��
  CHINESE_FONT: PAnsiChar = 'resource\Chinese.ttf';
  CHINESE_FONT_SIZE: integer = 20;
  ENGLISH_FONT: PAnsiChar = 'resource\English.ttf';
  ENGLISH_FONT_SIZE: integer = 18;
  CHINESE_FONT_SONGTI: PAnsiChar = 'resource\Chinese.ttc';
  CHINESE_FONT2_SIZE: integer = 18;
  ENGLISH_FONT2_SIZE: integer = 16;
  CENTER_X: integer = 320;
  CENTER_Y: integer = 220;
  //�ļ�������
  KDEF_IDX: PAnsiChar = 'resource\kdef.idx';
  KDEF_GRP: PAnsiChar = 'resource\kdef.grp';
  TALK_IDX: PAnsiChar = 'resource\talk.idx';
  TALK_GRP: PAnsiChar = 'resource\talk.grp';
  T1_IDX: PAnsiChar = 'resource\t1.idx';
  T1_GRP: PAnsiChar = 'resource\t1.grp';
  NAME_IDX: PAnsiChar = 'resource\name.idx';
  NAME_GRP: PAnsiChar = 'resource\name.grp';
  ITEMS_file: PAnsiChar = 'resource\items.Pic';
  HEADS_file: PAnsiChar = 'resource\heads.Pic';
  BackGround_file: PAnsiChar = 'resource\BackGround.Pic';
  GAME_file: PAnsiChar = 'resource\Game.Pic';
  MOVIE_file: PAnsiChar = 'resource\Begin.pic';
  Scene_file: PAnsiChar = 'resource\Scene.pic';
  Skill_file: PAnsiChar = 'resource\Skill.pic';
  //ʹ��50ָ��ʱ�Ƿ��Զ�ˢ����Ļ��0Ϊ�Զ�ˢ��
  AutoRefresh: integer = 0;

  //����Ϊ������, ���ж���������ini�ļ��ı�
  ITEM_BEGIN_PIC: integer = 3501; //��Ʒ��ʼͼƬ
  BEGIN_EVENT: integer = 691; //��ʼ�¼�
  BEGIN_Scene: integer = 70; //��ʼ����
  BEGIN_Sx: integer = 20; //��ʼ����(�����е�x, y����Ϸ�����෴��, �������ڵ���������)
  BEGIN_Sy: integer = 19; //��ʼ����
  SOFTSTAR_BEGIN_TALK: integer = 2547; //�������޶Ի��Ŀ�ʼ���
  SOFTSTAR_NUM_TALK: integer = 18; //�������޵ĶԻ�����
  MAX_PHYSICAL_POWER: integer = 100; //�������
  MONEY_ID: integer = 0; //��������Ʒ����
  COMPASS_ID: integer = 1; //���̵���Ʒ����
  MAP_ID: integer = 401; //��ͼ����Ʒ����
  BEGIN_LEAVE_EVENT: integer = 950; //��ʼ����¼�
  BEGIN_BATTLE_ROLE_PIC: integer = 2553; //������ʼս����ͼ
  MAX_LEVEL: integer = 30; //���ȼ�
  MAX_WEAPON_MATCH: integer = 7; //'�书�������'��ϵ�����
  MIN_KNOWLEDGE: integer = 0; //�����Ч��ѧ��ʶ
  MAX_ITEM_AMOUNT: integer = 300; //�����Ʒ����
  MAX_HP: integer = 999; //�������
  MAX_MP: integer = 999; //����ڹ�
  Showanimation: integer = 0;
  MaxProList: array[43..58] of integer = (200, 200, 200, 200, 200, 200, 200, 200, 200, 200,
    200, 200, 100, 100, 100, 1);
  //��󹥻�ֵ~������һ���ֵ
  SoundVolume: integer = 32;
  LIFE_HURT: integer = 100; //�˺�ֵ����
  Debug: integer = 0;
  //����3������ʵ�ʲ�δʹ��, ������ini�ļ�ָ��
  BEGIN_WALKPIC: integer = 5000; //��ʼ��������ͼ(��δʹ��)
  teamcount: smallint = 0;
  Warsta: Twarsta;
  MPic, SPic: array of byte; //ȥ��WPM
  MIdx, SIdx, WIdx: array of integer;
  // HPic: array[0..2000000] of byte;
  // HIdx: array[0..500] of integer;
  //����Ϊ��ͼ�����ݼ�����
  Earth, Surface, Building, BuildX, BuildY, Entrance: array[0..479, 0..479] of smallint;
  //����ͼ����
  ACol: array[0..768] of byte;
  Col: array[0..3] of array[0..767] of byte;
  //Ĭ�ϵ�ɫ������
  InShip, Useless1, Mx, My, Sx, Sy, MFace, ShipX, ShipY, ShipFace: Smallint;
  TeamList: array[0..5] of Smallint;
  RItemList: array of TItemList;
  isbattle: boolean = False;
  MStep, Still: integer;
  //����ͼ����, ����, ����, �Ƿ��ھ�ֹ
  Cx, Cy, SFace, SStep: integer;
  //����������, �������ĵ�, ����, ����
  CurScene, CurItem, CurEvent, CurMagic, CurrentBattle, Where: integer;
  //��ǰ����, �¼�(�ڳ����е��¼���), ʹ����Ʒ, ս��
  //where: 0-����ͼ, 1-����, 2-ս��, 3-��ͷ����
  SaveNum: integer;
  //�浵��, δʹ��
  Rrole: array of TRole;
  Ritem: array of TItem;
  RScene: array of TScene;
  Rmagic: array of TMagic;
  RShop: array of TShop;
  Rzhaoshi: array of Tzhaoshi;
  Rmenpai: array of Tmenpai;
  //R�ļ�����, ��Զ����ԭ������
  ItemList: array[0..500] of smallint;
  SData: array of array[0..5, 0..63, 0..63] of smallint;
  DData: array of array[0..399, 0..17] of smallint;
  //S, D�ļ�����
  //Scene1, SData[CurScene, 1, , Scene3, Scene4, Scene5, Scene6, Scene7, Scene8: array[0..63, 0..63] of smallint;
  //��ǰ��������
  //0-����, 1-����, 2-��Ʒ, 3-�¼�, 4-�����߶�, 5-��Ʒ�߶�
  SceneImg: array[0..2303, 0..1401] of uint32;
  MaskArray: array[0..2303, 0..1401] of smallint;
  ScenePic: array of Tpic;
  build: PSDL_Surface;
  //������ͼ��ӳ��. ʵʱ�ػ�����Ч�ʽϵ�, ����������ӳ��, ��Ҫʱ����
  //SceneD: array[0..199, 0..10] of smallint;
  //��ǰ�����¼�
  BFieldImg: array[0..2303, 0..1401] of uint32;
  //ս��ͼ��ӳ��
  BField: array[0..7, 0..63, 0..63] of smallint;
  //ս������
  //0-����, 1-����, 2-����, 3-�ɷ�ѡ��, 4-������Χ, 5, 6 ,7-δʹ��
  Brole: array[0..41] of TBattleRole;
  //ս����������
  //0-�������, 1-����, 2, 3-����, 4-��Է���, 5-�Ƿ�����ս��, 6-���ƶ�����, 7-�Ƿ��ж����,
  //8-��ͼ(δʹ��), 9-ͷ����ʾ����, 10, 11, 12-δʹ��, 13-�ѻ�þ���, 14-�Ƿ��Զ�ս��
  BRoleAmount: integer;
  //ս����������
  Bx, By, Ax, Ay, TBx, TBy, Tstep: integer;
  //��ǰ��������, ѡ��Ŀ�������
  Bstatus: integer;
  //ս��״̬, 0-����, 1-ʤ��, 2-ʧ��
  BshowBWord: Tshowbword; //ս������ʾ������
  maxspeed: integer;
  //LeaveList: array[0..99] of smallint;
  //EffectList: array[0..199] of smallint;
  LevelUpList: array[0..99] of smallint;
  //MatchList: array[0..99, 0..2] of smallint;
  //�����б�, ǰ�ĸ����ļ�����
  Water: integer;
  //�Ƿ�ˮ��
  snow: integer;
  //�Ƿ�Ʈѩ
  rain: integer;
  //�Ƿ�����
  fog: boolean;
  //�Ƿ�����
  showblackscreen: boolean;
  //�Ƿ�ɽ��
  snowalpha: array[0..439] of array[0..639] of byte;
  BattleMode: integer;
  FULLSCREEN: integer;
  //�Ƿ�ȫ��
  SIMPLE: integer = 0;

  {BEGIN_PIC, Maker_Pic,  DEATH_PIC,
  MENUESC_PIC, MenuescBack_PIC, MAGIC_PIC, STATE_PIC,SYSTEM_PIC, MAP_PIC, SHUPU_PIC, TEAMMATE_PIC,MENUITEM_PIC,
  MPLINE_PIC,TILILINE_PIC,HPLINE_PIC,HUIKUANG_PIC,HUANGKUANG_PIC,BIAOTIKUANG_PIC,HUIKUANG2_PIC,HUANGKUANG2_PIC,
  DIZI_PIC,GONGJI_PIC,JIANSHE_PIC,MPNEIGONG_PIC,MPZHUANGTAI_PIC,RENMING_PIC,SONGLI_PIC,YIDONG_PIC,
  battlepic,MATESIGN_PIC,SELECTEDMATE_PIC, ENEMYSIGN_PIC, SELECTEDENEMY_PIC,
  PROGRESS_PIC,NowPROGRESS_PIC, angryprogress_pic, angrycollect_pic, angryfull_pic: Tpic; }

  STATE_PIC, BEGIN_PIC, MAGIC_PIC, SYSTEM_PIC, MAP_PIC, SKILL_PIC, DIZI_PIC, GONGJI_PIC,
  JIANSHE_PIC, MPNEIGONG_PIC, MPZHUANGTAI_PIC, RENMING_PIC, SONGLI_PIC, YIDONG_PIC: Tpic;
  MENUITEM_PIC, MENUESC_PIC, MenuescBack_PIC, battlepic, TEAMMATE_PIC: Tpic;
  PROGRESS_PIC, MATESIGN_PIC, SELECTEDMATE_PIC, ENEMYSIGN_PIC, SELECTEDENEMY_PIC, DEATH_PIC: Tpic;
  NowPROGRESS_PIC, angryprogress_pic, angrycollect_pic, angryfull_pic, Maker_Pic: Tpic;

  Head_Pic: array of Tpic;
  SkillPIC: array of Tpic;

  //option exp in snake
  snake: array of tposition;
  RANX, RANY: integer;
  dest: integer;


  ITEM_PIC: array of Tpic;


  screen, RealScreen, prescreen: PSDL_Surface;
  //������, ʵ�ʻ���, Ԥ������


  event: TSDL_Event;
  //�¼�
  Font, Font2, EngFont, EngFont2: PTTF_Font;
  TextColor: TSDL_Color;
  Text: PSDL_Surface;
  //����

  menuString, menuEngString, MenuString2, MenuEngString2: array of WideString;

  Bzhaoshi: smallint;
  //ѡ����ʹ�õ��ַ���

  x50: array[-$8000..$7FFF] of smallint;
  //����ָ��50��ʹ�õı���
  lua_script: Plua_State;
  //��Ϸ���С��Ϸ�õ�������
  GameArray: array of array of integer;
  GameSpeed: integer = 10;

  //VOLUMEWAV: integer; //�������� ��Ч���� �Ƿ�����3D��Ч
  SOUND3D: integer;
  SoundFlag: longword;
  Music: array[0..999] of HSTREAM;
  ESound: array[0..999] of HSAMPLE;
  ASound: array[0..999] of HSAMPLE;

  MusicVolume: integer = 64;
  StartMusic: integer;
  ExitSceneMusicNum: integer; //�뿪����������
  nowmusic: integer = -1; //���ڲ��ŵ�����

  //Music: PMix_music;
  //ESound: PMix_Chunk;
  //ASound: PMix_Chunk;

  //ս���ñ���
  CurBRole: integer; //��ǰս������
  ShowMR: boolean = True;
  now2: uint32 = 0;
  time: smallint = -1;
  timeevent: smallint = -1;
  //��ʱ����ʱ�¼�
  rs: integer = 0;
  //����¼�
  RandomEvent: smallint = 0;
  randomcount: integer = 0;
  Kys_ini: TIniFile;
  Effect: integer;
  HighLight: boolean = False; //����

  //�ݴ������书
  magicTemp: array[0..29] of smallint;
  magicLvTemp: array[0..29] of smallint;

  green: integer = 0;
  red: integer = 0;
  yellow: integer = 0;
  blue: integer = 0;
  gray: integer = 0;

  versionstr: WideString = ' v 0.50 DEBUG   '; //�汾��
  FWay: array[0..479, 0..479] of smallint;
  linex, liney: array[0..480 * 480 - 1] of smallint;
  nowstep: integer;
  SetNum: array[1..5] of array[0..3] of smallint;

  //����
  wdate: array[0..4] of smallint;

  //���Y�Ƿ��܉�@���书�c��
  isattack: boolean;


  //�T���书
  Rmpmagic: array[0..39] of array[0..399] of smallint;
  M_IDX: array[0..10] of integer; //M�ļ�ָ�
  songli: array of array[0..2] of integer;
  rdarr1, rdarr2, rdarr3: array[0..9] of smallint;
  Rtishi: array of Ttishi;
  Rrenwu: array of Trenwu;
  RStishi: TSavtishi; //������ʾ����
  //�似��
  wujishu: array of smallint;
  //���⿂��
  jiqicount: integer;
  //�Nʿ
  tipsx, tipsy: integer;
  tipsstring: WideString;
  tipsarr: array of WideString;
  Jxarr: array of WideString;
  MpBdata: array[0..19] of TMpBdata;
  mpdiaodu: array of tmpdiaodu;
  //���Y����������ֵ
  MaxFist, MaxSword, MaxKnife, MaxUnusual,MaxMedcine: integer;
  S_eventx: integer = -1; //�������ƾ������¼���ͣ��ʱ�����ظ�����
  S_eventy: integer = -1;
  totalprice: integer; //�̵�ʹ�ã����r
  RBimage: array of array[0..3] of Tpicdata; //ս��ͼ�ɳ��ж�����

  //����
  fuli: smallint = 0;
  //������ʩ��Ա������������
  SceAnpai: array of array[0..12] of smallint;
  RccRole: TRccRole;

  //�����Z�
  allbtalk: TallBTalk;


  //��Ƶ���ڵ�flag
  screenFlag: uint32;

  //�Ƿ�ʹ��opengl, �Ƿ�ƽ��, ��Ļ��С
  GLHR: integer = 0;
  SMOOTH: integer = 0;
  RESOLUTIONX, RESOLUTIONY: integer;

  //�˳���Ϸ�����ʷ�ʽ
  EXIT_GAME: integer;
  AskingQuit: boolean;
  //�������ﵽ��һ��ս��
  xunchou:TXunchou;
  //50 41ָ���ǿ
  RShowpic:TRShowpic;


const
  RMask: uint32 = $FF0000;
  GMask: uint32 = $FF00;
  BMask: uint32 = $FF;
  AMask: uint32 = $FF000000;

implementation

end.