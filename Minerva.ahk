
#SingleInstance force		; Cannot have multiple instances of program
#MaxHotkeysPerInterval 200	; Won't crash if button held down
#NoTrayIcon					; App not visible in tray
#Warn						; Debuggin purposese
#NoEnv						; Avoids checking empty variables to see if they are environment variables
#Persistent					; Script will stay running after auto-execute section completes 

SetWorkingDir, %A_ScriptDir%
SetKeyDelay, 0

 

 ; ################### TEST ################### 
 
 ; ################### Begin ################### 

testarray := [] ; Creates an empty array

Loop Files, Tekster\*.txt,  ; loop through files in folder
{
    if ErrorLevel                               ; Breaks if error in fileread
    {
      MsgBox, 16, Error, Loading went wrong
      break
    }
    
    testarray.Push(A_LoopFileName)                   ; Pushes to array of strings used in HotstringMenu(PassedArray)
}
PrepareArray(testarray) ; Formatts for use in HotstringMenu(PassedArray)




; ################### HOTKEY ################### 
^Space::
HotstringMenu(testarray)
return


; ################### Functions ################### 
HotstringMenu(PassedArray)
{
  Loop % PassedArray.Length()
  {
    Menu, TheMenu, add, % PassedArray[A_Index], MenuAction ; add each field to the menu, Menuaction being a function
  }
 
  Menu, Submenu1, Add, &1 Item1, MenuHandler
  Menu, Submenu1, Add, &2 Item2, MenuHandler

  ; Create a submenu in the first menu (a right-arrow indicator). When the user selects it, the second menu is displayed.
  Menu, TheMenu, Add, &0 My Submenu, :Submenu1
  
  Menu, TheMenu, Color, c0c0c0                                  ; Hexcolor for grey
  Menu, TheMenu, Show ;, % A_ScreenWidth/2, % A_ScreenHeight/2    ; Puts the menu in the middle of screen
  Menu, TheMenu, DeleteAll                                      ; Removes it after use
}

MenuHandler:
MsgBox You selected %A_ThisMenuItem% from the menu %A_ThisMenu%.
return

 MenuAction() 
{
  TextArray := StrSplit(A_ThisMenuItem, "|")       ; Split string into two substrings
  TextOut := Trim(TextArray[2])                    ; Get second part, arrays start at 1, trim whitespace
  
  FileRead, OutputVar, Tekster\%TextOut%           ; Use string from before to finish path to file to be read
  if not ErrorLevel                                ; Only continues on errorlevel
    {
      TextOut := OutputVar                         ; Text to sendt is the content of the read file
      
      Clipboard := ""           ; Clears Clipboard
      Clipboard := TextOut      ; Puts text from file in clipboard
      Send, ^v                  ; pastes
    }
}
 
PrepareArray(PassedArray)
{
  Loop % PassedArray.Length()
  {
    Text := % "&" . A_Index . " | " . PassedArray[A_Index]  ; dot "." concatenates 
    PassedArray[A_Index] := Text                            ; adds the seperators to stuff
  } 
}
 
 ;Restart script
CapsLock & r:: 
MsgBox, 65, Restarting script, The script will restart when you click OK
IfMsgBox OK
	Reload
return

;Kill script
CapsLock & x::
	ExitApp
return



;~ ; ################### TEST ################### 

;~ #z::Menu, MyMenu, Show  ; i.e. press the Win-Z hotkey to show the menu.

