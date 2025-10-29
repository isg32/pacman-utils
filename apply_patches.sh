#!/bin/bash

APERTURE="packages/apps/Aperture"
COMPAT="hardware/lineage/compat"
SYSCORE="system/core"

if [ -d "$APERTURE" ]; then
    cd "$APERTURE"
    git remote add nothing-2a https://github.com/Nothing-2A/android_packages_apps_Aperture/
    git cherry-pick a4c34aa57ed56de60f29349a1e6d20cf8160ca15
    cd ../../..
else
    echo -e "\n SKIPPING PATCH FOR APERTURE: $APERTURE NOT FOUND"
fi

if [ -d "$COMPAT" ]; then
    cd "$COMPAT"
    git fetch https://github.com/LineageOS/android_hardware_lineage_compat refs/changes/04/447604/1 && git cherry-pick FETCH_HEAD
    cd ../../..
else
    echo -e "\n SKIPPING PATCH FOR COMPAT: $COMPAT NOT FOUND"
fi

if [ -d "$SYSCORE" ]; then
	cd "$SYSCORE"
	git fetch https://github.com/Nothing-2A/android_system_core.git
	git cherry-pick 8ff6e7a68523c3b870d8dcd5713c71ea15b43dd2
	echo "[1/2]: Patch applied, Allow Booting with fenrir patched LKs"
	git cherry-pick 0d5990a96c5e6a404887f5575c5d00bcbbaaef74
	echo "[2/2]: Patch applied, Allow flashing images from fastbootd with fenrir patched LKs"
	cd ../../
else
	echo -e "\n SKIPPING PATCH FOR SYSCORE: $SYSCORE NOT FOUND"
fi

echo -e "\n =================="
echo -e "  Patches Applied!"
echo -e " ================== \n"
