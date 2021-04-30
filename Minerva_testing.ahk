#SingleInstance Force

global ScriptName := "Minerva"
global Version    := "2.0"



Menu, % A_ScriptDir . "\test", Add, % ScriptName " vers. " Version, GoToGithub
Menu, % A_ScriptDir . "\test", Add, ; seperating line 

Ctrl & Space::
FolderWalk(A_ScriptDir . "\test\*")

Menu, % A_ScriptDir . "\test", show
return


FolderWalk(Location)
{
	LocalFolderArray := []
	LocalFileArray := []
	
	;~ MsgBox, % Location
	; Fix så den finder directories først med en arraylist
	Loop, Files, %Location%, DF
	{
		
		AttributeString := ""
		AttributeString := FileExist(A_LoopFileFullPath) 
		
		if ((AttributeString = "D") or (AttributeString = "AD"))
		{
			;~ MsgBox, % A_LoopFileFullPath "`nIs a directory" 
			LocalFolderArray.Push(A_LoopFileFullPath)
		}
		else
		{
			;~ MsgBox, % A_LoopFileFullPath "`nIs a file"
			LocalFileArray.Push(A_LoopFileFullPath)
		}
	}
	
	for key, InputValue in LocalFolderArray
	{
		FolderWalk(InputValue . "\*")
		
		SplitPath, InputValue, name, dir, ext, name_no_ext, drive

		;~ MsgBox, % " Adding to MENU: " dir "`nWith name: " name "`nand target: " value
		Menu, %dir%, Add, &%name%, :%Inputvalue%
	}

	for key, InputValue in LocalFileArray
	{
		;~ MsgBox % "FILE IS: " value
		
		; To fetch all info:
		SplitPath, InputValue, name, dir, ext, name_no_ext, drive
		
		;~ MsgBox, % " Adding to MENU: " dir "`nWith name: " name "`nand target GOTOGITHUB"
		Menu, %dir%, Add, &%name%, GoToGithub
	}
}

FolderWalk("C:\Users\Mikke\Documents\Test\*")


GoToGithub()
{
	run, https://github.com/jikkelsen/
}



