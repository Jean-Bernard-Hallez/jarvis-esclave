jv_pg_ct_serverjarvis () {
serverjarvis=`echo $order | sed "s/ /%20/g"`
serverjarvislu=".[0].$usernameserver"
retroureponse=`curl -s "http://$adressserver:$adressserverport?order=$serverjarvis&mute=$serverjarvisvoix" | jq -r $serverjarvislu`
if [ "$retroureponse" = "" -o "$retroureponse" = "null" ]; then
echo "Pas de retour de réponse du serveur Jarvis... Désolé"
else
echo "$retroureponse"
serverjarvislu=".[1].$usernameserver"
retroureponse=`curl -s "http://$adressserver:$adressserverport?order=$serverjarvis&mute=$serverjarvisvoix" | jq -r $serverjarvislu`
	if [ "$retroureponse" = "" -o "$retroureponse" = "null" ]; then
	return
	else
	echo "$retroureponse"
	fi

serverjarvislu=".[2].$usernameserver"
retroureponse=`curl -s "http://$adressserver:$adressserverport?order=$serverjarvis&mute=$serverjarvisvoix" | jq -r $serverjarvislu`
	if [ "$retroureponse" = "" -o "$retroureponse" = "null" ]; then
	return
	else
	echo "$retroureponse"
	fi


fi
}



jv_pg_ct_testpingserverjarvis () {
ping -c1 $adressserver 1>/dev/null 2>/dev/null

if [ $? -eq 0 ]
then
resultatserver=`echo "Ok pour la connection à l'adresse IP du Server Jarvis"`
else
resultatserver=`echo "Echec de connection de l'adresse IP du Server Jarvis"`
fi
serverjarvislu=".[0].$usernameserver"
retroureponse=`curl -s "http://$adressserver:$adressserverport?order=bonjour&mute=true" | jq -r $serverjarvislu`
if [ "$retroureponse" = "" ]; then
echo "$resultatserver mais il n'est pas lancée..."
else echo "Ok Jarvis Serveur est bien en fonctionnement..."
fi
}



jv_pg_ct_commandserverjarvis () {
curl "http://$adressserver:$adressserverport?action=get_commands"
}