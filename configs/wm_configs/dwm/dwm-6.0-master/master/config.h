// Appearance
static const char font[]            		= "Ubuntu Mono:Regular:size=12:lcdfilter=lcddefault:hintstyle=hintnone:hinting=false:rgba=rgb:antialias=true:autohint=false";

static const char normbordercolor[] 		= "#03070B";
static const char selbordercolor[]  		= "#2e3338";

static const char normbgcolor[]     		= "#03070B";
static const char selbgcolor[]      		= "#B23450";

static const char normfgcolor[]     		= "#BDBDBD";
static const char selfgcolor[]      		= "#03070B";

static const unsigned int borderpx  		= 1;
static const unsigned int snap      		= 5;
static const unsigned int barpadding		= 4;
static const unsigned int gappx     		= 0;
static const Bool showbar           		= True;
static const Bool topbar            		= True;

// testing
static const char username[]		 		= "moeen @ workstation ";

// Tags
static const char *tags[] = { " 01 ", " 02 ", " 03 "};

static const Rule rules[] = {
	// class       instance      title     tags mask     isfloating    monitor
	{ "Gcolor2",     NULL,       NULL,       0,            True,        -1 },
	{ "Viewnior",    NULL,       NULL,       0,            True,        -1 },
	{ "Firefox",     NULL,       NULL,       1,            False,       -1 },
};

// Layouts
static const float mfact      = 0.5;
static const int nmaster      = 1;
static const Bool resizehints = False;

static const Layout layouts[] = {
	{ " []= ",  tile },
	{ " [|] ",  monocle },
	{ " [~] ",  NULL },
};

// Key Definitions
#define MODKEY Mod1Mask
#define WINKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }


// Commands
static const char *dmenucmd[] = { "dmenu_run", "-i", "-p", " Run >  ", "-h", "21", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "st", NULL };

static Key keys[] = {
	{ 0,				            XK_F5, 			spawn, 		        {.v = termcmd } },
	{ MODKEY,			            XK_p, 			spawn, 		        {.v = dmenucmd } },
	{ MODKEY,                       XK_t,           setlayout,      	{.v = &layouts[0]} },
	{ MODKEY,                       XK_m,           setlayout,      	{.v = &layouts[1]} },
	{ MODKEY,                       XK_f,     		setlayout,      	{.v = &layouts[2]} },
	{ MODKEY,                       XK_equal,       incnmaster,     	{.i = +1 } },
	{ MODKEY,                       XK_minus,       incnmaster,     	{.i = -1 } },
	{ MODKEY,                       XK_Return, 		zoom,           	{0} },
	{ MODKEY,                       XK_h,           setmfact,       	{.f = -0.02} },
	{ MODKEY,                       XK_l,           setmfact,       	{.f = +0.02} },
	{ MODKEY,			            XK_space,       togglefloating, 	{0} },
	{ MODKEY,                       XK_b,           togglebar,      	{0} },
	{ MODKEY,                       XK_Tab,         focusstack,     	{.i = +1 } },
	{ 0,		                    XK_F4,          killclient,     	{0} },
	TAGKEYS(                        XK_1,                            	0)
	TAGKEYS(                        XK_2,                            	1)
	TAGKEYS(                        XK_3,                            	2)
//	TAGKEYS(                        XK_4,                            	3)
	{ MODKEY|ShiftMask,             XK_q,           quit,           	{0} },
};

// Button Definitions
static Button buttons[] = {
	// click                event mask      button          function        argument 
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
};
