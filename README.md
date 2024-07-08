# Documentation, pour la mise en place de postes hybrides :

# Qubes Lite v0.1

## Description

Ce Document à pour but de mettre en place un poste a distance sous Qubes OS, en expliquer les fonctionnalités et la bonne utilisation et les intérêts, y seront abordés à la fin les points d’amélioration possible.

Qubes OS est un environnement se reposant sur la technologie de l’hyperviseur Xen, pour générer et gérer de multiples VMs qui seront cloisonné au niveau du noyau, se rapprochant ainsi de l’utilisation de plusieurs machines physique afin d’isoler les applications critiques, et de permettre des restaurations rapides.

Ce guide a pour but de mettre en place une architecture simple de Qubes OS, permettant à l’utilisateur de disposer d’une machine admin (utilisation des application de travail ; Citrix) et d’une machine de bureatique ( réalisation de tâches annexes ; emails , word … )






# Table des matières
    Qubes Lite v0.1	1
  - [Installation Qubes OS](#installation-qubes-os)
    - [demarrage sys-net](#demarrage-sys-net)
  - [Utilisation](#utilisation)
    - [Dom0](#dom0)
    - [Vm disposables](#vm-disposables)
    - [Transfert de fichiers et copier/coller](#transfert-de-fichiers-et-copiercoller)
  - [Mise en place](#mise-en-place)
    - [Projet](#projet)
    - [Création des VMs et politiques](#création-des-vms-et-politiques)
    - [Connexion Internet](#connexion-internet)
    - [Installation Windows](#installation-windows)
    - [Installation Citrix Workspace](#installation-citrix-workspace)





# Installation Qubes OS

Ce guide présuppose que vous utilisez un Dell Latitude 5440 ou similaire, et ne résoudra donc que les problèmes qui lui incombent. Ci-dessous un lien listant de manière quasi exhaustive la compatibilité du matériel « récent » avec Qubes OS : qubes-os.org
Pour l’installation, dans le BIOS de l’ordinateur il faut sélectionner l’ISO de Qubes comme source de BOOT prioritaire. Par ailleurs il faut enlever la technologie de gestion du disque dur par défaut de Dell et choisir celle standard (Storage> AHCI/NVMe et non ‘Raid on’ ou ‘disable’). Vous pouvez aussi vérifier que la virtualisation est activée mais normalement elle l’est déjà par défaut. Un message d’erreur sera affiché plus tard si ce n’est pas le cas et l’installation sera impossible.
	Une fois le boot lancer il suffit de lancer l’installation.
 
 

Voici un screen de menu d’installation : 
Dans destination d’installation il est préférable d’utuliser tout le disque disponible et de laisser en automatique l’allocation. Il sera ensuite demandé de entrer un mot de passe fort pour l’encryption du disque.
 
Pas besoin de créer de root account, seul un user account est utile.

Il faudra ensuite redémarrer le système.
 
Cet écran indique qu’il faut entrer le mot de passe disque créer précédemment.
On peut ensuite procéder au setup de notre machine.


 Note :![Image1](https://github.com/clement6494/Salt-Lite/assets/94296944/ec29d3d4-a828-41af-bfd4-1647dc032399)
 
Dans les Template garder Fedora en Template par défaut, Whonix peut être décoché il n’est pas utile, c’est une distro linux servant a naviguer anonymement sur internet. Il pourra être installé plus tard de toute façon si besoin comme de nombreuse autres distro de linux.
Dans configuration principale, il est intéressant de cocher accepter automatiquement les souris, mais pas les claviers. Ces options afficheront un message à chaque fois qu’un périphérique concerné sera branché à la machine. Le PC possédant déjà un clavier il est inutile dans accepter d’autres.
On peu aussi décocher le fait de créer une station de travail Whonix, nous n’en auront pas le besoin.
Voilà c’est fini votre système est prêt à être installé.

## demarrage sys-net
Une fois la session ouverte si vous utilisez un Dell latitude 5440, sys-net n'arrivera pas à démarrer a cause d'un problème d'accès au module PCI 00_1f.6 (module gérant la prise ethernet)

dans la console de dom0 (accessible dans le menu en faisant clic droit sur le bureau):

 	$ sudo qvm-pci detach sys-net dom0:00_1f.6
	$ sudo qvm-pci attach --persistent --option permissive=true --option no-strict-reset=true sys-net dom0:00_1f.6


# Utilisation

Le but de cette section est de comprendre le fonctionnement de Qubes OS et les précaution de sécurité à respecter.
## Dom0 

Dom0 est la vm d’administration de la machine Qubes OS, ne jamais travailler avec, ou l’utiliser pour stocker des fichiers, elle sert juste à créer des vms ou les modifier.

## Vm disposables

Les Vms disposables sont des vm qui seront supprimés lorsqu’elles seront éteintes, utiles pour ouvrir des fichiers suspects, ne surtout pas stocker de documents dessus au risque de les perdre à jamais.
Elles peuvent aussi être utiliser pour ouvrir des liens suspects.

## Transfert de fichiers et copier/coller
Pour copier-coller du texte d’une VM à l’autre, il suffit de copier traditionnellement (Ctrl+C) le texte, puis le copier dans le presse papier Qubes (Ctrl+Shift+C par default) en étant toujours su la VM d’où on à copier le texte.
	Si plusieurs texte on été copiés sur plusieurs VMs, Ctrl+Shift+C va copier le texte de la VM sélectionné.
Ensuite sélectionner la VM où transférer le texte (Ctrl+Shift+V par défaut) pour transférer le texte dans le presse papier de la VM, et ensuite coller le texte ( Ctrl+V)

- Sélectionner le texte
- Ctrl+C
- Ctrl+Shift+C
- sélectionner la VM de destination
- Ctrl+Shift+V
- Ctrl+V


	Le transfert de fichier ne peut pas s’opérer par cette méthode. Il faut faire clic droit sur le fichier dans l’explorateur de fichier et sélectionner transférer vers un autre Qubes.
Ensuite il faut simplement sélectionner le Qubes souhaité.
Le fichier apparaîtra dans la VM de destination à l’emplacement : ~/QubesIncoming/[NomDuFichier]

## attacher des périphériques à une vm

selectionner le périphérique choisi et la vm voule et cliquer sur le "plus"
il faudra répéter cette opération à chaque démarrage du qube.
![atach webcam](https://github.com/clement6494/Salt-Lite/assets/94296944/cdac389f-f4c5-4c96-b2f8-1ec985fd879a)



# Mise en place

## Projet

![qubes setup lite v0 1](https://github.com/clement6494/Salt-Lite/assets/94296944/09d960c9-8bcc-4851-820c-caa71b037cd3)

 
Schéma de l’architecture Qubes à mettre en place

## Création des VMs et politiques
### Création environnement utilisateur
Salt est un logiciel de management qui permets d’automatiser tout un tas d’action sur la machine, nous allons l’utiliser pour créer les différents VMs. Il est recommandé de mettre les fichiers Salt dans un répertoire utilisateur et non Salt par défaut, pour éviter que certains soit écrasés lors de mise à jour système.
Qubes OS ne présente pas de dossier Salt utilisateur par default, il faut donc en créer un : 
Exécuter dans Dom0 : qubesctl state.sls user-dir
 		
Récupérer le dossier de config Salt : sur clé USB où sur GitHub depuis la VM personal pour ensuite [le transférer  dans Dom0](#transfert-de-fichiers-et-copiercoller) : 

			
Déplacer le dossier Salt-personal dans dom0 a l'addresse:

	/srv/user-salt/
Exécuter dans Dom0 :

	mv [emplacement du dossier]/*   /srv/user-salt/
		
Lancer l’exécution des fichiers :
Exécuter dans Dom0 : 

	sudo qubesctl state.highstate	


## Connexion Internet

Normalement sys-net est recoit deja la connexion depuis ethernet, pour se connecter à l'aphp il faudra chaque jour ouvrir firefox et s'identifier (portail captif aphp).

Pour sys-net-usb, il faut cliquer sur l'icone de réseau correspondant en dans la barre( en haut à droite par défaut)  > Wifi-Networks . Vous pouvez choisir d'enregistrer 

Il faudra choisir un vm connecter a ce réseau avec firefox pour s'identifier aussi (portail captif aphp).



## Installation Windows
Récupérer depuis la VM Personal, l’iso de Windows 10 : Windows 10 ISO https://www.microsoft.com/fr-fr/software-download/windows10ISO
Dans le menu en haut à gauche dans VMs cliquez sur Windows puis Settings/Paramètres > avancé .

dans la fenêtre Kernel, choisir (provided by qube)(current)


au niveau de la fenêtre autre sélectionner Boot qube depuis un CD-ROM > depuis fichier dans un qube > personal (vm ou est dl l'ISO) 
selectionner l'ISO et cliquez sur OK.

![windows pram](https://github.com/clement6494/Salt-Lite/assets/94296944/367595c6-a7cc-4c40-9520-fe85645e4dac)

Il faudra mettre les drivers à jours, pour que la webcam et le son fonctionnent correctement. Il suffit de taper drivers dans la barre de recherche windows et selectionner update drivers. 

Ensuite, dans le terminal de dom0:

  	$  sudo qubesctl state.sls citrix saltenv=user

Cela va créer des VMs qui seront supprimé à chaque fois quelles seront éteintes et basé sur la vm windows avec ses programmes déjà installés qui vient d'être créer.


## Installation Citrix Workspace

Citrix Workspace est installé automatiquement dans la VM citrix. Si l'insalation echoue vérifiez que la VM nommé citrix a bien accès à internet.




