#Script to run all control panel->configuration mangager->actions
## Useful for machines/servers not recognizing new windows update availability 

#Application Deployment Evaluation Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000121}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Discovery Data Collection Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000003}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#File Collection Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000010}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Hardware Inventory Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000001}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Machine Policy Retrieval Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000021}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Machine Policy Evaluation Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000022}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Software Inventory Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000002}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Software Metering Usage Report Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000031}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Software Update Deployment Evaluation Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000114}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Software Update Deployment Evaluation Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000108}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Software Update Scan Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000113}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#User Policy Retrieval Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000026}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#User Policy Evaluation Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000027}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Windows Installers Source List Update Cycle

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000032}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

#Compliance Evaluation

Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000071}" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue