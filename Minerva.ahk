#SingleInstance force       ; Cannot have multiple instances of program
#MaxHotkeysPerInterval 200  ; Won't crash if button held down
#NoTrayIcon                 ; App not visible in tray
;#Warn                       ; Debuggin purposese
#NoEnv                      ; Avoids checking empty variables to see if they are environment variables
#Persistent                 ; Script will stay running after auto-execute section completes 

SetWorkingDir, %A_ScriptDir%
SetKeyDelay, 0


; ################### Begin ################### 

; Stores all folderElements
allElements := []




; Now loop through every folder (and subfolder) in Texts and find the .txt files
Loop Files, %A_ScriptDir%\*.*, D R
{
    ; Stores all files that are inside this folder
    temp := []
    ; Get every file inside this folder
    Loop, Files, %A_LoopFileFullPath%\*.txt
    {
        ; Add the file to the array
        ;~ temp.Push(A_LoopFileFullPath)
        temp.Push(A_LoopFileName)
    }

    ; Create a new folderElement
    ;~ element := new folderElement(A_LoopFileFullPath, temp)
    element := new folderElement(A_LoopFileName, temp)
    ; Prepare the array
    element.prepareArray()
    ; Check if the element has files stored, if yes add it to the array
    If (element.hasFiles())
    {
        ; Pushes to the main array
        allElements.Push(element)
    }
}


; ################### HOTKEY ################### 
^Space::
    HotstringMenu(allElements)
Return

;Restart script
CapsLock & r:: 
    MsgBox, 65, Restarting script, The script will restart when you click OK
    IfMsgBox OK
    Reload
Return

;Kill script
CapsLock & x::
ExitApp


; ################### Functions ################### 


HotstringMenu(PassedArray)
{
    Loop % PassedArray.Length()
    {
        ; The current item
        tempItem := PassedArray[A_Index]

        ; Store the current index for the submenu
        loopIndex := A_Index
        
        ; Get the name of the current submenu
        TESTE := tempItem.folderName

        ; Create a submenu for each element
        Loop, % tempItem.filesInFolder.Length()
        {
            Menu, %TESTE%, Add, % tempItem.filesInFolder[A_Index], MenuAction
        }
        
        
        folderName := % "&" . LoopIndex " | " . tempItem.folderName  ; Grants the shortcut dot "." concatenates 
       
        ; Add each folderName to the menu
        Menu, TheMenu, Add, % folderName, :%TESTE%
    }

    Menu, TheMenu, Show ;, % A_ScreenWidth/2, % A_ScreenHeight/2    ; Puts the menu in the middle of screen
    Menu, TheMenu, DeleteAll                                      ; Removes it after use
}


MenuAction() 
{
    TextArray := StrSplit(A_ThisMenuItem, "|")       ; Split string into two substrings
    TextOut := Trim(TextArray[2])                    ; Get second part, arrays start at 1, trim whitespace

    FileRead, OutputVar, %A_ThisMenu%\%TextOut%           ; Use string from before to finish path to file to be read
    if (!ErrorLevel)                                ; Only continues on errorlevel
    {
        TextOut := OutputVar                         ; Text to sendt is the content of the read file

        Clipboard := ""           ; Clears Clipboard
        Clipboard := TextOut      ; Puts text from file in clipboard
        Sleep, 350
        Send, ^v                  ; pastes
    }
}




; Stores a folder path with all files inside (not recursive)
class FolderElement
{
    ; The name of the folder
    folderName := ""
   
    ; Stores every file inside the folder
    filesInFolder := []

    ; Constructer
    __New(name, files)
    {
        this.folderName     := name
        this.filesInFolder  := files
    }

    prepareArray()
    {
        Loop % this.filesInFolder.Length()
        {
            text := % "&" . A_Index . " | " . this.filesInFolder[A_Index]  ; dot "." concatenates 
            this.filesInFolder[A_Index] := text                            ; adds the seperators to stuff
        } 
    }

    ; Check if this element has files
    hasFiles()
    {
        Return (this.filesInFolder[1] = "") ? false : true      ; Shorthand if/else
    }
}




;    ############################## ROOT LEVEL


;~ RootFolder()

;~ RootFolder()
;~ {
    ;~ ; Get all elements of the root folder (because we won't find them using only the second loop)
    ;~ ; Stores all files that are inside the root folder
    ;~ temp := []

    ;~ Loop Files, %A_ScriptDir%\*.txt
    ;~ {
        ;~ ; Add the file to the array
        ;~ temp.Push(A_LoopFileFullPath)
    ;~ }


    ;~ ; Create a new folderElement
    ;~ element := new folderElement(A_ScriptDir, temp)
    ;~ ; Prepare the array
    ;~ element.prepareArray()

    ;~ ; Check if the element has files stored, if yes add it to the array
    ;~ If (element.hasFiles())
    ;~ {
        ;~ ; Pushes to the main array
        ;~ allElements.Push(element)
        ;~ MsgBox, % "pushing" element.folderName
    ;~ }
    ;~ else
        ;~ MsgBox, Root is empty
;~ }
