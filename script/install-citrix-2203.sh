#!/bin/bash

#####################################################################################################
#
# ABOUT THIS PROGRAM
#
# NAME
#   CitrixWorkspaceUpdate.sh -- Installs Citrix Workspace
#
# SYNOPSIS
#   sudo CitrixWorkspaceUpdate.sh
#
# LICENSE
#   Distributed under the MIT License
#
# EXIT CODES
#   1 - Citrix Workspace installed successfully
#   2 - Citrix Workspace NOT installed
#   3 - Citrix Workspace update unsuccessful
#   4 - Citrix Workspace is running
#   6 - Network issues preventing download
#
####################################################################################################
#
# HISTORY
#
#   Version: 1.1
#   - Simplified script for Debian
#
####################################################################################################
# Script to download and install Citrix Workspace 2203.

# Setting variables
WorkspaceProcRunning=0
contactinfo="IT Support"

# Echo function
echoFunc () {
    # Date and Time function for the log file
    fDateTime () { echo $(date +"%a %b %d %T"); }

    # Title for beginning of line in log file
    Title="InstallCitrixWorkspace2203:"

    # Header string function
    fHeader () { echo $(fDateTime) $(hostname) $Title; }

    # Check for the log file
    if [ -e "/var/log/CitrixWorkspaceUpdateScript.log" ]; then
        echo $(fHeader) "$1" >> "/var/log/CitrixWorkspaceUpdateScript.log"
    else
        touch "/var/log/CitrixWorkspaceUpdateScript.log"
        if [ -e "/var/log/CitrixWorkspaceUpdateScript.log" ]; then
            echo $(fHeader) "$1" >> "/var/log/CitrixWorkspaceUpdateScript.log"
        else
            echo "Failed to create log file, writing to syslog"
            logger "$(fHeader) $1"
        fi
    fi

    # Echo out
    echo $(fDateTime) ": $1"
}

# Exit function
exitFunc () {
    case $1 in
        1) exitCode="1 - SUCCESS: Citrix Workspace has been installed";;
        2) exitCode="2 - ERROR: Citrix Workspace NOT installed!";;
        3) exitCode="3 - ERROR: Citrix Workspace update unsuccessful!";;
        4) exitCode="4 - ERROR: Citrix Workspace is running.";;
        6) exitCode="6 - ERROR: Network issues preventing download!";;
        *) exitCode="$1";;
    esac
    echoFunc "Exit code: $exitCode"
    echoFunc "======================== Script Complete ========================"
    if [ "$1" = "1" ]; then
        exit 0
    else
        exit 1
    fi
}

# Check to see if Citrix Workspace is running
WorkspaceRunningCheck () {
    isRunning=$(pgrep -f "Citrix Workspace" | wc -l)
    echoFunc "isRunning is $isRunning"
    if [[ $isRunning == 0 ]]
    then
        echoFunc "Workspace is NOT running, continuing"
    else
        echoFunc "Workspace is running, exiting"
        WorkspaceRunning
    fi
}

WorkspaceRunning () {
    # Workspace is running, let's not interrupt and we'll wait 'till next run'
    echoFunc "Tidying up downloaded deb"
    rm /tmp/${debfile}
    exitFunc 4
}

echoFunc ""
echoFunc "======================== Starting Script ========================"

# Fetch the HTML content for inspection
html_content=$(curl -s -L https://www.citrix.com/downloads/workspace-app/legacy-workspace-app-for-linux/workspace-app-for-linux-2203.html)
echoFunc "Fetched HTML content"

# Extract URL part from HTML content
url2=$(echo "$html_content" | grep -oP 'rel="\K//downloads\.citrix\.com/[^"]+amd64\.deb\?__gda__=[^"]+' | head -n 1 )

# Debugging: Print the extracted part
echoFunc "Extracted URL part: $url2"

# Construct the full URL
url="https:${url2}"
echoFunc "Latest version of the URL is: $url"

# Extract URL part from HTML content
url1="https:"


# Construct the full URL
url="${url1}${url2}"
echoFunc "Latest version of the URL is: $url"
debfile="citrix-workspace_${CRCurrVersNormalized}_amd64.deb"

echoFunc "Downloading newer version."
curl -s -o /tmp/${debfile} ${url}
case $? in
    0)
        echoFunc "Checking if the file exists after downloading."
        if [ -e "/tmp/${debfile}" ]; then
            WorkspaceFileSize=$(du -k "/tmp/${debfile}" | cut -f 1)
            echoFunc "Downloaded File Size: $WorkspaceFileSize kb"
        fi
        echoFunc "Checking if Workspace is running before we install"
        WorkspaceRunningCheck
        echoFunc "Installing Citrix Workspace v$latestver"
        echo "$(date +"%a %b %d %T") Installing Citrix Workspace v$latestver" >> /var/log/CitrixWorkspaceInstall.log
        dpkg -i /tmp/${debfile} >> /var/log/CitrixWorkspaceInstall.log

        sleep 10
        echoFunc "Deleting deb file."
        rm /tmp/${debfile}

        sleep 10
        # Check if the new version got installed
        if [ -e "/opt/Citrix/ICAClient" ]
        then
            newlyinstalledver=$(dpkg-query -W -f='${Version}' icaclient 2>/dev/null)
            echoFunc "Newly installed version is: $newlyinstalledver"

            newlyinstalledvernorm=$(echo $newlyinstalledver | sed -e 's/[.]//g')
            newlyinstalledvernorm=${newlyinstalledvernorm:0:4}
            echoFunc "Installed version now $newlyinstalledvernorm"

            if [ "$CRCurrVersNormalized" = "$newlyinstalledvernorm" ]
            then
                echoFunc "SUCCESS: Citrix Workspace has been updated to version ${newlyinstalledvernorm}"
                exitFunc 1
            else
                exitFunc 3
            fi
        else
            exitFunc 3
        fi
    ;;
    *)
        echoFunc "Curl function failed on download! Error: $?. Review error codes here: https://curl.haxx.se/libcurl/c/libcurl-errors.html"
        exitFunc 6
    ;;
esac
