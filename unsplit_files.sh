FOLDER=GITHUB_ACTIONS_PREBUILD_OUT_FOLDER

find $FOLDER -name \*.SPLIT_MARKER -exec bash -c "DIR=\"\$(dirname {})\"; BASE=\"\$(basename {})\"; cd \$DIR; echo gathering split info for \$BASE; ORIG=\$(cat \${BASE}_NAME); CHMOD=\$(cat \${BASE}_CHMOD); echo gathered split info for \$BASE; echo unsplitting \$ORIG; cat \${ORIG}.SPLIT_FILE* > \$ORIG; chmod \$CHMOD \$ORIG; rm -rf \${ORIG}.SPLIT_*; echo unsplit \$ORIG" \;
