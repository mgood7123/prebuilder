FOLDER=GITHUB_ACTIONS_PREBUILD_OUT_FOLDER
NAME=\*.$1

find $FOLDER -name $NAME -exec bash -c "DIR=\"\$(dirname {})\"; BASE=\"\$(basename {})\"; cd \$DIR; echo creating split info for \$BASE; touch \$BASE.SPLIT_MARKER; echo \$BASE > \$BASE.SPLIT_MARKER_NAME; $2 \$BASE > \$BASE.SPLIT_MARKER_CHMOD; echo created split info for \$BASE; echo splitting \$BASE; split -b 1k \$BASE \$BASE.SPLIT_FILE; rm \$BASE; echo split \$BASE" \;
