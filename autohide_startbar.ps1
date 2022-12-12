# Define global variables
## Define the value used to disable autohide
$autohide_disable = 2
## Define the value used to enable autohide. 
$autohide_enable = 3
## Define the index of the autohide startbar setting
$autohide_startbar_setting = 8

# Check current hide status of task bar
$startbar_settings_path = 'HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3';
$startbar_settings = (Get-ItemProperty -Path $startbar_settings_path).Settings;
$startbar_settings_autohide = $startbar_settings[$autohide_startbar_setting];

# If the taskbar is not hidden
if ($startbar_settings_autohide -ne $autohide_enable) {
	# Update the settings to autohide the startbar
	$startbar_settings[$autohide_startbar_setting] = $autohide_enable
	# Pass the settings to the registry
	Set-ItemProperty -Path $startbar_settings_path -Name Settings -Value $startbar_settings
	# Restart Explorer to make this take effect
	Stop-Process -f -ProcessName explorer
}
