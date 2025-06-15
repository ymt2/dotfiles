import Data.Maybe (fromJust, isJust)
import System.Directory (findExecutable)
import System.IO

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops -- For support wmctrl
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)

superMask = mod4Mask
altMask = mod1Mask

main :: IO()
main = do
  myTerminal' <- myTerminal

  xmobar <- spawnPipe "xmobar"
  xmonad $ docks $ ewmh $ def
    { terminal    = myTerminal'
    , layoutHook  = myLayoutHook
    , manageHook  = myManageHook
    , logHook     = myLogHook xmobar
    , startupHook = myStartupHook
    }
    `additionalKeysP`
    [ ("<Print>", spawn "xfce4-screenshooter")
    , ("C-<Print>", spawn "xfce4-screenshooter -r")
    ]
    `removeKeysP`
    [ "M-m" -- To keep alive spacemacs leader key
    ]

firstInstalled cmds = fromJust <$> firstM isInstalled cmds
  where
    firstM f [] = return Nothing
    firstM f (m:ms) = do
      ok <- f m
      if ok then
        return $ Just m
      else
        firstM f ms
    isInstalled cmd = isJust <$> findExecutable cmd

myTerminal = firstInstalled
  [ "kitty"
  , "urxvt"
  , "xterm"
  ]

myLayoutHook = avoidStruts $ layoutHook def

myManageHook = manageDocks <+> manageHook def

myLogHook h = dynamicLogWithPP xmobarPP
  { ppOutput = hPutStrLn h
  , ppUrgent = xmobarColor "yellow" "red" . xmobarStrip
  , ppTitle  = xmobarColor "#ff7f14" "" . shorten 50
  }

myStartupHook = do
  setWMName "LG3D" -- For support IntelliJ idea and more.
  spawnOnce "dropbox &"
  spawnOnce "xfce4-clipman &"
  spawnOnce "nitrogen --restore &"
