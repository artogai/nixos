import qualified Codec.Binary.UTF8.String     as UTF8
import qualified DBus                         as D
import qualified DBus.Client                  as D
import qualified Data.Map                     as M
import qualified XMonad.Util.Hacks            as Hacks
import           Data.Monoid
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit                  (exitSuccess)
import           System.IO
import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Layout.NoBorders
import qualified XMonad.StackSet              as W
import           XMonad.Util.EZConfig         (additionalKeysP)
import           XMonad.Util.Run
import           XMonad.Util.SpawnOnce

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "alacritty"

-- The preferred launcher
--
myAppLauncher = "rofi -modi drun,ssh,window -show drun -show-icons"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
-- mod4Mask is the `super` key (Win key)
--
myModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor = "#dddddd"

myFocusedBorderColor = "#ff0000"

---------- My additional keys --------
additionalKeys :: [(String, X ())]
additionalKeys =
  [ -- Run my bar
    ("M-p", spawn myAppLauncher),

    -- Lock screen
    ("M-<Esc>", spawn "betterlockscreen -l dim"),

    -- Hide bar
    ("M-b", sendMessage ToggleStruts),

    -- Fn Keys
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +1.5%"),
    ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@  -1.5%"),
    ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
    ("<XF86MonBrightnessUp>", spawn "light -A 5"),
    ("<XF86MonBrightnessDown>", spawn "light -U 5"),

    -- Help
    ("M-S-/", spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
  ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts (Mirror tiled ||| Full ||| tiled)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2

    -- Percent of screen to increment by when resizing panes
    delta = 3 / 100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook =
  composeAll
    [ className =? "MPlayer" --> doFloat,
      className =? "Gimp" --> doFloat,
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook

--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
-- Check ./xmonad/xmonad-session-rc for Ubuntu install workaround (add the commands to there also)
myStartupHook = return ()

------------------------------------------------------------------------
-- Polybar bindings
mkDbusClient :: IO D.Client
mkDbusClient = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.log") opts
  return dbus
  where
    opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str =
  let opath = D.objectPath_ "/org/xmonad/Log"
      iname = D.interfaceName_ "org.xmonad.Log"
      mname = D.memberName_ "Update"
      signal = D.signal opath iname mname
      body = [D.toVariant $ UTF8.decodeString str]
   in D.emit dbus $ signal {D.signalBody = body}

polybarHook :: D.Client -> PP
polybarHook dbus =
  let wrapper c s
        | s /= "NSP" = wrap ("%{F" <> c <> "} ") " %{F-}" s
        | otherwise = mempty
      blue = "#2E9AFE"
      gray = "#7F7F7F"
      orange = "#ea4300"
      purple = "#9058c7"
      red = "#722222"
   in def
        { ppOutput = dbusOutput dbus,
          ppCurrent = wrapper blue,
          ppVisible = wrapper gray,
          ppUrgent = wrapper orange,
          ppHidden = wrapper gray,
          ppHiddenNoWindows = wrapper red,
          ppTitle = shorten 100 . wrapper purple
        }

myPolybarLogHook dbus = myLogHook <+> dynamicLogWithPP (polybarHook dbus)

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  dbus <- mkDbusClient
  xmonad
    $ ewmhFullscreen
    $ Hacks.javaHack
    $ ewmh
      ( docks
          def
            { -- simple stuff
              terminal = myTerminal,
              focusFollowsMouse = myFocusFollowsMouse,
              clickJustFocuses = myClickJustFocuses,
              borderWidth = myBorderWidth,
              modMask = myModMask,
              workspaces = myWorkspaces,
              normalBorderColor = myNormalBorderColor,
              focusedBorderColor = myFocusedBorderColor,
              -- hooks, layouts
              layoutHook = smartBorders myLayout,
              manageHook = myManageHook,
              handleEventHook = Hacks.windowedFullscreenFixEventHook,
              logHook = myPolybarLogHook dbus,
              startupHook = myStartupHook
            }
          `additionalKeysP` additionalKeys
      )

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help =
  unlines
    [ "The default modifier key is 'alt'. Default keybindings:",
      "",
      "-- launching and killing programs",
      "mod-Shift-Enter  Launch xterminal",
      "mod-p            Launch dmenu",
      "mod-Shift-p      Launch gmrun",
      "mod-Shift-c      Close/kill the focused window",
      "mod-Space        Rotate through the available layout algorithms",
      "mod-Shift-Space  Reset the layouts on the current workSpace to default",
      "mod-n            Resize/refresh viewed windows to the correct size",
      "",
      "-- move focus up or down the window stack",
      "mod-Tab        Move focus to the next window",
      "mod-Shift-Tab  Move focus to the previous window",
      "mod-j          Move focus to the next window",
      "mod-k          Move focus to the previous window",
      "mod-m          Move focus to the master window",
      "",
      "-- modifying the window order",
      "mod-Return   Swap the focused window and the master window",
      "mod-Shift-j  Swap the focused window with the next window",
      "mod-Shift-k  Swap the focused window with the previous window",
      "",
      "-- resizing the master/slave ratio",
      "mod-h  Shrink the master area",
      "mod-l  Expand the master area",
      "",
      "-- floating layer support",
      "mod-t  Push window back into tiling; unfloat and re-tile it",
      "",
      "-- increase or decrease number of windows in the master area",
      "mod-comma  (mod-,)   Increment the number of windows in the master area",
      "mod-period (mod-.)   Deincrement the number of windows in the master area",
      "",
      "-- quit, or restart",
      "mod-Shift-q  Quit xmonad",
      "mod-q        Restart xmonad",
      "mod-[1..9]   Switch to workSpace N",
      "",
      "-- Workspaces & screens",
      "mod-Shift-[1..9]   Move client to workspace N",
      "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
      "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
      "",
      "-- Mouse bindings: default actions bound to mouse events",
      "mod-button1  Set the window to floating mode and move by dragging",
      "mod-button2  Raise the window to the top of the stack",
      "mod-button3  Set the window to floating mode and resize by dragging"
    ]
