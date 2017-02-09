jv_pg_ct_serverjarvis () {
serverjarvis=`echo $order | sed "s/ /%20/g"`
echo "" > essai.txt
# retroureponse=`curl -s "http://$adressserver:$adressserverport?order=$serverjarvis&mute=$serverjarvisvoix/\n" | jq -r ".[].$usernameserver"`
curl -s "http://$adressserver:$adressserverport?order=$serverjarvis&mute=$serverjarvisvoix/\n" | jq -r ".[].$usernameserver" > essai.txt
retroureponse=`cat essai.txt`

if [ "$retroureponse" = "" -o "$retroureponse" = "null" ]; then
say "Pas de retour de réponse du serveur Jarvis... Désolé"
else


nbrligneblague=`echo "$retroureponse" | wc -l`
retourrep=1

while test $retourrep -le $nbrligneblague
    do 
blagueadire=`sed -n "$retourrep p;" essai.txt`
say "$blagueadire"
retourrep="$((retourrep + 1))"
done
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
say "$resultatserver mais il n'est pas lancée..."
else say "Ok Jarvis Serveur est bien en fonctionnement..."
fi
}



jv_pg_ct_commandserverjarvis () {
curl "http://$adressserver:$adressserverport?action=get_commands"
}