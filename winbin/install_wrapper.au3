; Define a logging function
Func WriteLog($ErrorMessage)
    FileWriteLine("L:\install_wrapper.log", @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & " " & $ErrorMessage)
EndFunc

WriteLog("--- Starting script ---")

; Run the Tribes 2 installer
WriteLog("Launching tribes2_gsi.exe: " & Run("I:\tribes2_gsi.exe"))

; SLA
WriteLog("Wait for SLA window: " & WinWait("Software License Agreement", "Please read through the entire license agreement", 60))
WriteLog("Click [I Agree]: " & ControlClick("Software License Agreement", "Please read through the entire license agreement", 4)) ; click I Agree

; Welcome window
WriteLog("Wait for Welcome window: " & WinWait("Tribes 2", "Welcome to the Tribes 2 Installation!", 60))
WriteLog("Click [Skip]: " & ControlClick("Tribes 2", "Welcome to the Tribes 2 Installation!", 4)) ; click "Skip >"

; Tribes Vengeance preorder
WriteLog("Wait for Tribes Vengeance Preorder window: " & WinWait("Tribes: Vengeance", "Click here to Pre-order Tribes: Vengeance Now!", 60))
WriteLog("Click [Next]: " & ControlClick("Tribes: Vengeance", "Click here to Pre-order Tribes: Vengeance Now!", 5)) ; click "Next >"

; Welcome 2 
WriteLog("Wait for Welcome: " & WinWait("Welcome", "Welcome to the Tribes 2 Setup program", 180))
WriteLog("Click [Next]: " & ControlClick("Welcome", "Welcome to the Tribes 2 Setup program", 3)) ; click "Next >"

; Credits 
WriteLog("Wait for Credits window: " & WinWait("Credits", "It's not often that the community of a game", 60))
WriteLog("Click [Next]: " & ControlClick("Credits", "It's not often that the community of a game", 3)) ; click "Next >"

; Choose Destination Location
WriteLog("Wait for Choose Destination window: " & WinWait("Choose Destination Location", "Setup will install Tribes 2 in the following folder.", 60))
WriteLog("Click [Browse]: " & ControlClick("Choose Destination Location", "Setup will install Tribes 2 in the following folder.", 9)) ; click "Browse"
WriteLog("Wait for Browse window: " & WinWait("Select Destination Directory", "", 60))
WriteLog("Type 'T:\t2server': " & ControlSend("Select Destination Directory", "", 3, "T:\t2server")) ; update the destination path
WriteLog("Click [OK]: " & ControlClick("Select Destination Directory", "", 7)) ; click OK
WriteLog("Click [Yes] to use existing directory: " & ControlClick("Install", "The directory T:\t2server already exists", 1)) ; T:\t2server already exists, install anyway
WriteLog("Click [Next]: " & ControlClick("Choose Destination Location", "Setup will install Tribes 2 in the following folder.", 3)) ; click "Next >"

; Select Program Manager Group
WriteLog("Wait for Start Menu Group window: " & WinWait("Select Program Manager Group", "Enter the name of the Program Manager group to add Tribes 2 icons to:", 60))
WriteLog("Click [Next]: " & ControlClick("Select Program Manager Group", "Enter the name of the Program Manager group to add Tribes 2 icons to:", 3)) ; click "Next >"

; Start Installation
WriteLog("Wait for Start Installation window: " & WinWait("Start Installation", "You are now ready to install Tribes 2.", 60))
WriteLog("Click [Next]: " & ControlClick("Start Installation", "You are now ready to install Tribes 2.", 3)) ; click "Next >"

; Register
WriteLog("Wait for Register window: " & WinWait("Register", "You can register Tribes 2 on the World Wide Web.", 180))
WriteLog("Uncheck 'Register Tribes 2 Now': " & ControlClick("Register", "You can register Tribes 2 on the World Wide Web.", 9)) ; uncheck "Register Tribes 2 Now"
WriteLog("Click [Next]: " & ControlClick("Register", "You can register Tribes 2 on the World Wide Web.", 3)) ; click "Next >"

; DirectX 8a
WriteLog("Wait for DX8 Install window: " & WinWait("DirectX 8a", "DirectX 8a Install", 60))
WriteLog("Uncheck 'Install DirectX 8a': " & ControlClick("DirectX 8a", "DirectX 8a Install", 9)) ; uncheck "Install DirectX 8a"
WriteLog("Click [Next]: " & ControlClick("DirectX 8a", "DirectX 8a Install", 3)) ; click "Next >"

; Installation Complete
WriteLog("Wait for Installation Complete window: " & WinWait("Installation Complete", "Tribes 2 has been successfully installed.", 60))
WriteLog("Uncheck 'Open the Tribes 2 Readme': " & ControlClick("Installation Complete", "Tribes 2 has been successfully installed.", 9)) ; uncheck "Open the Tribes 2 Readme"
WriteLog("Uncheck 'Launch Tribes 2': " & ControlClick("Installation Complete", "Tribes 2 has been successfully installed.", 10)) ; uncheck "Launch Tribes 2"
WriteLog("Click [Next]: " & ControlClick("Installation Complete", "Tribes 2 has been successfully installed.", 3)) ; click "Next >"

; Wait up to a minute for the installer to complete and exit
WriteLog("Wait for tribes2_gsi.exe to exit: " & ProcessWaitClose("tribes2_gsi.exe", 60))

; Run the TribesNext Patch
WriteLog("Launching TribesNExt_rc2a.exe: " & Run("I:\TribesNext_rc2a.exe"))

; SLA 
WriteLog("Wait for License Agreement window: " & WinWait("TribesNext Patcher: License Agreement", "Please review the license agreement before installing", 60))
WriteLog("Click [I Agree]: " & ControlClick("TribesNext Patcher: License Agreement", "Please review the license agreement before installing", 1)) ; click "I Agree"

; Installation Folder 
WriteLog("Wait for Completed window: " & WinWait("TribesNext Patcher: Installation Folder", "Setup will apply the TribesNext multiplayer patch", 60))
WriteLog("Click [Apply Patch]: " & ControlClick("TribesNext Patcher: Installation Folder", "Setup will apply the TribesNext multiplayer patch", 1)) ; click "Apply Patch"

; Completed
WriteLog("Wait for SLA window: " & WinWait("TribesNext Patcher: Completed", "Completed", 60))
WriteLog("Click [Close]: " & ControlClick("TribesNext Patcher: Completed", "Completed", 1)) ; click "Close"

WriteLog("--- Script Complete ---")