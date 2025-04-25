# Forwarding Datagrammi IP
Inoltrare un datagramma significa collocarlo sul giusto percorso che lo farà avanzare verso la destinazione finale.

Un host quindi quando invia un datagramma lo invia al router locale che quando lo riceve confronta la tabella di routing e trova l'hop successivo.

Un protocollo di routing deve scegliere il miglior percorso dato che ce ne sono molti possibili per raggiungere una destinazione, questi percorsi vanno aggiunti alla tabella di routing.

# Routing Intra-dominio: RIP

I protocolli intra dominio come il RIP si occupano di instradare i datagramma all'interno della stessa rete, successivamente vedremo quelli inter dominio ovvero che mettono in comunicazione reti diverse.