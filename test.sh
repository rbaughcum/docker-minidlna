for VAR in `env`
do
  if [[ $VAR =~ ^MINIDLNA_ ]] ; then
    name=`echo "$VAR" | sed -r "s/MINIDLNA?_(.*)=.*/\1/g" | tr '[:upper:]' '[:lower:]'`
    value=`echo "$VAR" | sed -r "s/.*=(.*)/\1/g"`
    echo $name=$value 
    echo
  elif [[ $VAR =~ ^MINIDLNA._ ]]; then 
    name=`echo "$VAR" | sed -r "s/MINIDLNA._(.*)=.*/\1/g" | tr '[:upper:]' '[:lower:]'`
    value=`echo "$VAR" | sed -r "s/.*=(.*)/\1/g"`
    echo $name=$value 
    echo 
  fi 
done
