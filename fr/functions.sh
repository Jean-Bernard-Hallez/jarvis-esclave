jv_pg_ct_serverjarvis () {
serverjarvis=`echo $order | sed "s/ /%20/g"`
echo "" > $jv_dir/plugins/jarvis-esclave/escalve.txt

# retroureponse=`curl -s "http://$adressserver:$adressserverport?order=$serverjarvis&mute=$serverjarvisvoix/\n" | jq -r ".[].$usernameserver"`
curl -s "http://$adressserver:$adressserverport?order=$serverjarvis&mute=$serverjarvisvoix/\n" | jq -r ".[].$usernameserver" > $jv_dir/plugins/jarvis-esclave/escalve.txt
retroureponse=`cat $jv_dir/plugins/jarvis-esclave/escalve.txt`

if [ "$retroureponse" = "" -o "$retroureponse" = "null" ]; then
say "Pas de retour de réponse du serveur Jarvis... Désolé"
else


nbrligneserver=`echo "$retroureponse" | wc -l`
retourrepserver=1

while test $retourrepserver -le $nbrligneserver
    do 
serverdit=`sed -n "$retourrepserver p;" $jv_dir/plugins/jarvis-esclave/escalve.txt`
say "$serverdit"
retourrepserver="$((retourrepserver + 1))"
done
fi
}



jv_pg_ct_testpingserverjarvis () {
# ping -c1 $adressserver 1>/dev/null 2>/dev/null
ping -c1 $adressserver 2>/dev/null


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
say "Voici les commandes du Server Jarvis:"
curl "http://$adressserver:$adressserverport?action=get_commands"
}