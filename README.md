

volumes: — c'un disque dur partagé entre le conteneur et ta machine hôte.

networks: — c'est le réseau privé qui permet à tes 3 conteneurs de se parler par leur nom.
                                                                               
  Le sujet dit que les bind mounts sont interdits pour les volumes. Ton o: bind dans       
  driver_opts pourrait poser problème selon le correcteur — c'est une zone grise. Certains 
  42 l'acceptent, d'autres non.  



Installing and Using MariaDB via Docker:
https://mariadb.com/docs/server/server-management/automated-mariadb-deployment-and-administration/docker-and-mariadb/installing-and-using-mariadb-via-docker

Dockerfile reference:
https://docs.docker.com/reference/dockerfile/

Volumes in docker-compose.yml
https://www.nicelydev.com/docker/volume-docker-compose-yml

Comment installer WordPress en ligne de commande avec WP-CLI
https://blog.o2switch.fr/installer-wordpress-wp-cli/
https://developer.wordpress.org/cli/commands/