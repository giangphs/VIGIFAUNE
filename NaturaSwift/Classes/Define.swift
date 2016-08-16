//
//  Define.swift
//  NaturaSwift
//
//  Created by Manh on 5/26/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit

//MARK: - COLOR

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
///////////////***************Custom Fonts
func FONT_HELVETICANEUE_MEDIUM(FontSize:Int) -> UIFont {
    return UIFont(name: "HelveticaNeue-Medium", size: CGFloat(FontSize))!;
}
func FONT_HELVETICANEUE(FontSize:CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue", size: CGFloat(FontSize))!;
}
func FONT_HELVETICANEUE_LIGHT(FontSize:CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Light", size: CGFloat(FontSize))!;
}
///////////////***************Custom Fonts

let SHAPE_TYPE_POLYGON = "polygon"
let SHAPE_TYPE_POLYLINE = "polyline"
let SHAPE_TYPE_CIRCLE = "circle"
let SHAPE_TYPE_RECTANGLE = "rectangle"


//MARK: - FILE SAVE

let PATH_STORE_CACHE                    = "NATURA_CACHE"
let PATH_STORE_TEMP                     = "NATURA_TEMP"
let MY_FRIEND_SAVE                      = "Friend.save"
let FILE_MUR_SAVE                       = "Mur.save"
let FILE_GROUP_MUR_SAVE                 = "Group.Mur.save"
let FILE_CARTE_SAVE                     = "Carte.save"
let FILE_CHASSE_MUR_SAVE                = "Chasse.Mur.save"
let SHARE_MES_GROUP_SAVE                = "ShareMesGroup.save"
let SHARE_MES_HUNT_SAVE                 = "ShareMesHunt.save"
let FILE_CHASSE_MUR_PASS_SAVE           = "Chasse.Mur.Pass.save"
let FILE_LOG                            = "LOG.txt"
let FILE_HOME_NEWS_SAVE                 = "Home.News.save"
let FILE_CHATLISTE_SAVE                 = "Chat.List.save"
let LIVE_MAP_CHAT_SAVE                  = "live.map.chat.save"
let LIVE_HUNT_HOME_SAVE                 = "live.hunt.save"
let FILE_PUBLICATION_COLOR_SAVE         = "PublicationColor.save"
//Cache Categories
let CACHE_SPECIFIC_CARDS                = "CACHE_SPECIFIC_CARDS.save"
let CACHE_CARDS                         = "CACHE_CARDS.save"
let CACHE_TREE                          = "CACHE_TREE.save"
let MAXIMUM_ZOOM                        = 20
//Define notification
let publication_commented               = "publication.commented"
let publication_same_commented          = "publication.same_commented"
let publication_liked                   = "publication.liked"
let lounge_join_accepted                = "lounge.join.accepted"
let lounge_join_asked                   = "lounge.join.asked"
let lounge_join_invited                 = "lounge.join.invited"
let lounge_join_valid_asked             = "lounge.join.valid-asked"
let lounge_chat_new_message             = "lounge.chat.new_message"
//pending confirm.
let lounge_status_changed               = "lounge.status.changed"
let group_join_accepted                 = "group.join.accepted"
let group_join_asked                    = "group.join.asked"
//let group_invite_group                = "group.invite.group"
let group_join_invited                  = "group.join.invited"
let group_join_valid_asked              = "group.join.valid-asked"
let group_chat_new_message              = "group.chat.new_message"
let user_friendship_asked               = "user.friendship.asked"
let user_friendship_confirmed           = "user.friendship.confirmed"
// chua xu ly
let lounge_invite_friend                = "lounge.invite.friend"
let lounge_invite_group                 = "lounge.invite.group"
let lounge_join_refused                 = "lounge.join.refused"
let group_invite_friend                 = "group.invite.friend"
let group_join_refused                  = "group.join.refused"
let group_subcriber_banned              = "group.subscriber.banned"
let discussion_new_message              = "chat.new_message"
let lounge_discussion_new_message       = "chat"

let NOTIFICATIONTIMER                   = "NOTIFICATIONTIMER"
let NOTIFICATIONLOUNGESUSCRUBERADMIN    = "LoungeSuscriberAdminAction"
let NOTIFICATION_REQUEST_UPDATING       = "NOTIFICATION_REQUEST_UPDATING"
let NOTIFICATION_REQUEST_UPDATING_BADGE = "NOTIFICATION_REQUEST_UPDATING_BADGE"
let KILL_TEXT_FOCUS                     = "KILL_TEXT_FOCUS"
let NOTIFY_REFRESH_MES                  = "NOTIFY_REFRESH_MES"
let NOTIFY_REFRESH_MES_NEW              = "NOTIFY_REFRESH_MES_NEW"
let NOTIFY_REFRESH_MES_CHASSES          = "NOTIFY_REFRESH_MES_CHASSES"
let NOTIFY_REFRESH_MES_CHASSES_PASS     = "NOTIFY_REFRESH_MES_CHASSES_PASS"
let NOTIFY_REFRESH_GROUP                = "NOTIFY_REFRESH_GROUP"
let NOTIFY_REFRESH_CHASSE               = "NOTIFY_REFRESH_CHASSE"
let UPDATE_UPLOADING_PROGRESS           = "UPDATE_UPLOADING_PROGRESS"
let UPDATE_CACHE_CHAT                   = "UPDATE_CACHE_CHAT"
let DISABLE_CHAT                        = "DISABLE_CHAT"
let UPDATE_RIGHT_CHAT                   = "UPDATE_RIGHT_CHAT"
//MARK: - CONCATSTRING
func concatstring(str1: String, str2: String) -> String {
    return "\(str1)_\(str2)";
}

//Login text color
let COLOR_LOGO_CCPA:UInt                = 0x86B318
let TABLE_BACKGROUND_COLOR:UInt         = 0xECEDF0
let MAIN_COLOR:UInt                     = 0xF0F0F0
let GROUP_TINY_BAR_COLOR:UInt           = 0x409F9A
let GROUP_MAIN_BAR_COLOR:UInt           = 0x409F9A

let MUR_TINY_BAR_COLOR:UInt             = 0x74A605
let MUR_MAIN_BAR_COLOR:UInt             = 0x74A605
let SUB_NAV_BAR_COLOR:UInt              = 0x537811

let CHASSES_TINY_BAR_COLOR:UInt         = 0x825E41
let CHASSES_MAIN_BAR_COLOR:UInt         = 0x825E41
//AMIS
let AMIS_TINY_BAR_COLOR:UInt            = 0xAA3052
let AMIS_MAIN_BAR_COLOR:UInt            = 0xAA3052

let CARTE_TINY_BAR_COLOR:UInt           = 0xD73A65
let CARTE_MAIN_BAR_COLOR:UInt           = 0xD73A65
//let AMIS_SUB_NAV_BAR_COLOR 0x537811

let DISCUSSION_TINY_BAR_COLOR:UInt      = 0xf0611d
let DISCUSSION_MAIN_BAR_COLOR:UInt      = 0xf0611d

let DISCUSSION_BACK:UInt                = 0xc14e18

let GROUP_CHAT_CALLOUT:UInt             = 0x009e9a
let CHASSE_CHAT_CALLOUT:UInt            = 0x825e41
let DISCUSSION_CHAT_CALLOUT:UInt        = 0xed612a
let LIVE_MAP_MAIN_BAR_COLOR:UInt        = 0xbe0500
let LIVE_MAP_TINY_BAR_COLOR:UInt        = 0xbe0500
//let LIVE_MAP_TINY_BAR_COLOR 0xAF0004


let TEXT_NAME_BOLD_COLOR:UInt           = 0x74A605

let BUTTON_DESINSCRIRE_COLOR:UInt       = 0xD73208

let MUR_BACK:UInt                       = 0x578013
let MUR_CANCEL:UInt                     = 0xC2280E

let GROUP_BACK:UInt                     = 0x0F6C68
let GROUP_CANCEL:UInt                   = 0xC32808

let CHASSES_BACK:UInt                   = 0x825E41
let CHASSES_CANCEL:UInt                 = 0xC32808

let CARTE_BACK:UInt                     = 0xD73A65

let ON_SWITCH:UInt                      = 0x679709
let OFF_SWITCH:UInt                     = 0x6D7172

let ON_SWITCH_GROUP:UInt                = 0x139089
let OFF_SWITCH_GROUP:UInt               = 0x6D7172

let ON_SWITCH_CHASSES:UInt              = 0x804000
let OFF_SWITCH_CHASSES:UInt             = 0x6D7172

let ON_SWITCH_CARTE:UInt                = 0xD73A65
let OFF_SWITCH_CARTE:UInt               = 0x6D7172

let ON_SWITCH_PARAM:UInt                = 0x676363
let OFF_SWITCH_PARAM:UInt               = 0x6D7172

let GROUP_MUR_ADMIN_COLOR:UInt          = 0x128F88
let GROUP_MUR_NORMAL_COLOR:UInt         = 0x128F88
let GROUP_MUR_CANCEL_COLOR:UInt         = 0xD93208

let GROUP_TOUS_COLOR:UInt               = 0x128F88

let PARTICIPE_COLOR:UInt                = 0x85b916
let NE_SAIS_PAS_COLOR:UInt              = 0xEA8627
let NE_PARTICIPE_PAS_COLOR:UInt         = 0xE91E20
let BTN_REFUSER_COLOR:UInt              = 0xCE4B19

let PARAM_TINY_BAR_COLOR:UInt           = 0x676363
let PARAM_MAIN_BAR_COLOR:UInt           = 0x676363
//Discussion cell color
let DISCUSSION_CELL_ACTIVE_COLOR:UInt   = 0xfbdfd3
let DISCUSSION_CELL_WHITE_COLOR:UInt    = 0xFFFFFF
let CHASSES_CELL_ACTIVE_COLOR:UInt      = 0xe4dcd5
let NOTIFI_CELL_ACTIVE_COLOR:UInt       = 0xe6efd2
let FAVO_ACTIVE_COLOR:UInt              = 0xF4CEC2
let DOCUMENT_CELL_CHECK:UInt            = 0x198AFB
let DISTRIBUTION_TEXT:UInt              = 0x525252
//bottom color
let BOTTOMBAR_COLOR:UInt                = 0x363535

//MARK: - MENU
let POP_MENU_VIEW_TAG1:Int              = 88888
let POP_MENU_VIEW_TAG2:Int              = 99999

let MENU_ITEM_TAG1:Int                  = 10
let MENU_ITEM_TAG2:Int                  = 11
//MARK: - TAG
let LIKETAG:Int                         = 1000
let UNLIKETAG:Int                       = 2000
let COMMENTBUTTONTAG:Int                = 3000
let LOCATIONBUTTONTAG:Int               = 4000
let INFOBUTTONTAG:Int                   = 5000
let SETTINGBUTTONTAG:Int                = 6000
let TAG_MAIN_NAV_VIEW:Int               = 100
let TAG_SUB_NAV_VIEW :Int               = 120
let START_SUB_NAV_TAG:Int               = 10
let TEXT_START_SUB_NAV_TAG:Int          = 40

//MARK: - ENUM
enum EDIT_PUBLICATION_TYPE: Int{
   case EDIT_TEXT = 0
   case EDIT_CARTE = 1
   case EDIT_LEGEND = 2
   case EDIT_PRECISIONS = 3
   case EDIT_PARTAGE = 4
   case EDIT_COLOR = 5
};

enum USER_KIND: Int {
   case USER_INVITED = 0
   case USER_WAITING_APPROVE = 1
   case USER_NORMAL = 2
   case USER_ADMIN = 3
   case USER_REJOINDRE = 4
};
enum ACCESS_KIND: Int
{
   case ACCESS_PRIVATE = 0
   case ACCESS_SEMIPRIVATE = 1
   case ACCESS_PUBLIC = 2
    
};
enum ISFRIEND_KIND: Int
{
   case NOT_FRIEND = 0
   case WAIT_FRIEND = 1
   case IS_FRIEND   = 2
};

enum MEDIATYPE: Int{
   case TYPE_MESSAGE = 0
   case TYPE_PHOTO
   case TYPE_VIDEO
   case TYPE_RESET
} ;

enum ISSCREEN: Int{
   case ISLOUNGE = 0
   case ISGROUP
   case ISHOME
   case ISMUR
   case ISCARTE
   case ISAMIS
   case ISDISCUSS
   case ISFROM_CREATE_SPECIAL
   case ISFROM_SETTING_MEMBRES
   case ISPARAMTRES
   case ISMUR_FAV
   case ISDEFAULT
   case ISLIVEMAP
};

//Type Map profile view
enum TYPE_VIEW: Int{
   case CITY = 0 //city
   case COUNTRY//country
   case TYPE_CHASSE//type hunt
   case HUNT_PRACTICED
   case HUNT_LIKED
   case TYPE_DOG
   case TYPE_WEAPONS
   case TYPE_PAPER
};

enum PAPER_TYPE: Int{
   case PAPER_TYPE_ALL = 0
   case PAPER_TYPE_MEDIA
   case PAPER_TYPE_MEDIA_NAME
   case PAPER_TYPE_MEDIA_TEXT
};

enum FORMAT_NUMBER: Int
{
   case ISNUMBER = 0
   case ISFLOAT
};
enum CARTER_CHECK: Int{
   case NON_CHECK = 0
   case UN_CHECK = 1
   case IS_CHECK = 2
} ;

enum VENT_DIRECTION: Int{
   case map_n
   case map_ne
   case map_e
   case map_se
   case map_s
   case map_sw
   case map_w
   case map_nw
    
};

enum STATE_LOAD: Int
{
   case LOAD_PREVOUS
   case LOAD_CURRENT
   case LOAD_MORE
};

enum FAVORIS_TYPE: Int{
   case FAV_LEGENDE
   case FAV_COULEUR
   case FAV_PRECISIONS
   case FAV_FICHE
   case FAV_FICHE_CHILD
   case FAV_PARTAGE
   case FAV_GROUPS
   case FAV_GROUPS_CHILD
   case FAV_HUNTS
   case FAV_HUNTS_CHILD
    
};

enum TYPE_CONTROL: Int
{
   case CONTROL_CHECKBOX = 0
   case CONTROL_RADIO
};

enum TYPE_SQLITES: Int
{
   case ALL = 0
   case PUBLICATION
   case SHAPE
   case GROUP
   case HUNT
   case DISTRIBUTOR
   case ADDRESS
   case FAVORITES
};

enum TYPE_NUMBER: Int
{
   case NUMBER_INT = 0
   case NUMBER_FLOAT
};

enum GROUP_CREATE_ADD_VIEW: Int
{
   case GROUP_CAN_ADD = 0
   case GROUP_CAN_SHOW
};


enum AGENDA_CREATE_ADD_VIEW: Int
{
   case PUBLICATION_ALLOW_AGENDA = 0
   case CHAT_ALLOW_AGENDA
};


enum UPLOAD_STATUS: Int
{
   case UPLOAD_NOT_YES = 0
   case UPLOAD_UPLOADING
   case UPLOAD_FAIL
   case UPLOAD_SUCCESS
};
enum MARKERS_TYPE: Int
{
   case MARKER_PUBLICATION = 1
   case MARKER_DISTRIBUTRION
   case MARKER_LEGEND
    
};

enum VIEW_ACTION_TYPE: Int
{
   case VIEW_ACTION_REFRESH_TOP
   case VIEW_ACTION_REFRESH_BOTTOM
   case VIEW_ACTION_UPDATE_DATA
    
};
enum UI_TYPE: Int
{
    case UI_GROUP_MUR_ADMIN
    case UI_GROUP_MUR_NORMAL
    case UI_GROUP_TOUTE
    case UI_CHASSES_MUR_ADMIN
    case UI_CHASSES_MUR_NORMAL
    case UI_CHASSES_TOUTE
    case UI_CARTE
    case UI_DISCUSSION
    case UI_AMIS_DELETE

    
};
enum TYPE_TABBAR: Int
{
    case TABBAR_TOP = 0
    case TABBAR_PRE
};
let MYGROUP     = "groups"
let MYCHASSE    = "lounges"
let MYPUBLIC    = "publications"
let ONE_GROUP   = "group"
let ONE_CHASSE  = "lounge"
let ONE_PUBLIC  = "publication"

//MARK: - EMPTY
let EMPTY_FRIENDINFO  = "%@ n'a pas encore de publication"

let EMPTY_MUR  = ""

let EMPTY_GROUP_MES  = "Vous n'avez actuellement aucun groupe."
let EMPTY_GROUP_PUBLICATION  = "Aucune publication pour l'instant.\nSerez-vous le premier?"
let EMPTY_GROUP_INVITE  = " Vous n'avez aucune demande actuellement."
let EMPTY_GROUP_AGENDA  = "Aucun événement est prévu pour l'instant.\nA vous d'en organiser un!"
let EMPTY_GROUP_TOUS  = ""
let EMPTY_CHASSE_MES  = "Vous ne participez à aucun événement.\nC'est le moment d'en créer un ou de vous faire inviter."
let EMPTY_CHASSE_PUBLICATION  = "Aucune publication pour le moment.\nAllez-y, publiez!"
let EMPTY_CHASSE_PASS  = ""
let EMPTY_CHASSE_INVITE  = "Vous n'avez aucune demande actuellement."
let EMPTY_CHASSE_TOUS  = ""

let EMPTY_DISCUSTION  = "Aucun message. Des chasseurs non bavards ???"
let MINIMUM_LETTRES  = "Veuillez taper minimum 4 lettres pour faire une recherche"
let VAR_MINIMUM_LETTRES = 4
let MAX_MESSAGE = 200

let str_NO_GROUP_MATCH_SEARCH  = "Il n'y a pas de groupe qui correspond à votre recherche"
//MARK: - STRING STRANSLATE
func str(originalString: String) -> String{
   return NSLocalizedString(originalString, comment: "");
};
/*def new string*/
let strRequestTimeout  = "strRequestTimeout"

let strPlaceHolderFilter_Csearch  = "strPlaceHolderFilter_Csearch"

let strWarningNotAllowSendMessage  = "strWarningNotAllowSendMessage"

let strWarningInputDialogAllowAddShow  = "strWarningInputDialogAllowAddShow"
let strEdit_Add_Show_Agenda_chat  = "strEdit_Add_Show_Agenda_chat"

let strEdit_Add_Show_Agenda_publications  = "strEdit_Add_Show_Agenda_publications"


let strTitle_Add_Show_Publication_1  = "strTitle_Add_Show_Publication_1"
let strTitle_Add_Show_Publication    = "strTitle_Add_Show_Publication"
let strAgenda_Add_Publication        = "strAgenda_Add_Publication"
let strAgenda_Show_Publication       = "strAgenda_Show_Publication"

let strTitle_Add_Show_Chat_1  = "strTitle_Add_Show_Chat_1"
let strAgenda_Add_Chat  = "strAgenda_Add_Chat"
let strAgenda_Show_Chat  = "strAgenda_Show_Chat"
let strTitle_Add_Show_Chat  = "strTitle_Add_Show_Chat"


let strLogo  = "logo"
let strLogo_print  = "cartouche-naturapass-print"
let strIcon_All_Member  = "naturepass"

let strIC_chasse_invite_member  = "ic_chasse_invite_member"
let strIC_chasse_non_member  = "ic_chasse_non_member"
let strIC_chasse_amis  = "ic_chasse_amis"
let strIC_chasse_group  = "ic_chasse_group"
let strIC_chasse_info  = "ic_chasse_info"
let strIC_chasse_admin_setting  = "ic_chasse_admin_setting"

let strIC_group_amis  = "ic_invite_my_amis"
let strIC_group_invite_mesgroup  = "ic_invite_my_group"
let strIC_group_member_natura  = "ic_member_natura"
let strIC_group_non_member  = "ic_non_member"
let strIC_group_setting_info  = "ic_group_setting_info"
let strIC_group_setting_admin  = "ic_group_setting_admin"
let strIC_group_setting_bannir  = "ic_group_setting_bannir"

let strTitle_app  = "Title_app"
let strRatingAppStore  = "THANKYOU_FORRATING"
let strJeneveuxpas  = "Je ne veux pas"
let strPlustard  = "Plus tard"
let strOui  = "Oui"
let strDeconnexion  = "DÉCONNEXION"
let strEtesvousSurDevouloirvousdeconecter  = "Êtes-vous sûr de vouloir vous déconnecter de?"
let strAnuler  = "ANNULER"
let strValider  = "VALIDER"
let strNETWORK  = "NETWORK"
let strOK  = "OK"
let strClose  = "Close"
let strEMPTY  = ""
let strREQUESTSENT  = "REQUESTSENT"
let strPREVIOUS  = "PREVIOUS"
let strNEXT  = "NEXT"
let strMonStatut  = "Mon statut"
let strTypeAffichagedelacarte  = "Type d'affichage de la carte"
let strVent  = "Vent"
let strFilterParTypeDeContenu  = "Filtrer par type de contenu"
let strFilterParTypeDePartage  = "Filtrer par type de partage"

let strMesGroupes  = "Mes groupes"
let strMesChantier  = "Mes agenda"
let strMeteo  = "Météo"
let strAdresseIntrouble  = "Adresse introuvable"
let strTableuauDeBord  = "TABLEAU DE BORD"
let strGROUPES  = "GROUPES"
let strCHANTIERS  = "AGENDA"
let strCARTE  = "CARTE"
let strPARAMETRES  = "PARAMETRES"
let strWarningZoom  = "Aucun repère ne sera chargé dans ce niveau de zoom. Si vous voulez charger des repères, il vous faut zoomer sur la zone qui les concerne."
let strWarningONWithoutSelection  = "Votre filtre est actif, mais aucune option n'est sélectionnée. Aucune publication ne s'affichera sur la carte."
let strSorryNoCamera  = "Sorry_No_Camera"
let strNoChantierInvitation  = "Vous n'avez ni demandé l’accès à  un agenda, ni reçu d'invitation"
let strAccessPrivate  = "Accès Privé"
let strAccessSemiPrivate  = "Accès Semi-Privé"
let strAccessPublic  = "Accès Public"
let strYouHaveNoChasse  = "Pas de connexion. Vous ne pouvez pas charger cette page"
let strTryAgainWithYourGoodNetwork  = "Votre réseau n'est pas assez bon pour charger votre agenda. Veuillez réessayer quand vous aurez une meilleure connexion."
let strDeleteJoinMessageChasse  = "delete_join_message_chasse"
let strDeleteJoinTitleChasse  = "delete_join_title_chasse"

let strYES  = "Yes"
let strNO   = "No"
let strCloseChasse  = "close_chasse"
let strDoyouwanttojoin  = "Serrai-je présent ?"
let SilvousplaitentrezPrenomValide  = "S'il vous plaît entrez Prénom valide"
let SilvousplaitentrezNomValide  = "S'il vous plaît entrez Nom valide"
let strRejoinLoungPublic  = "Rejoindre_un_loung_public"
let strRejoinAcceptPublic  = "Rejoindre_accept_public"

let strRejoinUnLoung  = "Rejoindre_un_loung"
let strRejoinAcceptPrivate  = "Rejoindre_accept_prive"
let strRejoinAcceptSemi  = "Rejoindre_accept_semi"
let strAcceptInvitationTourChasse  = "accept_invition_tourchasse"
let strEtesVousSurDeVouloiranuilervotresaisie  = "Etes-vous sûr de vouloir annuler votre saisie ?"
let strMessage10  = "Etes-vous sûr de vouloir annuler votre saisie ?\nVous pouvez sortir sans annuler en cliquant sur le retour menu en haut à gauche. Vous retrouverez votre %@ en revenant dans cette rubrique."
let strAlertTimeIssue  = "ALERT_debut_TIME_ISSUE"
let strRemplirtoutleschamps  = "Remplir tout les champs"
let strMessage11  = "Seules les personnes invitées dans votre agenda pourront accéder à votre agenda et en connaîtront l'existence."

let strMessage12  = "Tous le agenda auront accès à votre agenda, mais vous validerez chaque nouvelle inscription.\nVotre agenda sera visible par tout le monde dans la rubrique \"Toutes le agenda\"."
let strMessage13  = "Tous le agenda auront accès à votre agenda sans restriction. Votre action se limitera à bannir d'éventuels membres indésirables.\nVotre agenda sera visible par tout le monde dans la rubrique \"Toutes le agenda\"."
let strMessage14  = "Félicitations !"
let strMessage15  = "Votre événement a été ajouté avec succès dans votre agenda."
let strMessage16  = "Suppression adresse"
let strMessage17  = "Etes-vous sûr de vouloir supprimer cette publication favorite ?"
let strMessage18  = "Saisissez ici vos adresses favorites.\nElles vous permettront de naviguer plus rapidement sur la carte.\nQuand vous vous connectez sur la carte, vous êtes centré automatiquement sur l\'adresse par défaut."
let strMessage19  = "Etes-vous sûr de vouloir supprimer cette adresse ?"
let strMessage20  = "La photo a été mise à jour avec succès"
let strMessage21  = "Votre profil a été sauvegardé!"
let strMessage22  = "Votre filtre est actif, mais aucune option n'est sélectionnée. Aucune publication ne s'affichera sur le mur."
let strMessage23  = "Êtes-vous sûr de vouloir supprimer cette publication"
let strMessage24  = "Suppression publication"
let strMessage25  = "Tapez votre message"
let strMessage26  = "Votre adresse email et/ou votre mot de passe est/sont faux. Si vous avez oublié votre mot de passe, allez dans Mot de passe oublié."
let strMessage27  = "Votre adresse email et/ou votre mot de passe sont faux. Veuillez les corriger ou faire une demande de mot de passe dans la rubrique Mot de passe oublié"
let strMessage28  = "Veuillez renseigner votre adresse e-mail"
let strMessage29  = "Veuillez saisir un mot de passe"
let strMessage30  = "Votre compte Facebook ne possède pas d'email.\nNous ne pouvons malheureusement pas valider votre inscription par Facebook.\nMerci de réaliser une inscription manuelle !"

let strMessage31  = "strMessage31"
let strMessage32  = "strMessage32"
let strMessage33  = "strMessage33"

//mld
let strINVITATIONSAMIS  = "INVITATIONS AMIS"
let strINVITEZVOSAMIS  = "INVITEZ VOS AMIS"
let strSelectionnezToutLeMonde  = "Sélectionnez tout le monde"
let strDescriptionAmisAddScreen  = "Pour partager vos photos, videos, points de géolocalisation, chasses. Invitez vos amis à vous rejoindre sur Naturapass en les sélectionnant ou en inscrivant leur email."
let strAjouterAmisAddScreen  = "Sélectionnez tout le monde"
let strUneConnexionInternetEstRequise  = "Une connexion internet est requise."
let strAdresseIntrouvable  = "Adresse introuvable"
let strMonAgenda  = "mon agenda"
let strRecherche  = "recherche"
let strHistorique  = "historique"
let strInvitations  = "invitations"
let strMur  = "mur"
let strCarte  = "carte"
let strDiscussion  = "discussion"
let strParametres  = "paramètres"
let strInvites  = "invités"
let strInfos  = "infos"
let strAgenda  = "agenda"
let strMesgroupes  = "mes groupes"
let strAmis  = "amis"
let strInviter  = "inviter"
let strFiltres  = "filtres"
let strProfil  = "profil"
let strGeneral  = "général"
let strEmail  = "email"
let strMobile  = "mobile"
let strFavoris  = "favoris"
let strAjoutDunRepere  = "Ajout d'un repère"
let strVousAvezFaitUnePublicationGeo  = "Vous avez fait une publication geolocalisée ici. Retournez sur le mur pour la compléter."
let strMOI  = "Moi"
let strMYFRIEND  = "MYFRIEND"
let strMEMBER  = "MEMBER"
let strSelectionLeTypeDaffichagedeCarte  = "Sélectionnez le type d'affichage de carte que vous désirez"
let strSelectionLeTypeContenu  = "Sélectionnez le type contenu que vous souhaitez faire apparaitre"
let strSelectionVotreStatut  = "Sélectionnez votre statut."
let strFERMER  = "FERMER"
let strSelectionLesReperes  = "Sélectionnez les repères que vous voulez faire apparaître."
let strSelectionLesParticipants  = "Sélectionnez le participants que vous souhaitez faire apparaitre"
let strDEBUTLE  = "DEBUT LE"
let strFINLE  = "FIN LE"
let strRendezVousA  = "RENDEZ-VOUS À"
let strVOIRSURNATURAPASS  = "VOIR SUR NATURAPASS"
let strVOIRSURAUTRESGPS  = "VOIR SUR AUTRES GPS"
let strSerraiJePresent  = "Serrai-je présent ?"
let strINVITERDESNONNATIZ  = "INVITER DES NON-NATIZ"
let strNonNatizDesc1  = "Vous avez 2 solutions pour inscrire des non-natiz à votre chasse :"
let strNonNatizDesc2  = "- soit en leur envoyant un email pour qu’ils s’inscrivent à Naturapass"
let strNonNatizDesc3  = "- soit en les inscrivant vous-même à la main. Ils ne deviendront pas Natiz :-(."
let strSUIVANT  = "SUIVANT"
let strPlaceholder  = "Commentaire (facultatif)"
let strDescriptionPlaceholder  = "Description (facultatif)"
let strAnnulerAgenda  = "Annuler Agenda"
let strDescHelpAgenda  = "Les groupes vous permettent de vous rassembler avec les membres de votre chasse et/ou par centre d’intérêt. \n Ils vous permettent de: \n- discuter et d’échanger des infos entre vous sur le mur de votre groupe, \n - de créer la carte de votre groupe (idéal pour partager des informations cartographiques avec les membres de votre chasse \n- postes, bauge à sanglier, terrier de renard, équipement à réparer...) \n - de lancer des invitations rapidement pour vos battues.\nExemples de groupes : les chasseurs de mon village, les fans de bécasses, les chasseurs à l’arc…"
let strDateDeFin  = "Date de fin"
let strDateDeDebut  = "Date de début"
let strNom  = "Nom"
let strENSAVOIRPLUS  = "EN SAVOIR PLUS ?"
let strINFORMATIONS  = "INFORMATIONS"
let strTYPEDACCES  = "TYPE D’ACCES"
let strLieuDeRendezVous  = "Lieu \nde rendez vous"
let strVousPermet  = "Vous permet de préciser sur une carte le lieu de rendez-vous."
let strINVITERDESPARTICPANTS  = "INVITER DES PARTICPANTS"
let strVousPouvezInviter  = "Vous pouvez inviter des personnes. Si elles sont Natiz, elles recevront une invitation sur leur smartphone."


let strInviterMesAmisNaturapass  = "INVITER MES AMIS NATURAPASS"
let strPourInviterDesAmis  = "Pour inviter des amis à rejoindre votre chasse veuillez les selectionner."
let strInviterDesPersonnes  = "INVITER DES PERSONNES DANS VOTRE NOUVELLE CHASSE"
let strIciVousPouvez  = "Ici vous pouvez inviter:"
let strIensembleDesMembres  = "- I'ensemble des membres d'un de vos chasses en cliquant sur Envoyer."
let strSeulementCertains  = "- Seulenment certains membres de ces chasses en cliquant sur Membres."

let strINVITERDESMEMBRESNATURAPASS  = "INVITER DES MEMBRES NATURAPASS"
let strPourInviterDesMembresNaturapass  = "Pour inviter des membres Naturapass à rejoindre votre chasse, rentrez leur nom."
let strAucunResultat  = "Aucun résultat"
let strLaPersonneQueVousRecherchez  = "La personne que vous recherchez n'est peut-être pas inscrite à Naturapass. Vous pouvez lui envoyer un email pour le prévenir."
let strEmailContentPlaceholder  = "  Votre message"
let strRechercherUnMembre  = "Rechercher un membre"
let strTokenPlaceholder  = "Emails séparés par des ;"
let strAdresseEmailNonValide  = "Adresse e-mail non valide"
let strEnvoyer  = "ENVOYER"
let strInviterDesNonMembrer  = "INVITER DES NON-MEMBRES NATURAPASS"
let strPourLesPersonnesQui  = "Pour les personnes qui ne sont pas inscrites à Naturapass, vous pouvez leur envoyer un email pour les prévenir."
let strSouhaitezVousImporter  = "Souhaitez-vous importer la carte de votre groupe ?"
let strVousPermetDePartager  = "Vous permet de partager les points de votre groupe avec vos invités (postes, miradors,…)."
let strAdministrationDunEvenement  = "ADMINISTRATION D'UN EVENEMENT"
let strModificationParticipant  = "MODIFICATION PARTICIPANT"
let strCommentaire  = "Commentaire"
let strTERMINER  = "TERMINER"
let strListeDeVosInvitations  = "LISTE DE VOS INVITATIONS"
let strVousNavezNiDemande  = "Vous n'avez ni demandé l’accès à  un événement, ni reçu d'invitation"
let strAgendaMesEvenementsPasses  = "AGENDA – MES EVENEMENTS PASSES"
let strMONAGENDA  = "MON AGENDA"
let strAllezVouzParticiper  = "Allez-vous participer à cet événement ?"
let strTousLesEvenements  = "TOUS LES EVENEMENTS"
let strParticipation  = "Participation"
let strSUPPRIMER  = "SUPPRIMER"
let strParametresUtilisateurs  = "PARAMETRES UTILISATEURS"
let strDISCUSSION  = "DISCUSSION"
let strDISCUSSIONS  = "DISCUSSIONS"

let strDiscussionsGroupes  = "DISCUSSIONS GROUPES"
let strDiscussionsChasses  = "DISCUSSIONS CHASSES"
let strToutesLesDiscussions  = "TOUTES LES DISCUSSIONS"
let strToutesLesDiscussionsDeGroupes  = "TOUTES LES DISCUSSIONS DES GROUPES"
let strToutesLesDiscussionsDeChasses  = "TOUTES LES DISCUSSIONS DES CHASSES"
let strPUBLICATION  = "PUBLICATION"
let strRecherchezQuelquun  = "Recherchez quelqu'un"
let strMUR  = "MUR"
let strVouloirSupprimerCeMessage  = "Etes-vous sûr de vouloir supprimer ce message ?"
let strNon  = "Non"
let strAjouterUnCommentaire  = "Ajouter un commentaire"
let strSignaler  = "Signaler"
let strModifier  = "Modifier"
let strSupprimer  = "Supprimer"
let strVouloirSupprimerCettePublication  = "Êtes-vous sûr de vouloir supprimer cette publication ?"
let strVouloirSupprimerCetteComment  = "strVouloirSupprimerCetteComment"

let strTOUS  = "TOUS"
let strFiltrezLesPointsQueVousImprotez  = "FILTREZ LES POINTS QUE VOUS IMPORTEZ"
let strChoisissezLesPointsdeGeo  = "Choisissez les points de géolocalisation que vous voulez importer."
let strTypeDePointGeo  = "TYPE DE POINT GEOLOCALISER"
let strVeuilezSelectionnerPointGeo  = "Veuilez selectionner le type de point geolocaliser que vous souhaitez importer."
let strAjouterCetEvenementDansLagenda  = "Voulez-vous ajouter cet événement dans l’agenda d’un de vos groupes?"
let strOUI  = "OUI"
let strNON  = "NON"
let strRecuperationMotDePasse  = "RÉCUPÉRATION MOT DE PASSE"
let strRenseignerVotreAdresseEmail  = "Veuillez renseigner votre adresse email"
let strVotreAdresseEmail  = "Votre adresse email"
let strAJOUTER  = "AJOUTER"
let strADMINISTRATEUR  = "ADMINISTRATEUR"
let strEXCLUREDESMEMBRES  = "EXCLURE DES MEMBRES"

let strInformationSubLeGroupe  = "INFORMATIONS SUR LE GROUPE"
let strNomDuGroupe  = "Nom du groupe"
let strDescriptionDeVotreGroupe  = "Description de votre groupe"
let strTypeDeGroupe  = "TYPE DE GROUPE"
let strInviterDesMembres  = "INVITER DES MEMBRES"
let strPersonnesArejoindreVotreGroupe  = "Vous pouvez inviter des personnes à rejoindre votre groupe."


let strMessageAccessPrivate  = "Seules les personnes invitées dans votre groupe pourront accéder à votre groupe et en connaîtront l'existence."

let strMessageAccessSemiPrivate  = "Tous les natiz auront accès à votre groupe, mais vous validerez chaque nouvelle inscription.\nVotre groupe sera visible par tout le monde dans la rubrique \"Tous les groupes\"."

let strMessageAccessPublication  = "Tous les natiz auront accès à votre groupe sans restriction. Votre action se limitera à exclure d'éventuels membres indésirables.\nVotre groupe sera visible par tout le monde dans la rubrique \"Tous les groupes\"."
let strPRIVE  = "PRIVÉ"
let strSEMIPRIVE  = "SEMI-PRIVÉ"
let strPPUBLIC  = "PPUBLIC"
let strPourInviterDesAmisRejoindreVotreGroupe  = "Pour inviter des amis à rejoindre votre groupe, veuillez les selectionner."
let strInviterPersonnesGroup  = "INVITER DES PERSONNES DANS VOTRE NOUVEAU GROUPE"
let strIciVousPouvezInviter  = "Ici vous pouvez inviter :"
let strIensembleDesMembresGroup  = "- I'ensemble des membres d'un de vos groupes en cliquant sur Envoyer."
let strSeulementCertainsMembresGroup  = "- seulement certains membres de ces groupes en cliquant sur Membres."
let strMEMBERS  = "MEMBRES"
let strENVOYERATOUS  = "ENVOYER A TOUS"
let strRentrezLeurNome  = "Pour inviter des membres Naturapass à rejoindre votre groupe, rentrez leur nom."
let strContentNonValide  = "Content non valide"
let strAdministrationDuGroupe  = "ADMINISTRATION DU GROUPE"
let strInformations  = "Informations"
let strQuiPeutPublier  = "Qui peut publier"
let strQuiPeutConsulter  = "Qui peut consulter"
let strTypeDacces  = "Type d'accès"
let strInviterDeMembres  = "Inviter des membres"
let strGererLesAdminstrateours  = "Gérer les administrateurs"
let strExclureDesMembres  = "Exclure des membres"
let strREPORT  = "REPORT"
let strInfosAgenda  = "Infos agenda"
let strInfosGroupe  = "Infos groupe"
let strGererLesAdmin  = "Gérer les administrateurs"
let strLesMenbres  = "Les membres"
let strExclureDeMembres  = "Exclure des membres"
let strPersonnesEnAttenteDeVotreValidation  = "PERSONNES EN ATTENTE DE VOTRE VALIDATION"
let strVosDemandesDaccesEnAttent  = "VOS DEMANDES D'ACCÈS EN ATTENTE"
let strRefuser  = "REFUSER"
let strMESGROUPES  = "MES GROUPES"
let strRechercher  = "Rechercher"
let strSearchGroup  = "SEARCHGROUP"

let strAlertCheckEmptyGroupMes  = "Votre réseau n'est pas assez bon pour charger la liste de vos groupes. Veuillez réessayer quand vous aurez une meilleure connexion."
let strDelete_group_content  = "delete_group_content"
let strDelete_group_title  = "delete_group_title"
let strLeave_group_content  = "leave_group_content"
let strDesinscription_Du_Group  = "Désinscription du groupe"
let strAdministrer  = "Administrer"
let strFermer_le_groupe  = "Fermer le groupe"
let strNOTIFICATIONS_SMARTPHONE  = "NOTIFICATIONS SMARTPHONE"

let strDemande_de_validation_de_participation_roup  = "Demande de validation de participation à un group"
let strRefus_de_participation  = "Refus de participation"
let strReponse_commentaire_publication  = "Réponse à un commentaire sur une publication"
let strNouveau_jaime_publication  = "Nouveau j'aime sur une publication"
let strNouveau_commentaire_sur_votre_publication  = "Nouveau commentaire sur votre publication"
let strInvitation_de_participation_groupe  = "Invitation de participation à un groupe"
let strDemande_de_participation_groupe  = "Demande de participation à un groupe"
let strAcceptation_de_participation_groupe  = "Acceptation de participation à un groupe"
let strTOUS_LES_GROUPES  = "TOUS LES GROUPES"

let strTo_Commit  = "To Commit"
let strOn_hold  = "On hold"
let strAAccess  = "Access"
let strSinscrire  = "S'inscrire"
let strVous_avez_ete_invite_dans_ce_group  = "Vous avez été invité dans ce group. Voulez-vous accepter l'invitation ?"

let strPRIVATE  = "PRIVATE"
let strSEMIPRIVATE  = "SEMIPRIVATE"
let strPUBLIC  = "PUBLIC"

let strMEMBRES_DU_GROUPE  = "MEMBRES DU GROUPE"
let strProprietaire  = "Proprietaire"
let strAdministrateurs  = "Administrateurs"
let strMMembres  = "Membres"
let strIInvites  = "Invités"
let strEn_attente_de_validation  = "En attente de validation"
let strMODIFIER_VOTRE_PUBLICATION  = "MODIFIER VOTRE PUBLICATION"
let strFILTRE  = "FILTRE"
let strMES_ADRESSES_FAVORITES  = "MES ADRESSES FAVORITES"

let strPartage_par_defaut  = "Partage par défaut"
let strAmis_visible  = "Amis visible"
let strNATIZ_QUI_AIMENT_VOTRE_PUBLICATION  = "NATIZ QUI AIMENT VOTRE PUBLICATION"
let strPublication  = "Publication"
let strNotifications_email  = "Notifications email"
let strNotifications_smartphones  = "Notifications smartphones"
let strAdresses_favorites  = "Adresses favorites"
let strPublications_favorites  = "Publications favorites"

let strLa_demande_a_expire  = "La demande a expiré."
let strNOTIFICATIONS  = "NOTIFICATIONS"
let strMES_FAVORIS  = "MES FAVORIS"
let strMes_adresse_favorites  = "Mes adresse favorites"
let strMes_publications_favorites  = "Mes publications favorites"
let strMES_PUBLICATIONS_FAVORITES  = "MES PUBLICATIONS FAVORITES"
let strMON_PROFIL  = "MON PROFIL"
let strCivilite  = "Civilité (fac.)"
let strPrenom  = "Prénom"
let strEEmail  = "Email"
let strDate_de_naissance  = "Date de naissance"
let strNOTIFICATIONS_EMAIL  = "NOTIFICATIONS EMAIL"

let strCHANGER_DE_MOT_DE_PASSE  = "CHANGER DE MOT DE PASSE"
let strMot_de_passe_actuel  = "Mot de passe actuel"
let strNouveau_mot_de_passe  = "Nouveau mot de passe"
let strVerification  = "Vérification"
let strUpdate_Alert  = "Update_Alert"
let strPassword_Alert  = "Password_Alert"
let strOldPassword_Alert  = "OldPassword_Alert"
let strMA_PHOTO_DE_PROFIL  = "MA PHOTO DE PROFIL"
let strMODIFIER  = "MODIFIER"
let strPROFIL  = "PROFIL"
let strGENERAL  = "GENERAL"
let strPProfil  = "Profil"
let strGGeneral  = "Général"
let strFFavoris  = "Favoris"
let strUn_email_envoye  = "Un email a été envoyé  à votre adresse électronique"
let strChoose_Avatar  = "Choose_Avatar"
let strTake_Photo  = "Take_Photo"
let strChoose_Library  = "Choose_Library"
let strCancel  = "Cancel"
let strSorry_No_Camera  = "Sorry_No_Camera"
let strPublier_une_photo  = "Publier une photo"
let strPrendre_une_photo  = "Prendre une photo"
let strChoisir_dans_la_bibliotheque  = "Choisir dans la bibliothèque"
let strAAnnuler  = "Annuler"
let strAjout_de_la_specification_aux_favorisr  = "Ajout de la spécification aux favoris"
let strNom_du_favori  = "Nom du favori"
let strENREGISTRER  = "ENREGISTRER"
let strAlert_Message  = "Alert_Message"
let strNName  = "Name"
let strVotre_wifi_nest_pas_active  = "Votre wifi n'est pas activé. Pour plus de précision de votre géolocalisation, veuillez l'activer."
let strGERER_MON_PARTAGE  = "GÉRER MON PARTAGE"
let strAAmis  = "Amis"
let strTous_les_natiz  = "MEMBER"
let strPARTAGER_AVEC  = "PARTAGER AVEC"
let strSentinelle  = "Sentinelle"
let strPrecisez_sur_quoi_porte_votre_observation  = "Précisez sur quoi porte votre observation"
let strPlus_danimaux  = "Plus d'animaux"
let strElargir_la_selection  = "Elargir la sélection"
let strIl_ny_a_pas_danimaux_dans_notre_base  = "Il n'y a pas d'animaux dans notre base qui correspondent à votre recherche.\nVeuillez ré-essayer.\nPour rappel, notre base ne contient que les mammifères et les oiseaux."
let strChoisir_une_fiche  = "-- Choisir une fiche --"
let strSouhaitezvous_utiliser_un_favori  = "Souhaitez-vous utiliser un favori ?"
let strSelectionnez_la_couleur_de_votre_repere  = "Sélectionnez la couleur de votre repère"
let strFacultatif  = "(facultatif)"
let strSelectionnez_les_informations  = "Sélectionnez les informations que vous voulez garder en mémoire"
let strLegende  = "Legende"
let strCouleur  = "Couleur"
let strPrecisions  = "Précisions"
let strFiche  = "Fiche"
let strPartage  = "Partage"
let strMoi  = "Moi"
let strGroupes  = "Groupes"
let strAAgenda  = "Agenda"
let strFAVORIS  = "FAVORIS"
let strRetrouvez_ici_toutes_vos_informations  = "Retrouvez ici toutes vos informations, vous pouvez les modifier"
let strPour_gerer_vos_adresses_favorites  = "Pour gérer vos adresses favorites, rendez-vous dans les paramètres \nen cliquant ici"
let strEntrez_une_legende_qui_apparaitra_sur_la_carte  = "Entrez une légende qui apparaitra sur la carte"
let strLegende_carte  = "Légende carte"
let strSuppression_favori  = "Suppression favori"
let strSupprimer_ce_favori_de_vos_publications_favorites  = "Etes-vous sûr de vouloir supprimer ce favori de vos publications favorites?"
let strVotre_publication_succes  = "Votre publication a été créée avec succès"

let strVous_pouvez_suivre_son_avancement  = "Vous pouvez suivre son avancement en cliquant sur l'icone        de la barre"
let strAJOUTER_AUX_FAVORIS  = "   AJOUTER AUX FAVORIS"
let strVoulezvous_partager_cette_publication  = "Voulez-vous partager cette  publication ?"
let strVous_garderez_cette_publication_pour  = "Si \"non\", vous garderez cette publication pour vous.\nOn a le droit d'avoir ses secrets !"
let strVoulezvous_preciser_votre_publication  = "Voulez-vous préciser\nvotre publication ?"
let strExemple_mirador  = "Exemple : mirador à réparer, tir de sanglier, dégâts de nuisible..."
let strEntre_un_nom_pour_votre_adresse  = "Entre un nom pour\nvotre adresse"
let strEx_Cabane_de_agenda  = "Ex: Cabane de agenda"

let strVeuillez_entrer_une_adresse  = "Veuillez entrer une adresse."
let strPUBLIER_UN_MESSAGE  = "PUBLIER UN MESSAGE"
let strTapez_votre_texte  = "Tapez votre texte..."

let strEmail_Address  = "Email_Address"
let strFirstName  = "FirstName"
let strPPassword  = "Password"
let strChoose_Civility  = "Choose_Civility"
let strRegister_Title  = "Register_Title"
let strRegister_Condition  = "Register_Condition"
let strChoose_Photo  = "Choose_Photo"
let strChange  = "Change"

let strINVALIDEMAIL  = "INVALIDEMAIL"

let strImage_Missing  = "Image-Missing"
let strERROR  = "ERROR"
let strCGU_unchecked  = "CGU_unchecked"
let strRegistered_Successfully  = "Registered Successfully"
let strDONE  = "DONE"
let strCivilite0  = "Civilite0"
let strCivilite1  = "Civilite1"
let strCivilite2  = "Civilite2"
let strVotre_demande_envoyee  = "Votre demande a été envoyée"
let strChasse_de_vos_pratiques  = "Etes-vous sûr de vouloir supprimer ce type de chasse de vos pratiques?"
let strVouloir_supprimer_ce_type_de_chasse  = "Etes-vous sûr de vouloir supprimer ce type de chasse ?"
let strAMIS  = "AMIS"
let strAIDE  = "AIDE"
let strDDescription  = "Description"
let strAnnuler_Groups  = "Annuler Groups"


let strINVITEZ_DES_NON_MEMBRES_NATURAPASS  = "INVITEZ DES NON-MEMBRES NATURAPASS"
let strPour_les_personnes_qui_ne_sont_pas_inscrites  = "Pour les personnes qui ne sont pas inscrites à Naturapass, vous pouvez leur envoyer un email pour les prévenir."

let strRateAppStore  = "Merci de donner votre avis sur Naturapass sur Appstore."
let strPreciser_au_mieux_votre_profil_vous_permettra  = "Naturapass vous permet de rencontrer d'autres Natiz. Préciser au mieux votre profil vous permettra de faire marcher au mieux cette fonctionnalité."

let strDans_quels_pays_chassez  = "Dans quels pays chassez-vous ou avez-vous chassé?\n"

let strQuel_type_de_chasse_pratiquez  = "Quel type de chasse pratiquez-vous?\n"
let strQuel_type_de_chasse_aimeriez  = "Quel type de chasse aimeriez-vous pratiquer?\n"
let strSuppression_dune_ville  = "Suppression d'une ville"
let strVouloir_supprimer_cette_ville  = "Etes-vous sûr de vouloir supprimer cette ville?"

let strSuppression_dun_pays  = "Suppression d'un pays"
let strSupprimer_ce_pays_de_vos_pays_de_chasse  = "Etes-vous sûr de vouloir supprimer ce pays de vos pays de chasse?"
let strMes_amis  = "Amis"
let strAutres_Natiz  = "Autres Natiz"
let strNon_Natiz  = "Non-Natiz"
let strJe_participe  = "Je participe"
let strJe_ne_sais_pas  = "Je ne sais pas"
let strJe_ne_participe_pas  = "Je ne participe pas"
let strENVOYE  = "ENVOYÉ"
let strVous_avez_envoye_invitation  = "Vous avez envoyé %d invitation."
let strVous_avez_envoyer_invitations  = "Vous avez envoyer %d invitations."
let strOther_peoples  = "other peoples"
let strValider_votre_liste  = "Valider votre liste"
let strAppuyez_sur_le_bouton  = "Appuyez sur le bouton \"suivant\" pour inviter les personnes selectionnées."

let strTapez_votre_texte_personnalise_ici  = "Tapez votre texte personnalisé ici"
let strINVITEZ_DES_AMIS  = "INVITEZ DES AMIS"
let strRedigez_un_message_personnalise  = "Rédigez un message personnalisé pour vos amis ou laisser le message par défaut."
let strLenvoi_de_vos_invitations  = "L'envoi de vos invitations s'est fait avec succes"
let strTermine  = "Terminé"
let strINVALID_ERROR  = "INVALID_ERROR"
let strVous_navez_ni_demande_lacces  = "Vous n'avez ni demandé l’accès à  un événement, ni reçu d'invitation"
let strAdministre_par  = "Administré par"
let strPersonnes_en_attente_de_validation  = "Personnes en attente de validation"
let strPersonne_en_attente_de_validation  = "Personne en attente de validation"
let strAdministrateur  = "Administrateur"

let strNon_membres  = "Non-membres"
let strA_VALIDER  = "À VALIDER"
let strEN_ATTENTE  = "EN ATTENTE"
let strACCEDER  = "ACCÉDER"
let strREJOINDRE  = "REJOINDRE"
let strParticipants  = "participants"
let strCommentaire_sur_votre_publication  = "Commentaire sur votre publication"
let strResponse_a_votre_commentaire  = "Résponse à votre commentaire"
let strInvitation_pour_etre_ami  = "Invitation pour etre ami"

let strInvitation_rejoindre_un_group  = "Invitation à rejoindre un group"
let strNouvelle_publication_dans_un_group  = "Nouvelle(s) publication(s) dans un group"

let strConfirmation_d_amitie  = "Confirmation d amitie"
let strDemande_d_amitie  = "Demande d amitie"
let strReponse_commentaire_sur_une_publication  = "Reponse a un commentaire sur une publication"
let strNouveau_aime_sur_une_publication  = "Nouveau j aime sur une publication"
let strQUI_PEUT_PUBLIER  = "QUI PEUT PUBLIER?"
let strVous_pouvez_limiter_la_publication_agenda  = "Habituellement, tout le monde peut publier dans un agenda, mais si besoin, vous pouvez limiter la publication aux administrateurs. Pour ajouter des administrateurs, allez dans les paramètres du agenda."

let strQUI_PEUT_CONSULTER  = "QUI PEUT CONSULTER?"
let strVous_pouvez_limiter_la_consultation_agenda  = "Habituellement, tout le monde peut consulter dans un agenda, mais si besoin, vous pouvez limiter la consultation aux administrateurs. Pour ajouter des administrateurs, allez dans les paramètres du agenda."
let strTOUS_LES_MEMBRES  = "TOUS LES MEMBRES"
let strADMINISTRATEURS  = "ADMINISTRATEURS"
let strInscription_manuelle  = "Inscription manuelle"
let strEnvoi_demails  = "Envoi d'emails"
let strIMPORTER_DES_POINTS_GEOLOCALISES  = "IMPORTER DES POINTS GEOLOCALISES"
let strImporter_point_de_geolocalisation  = "Sélectionnez le groupe dont vous voulez importer les point de géolocalisation."

let strType_point_geolocaliser_que_vous_souhaitez_importer  = "Veuillez selectionner le Type de point geolocaliser que vous souhaitez importer"
let strSelectionner_une_partie_de_cette_specification  = "Vous pouvez selectionner une partie de cette specification"
let strVivant  = "Vivant"
let strTraces_empreintes  = "Traces empreintes"
let strBlesses  = "Blessés"
let strThis_publication_has_content_issue  = "This publication has content issue!"
let strERRORTITLE  = "ERRORTITLE"
let strERRORDESCRIPTION  = "ERRORDESCRIPTION"
let strINCONVIENINENCE  = "INCONVIENINENCE"
let strSupprimer_de_votre_damis  = "Etes-vous sûr de vouloir supprimer %@ de votre liste d'amis?"
let strAmis_de  = "Amis de"
let strAmis_en_commun_avec  = "Amis en commun avec"
let strRejoindre_un_group_public  = "Rejoindre_un_group_public"
let strRejoindre_un_group  = "Rejoindre_un_group"
let strVous_pouvez_limiter_la_publication_group  = "Habituellement, tout le monde peut publier dans un groupe, mais si besoin, vous pouvez limiter la publication aux administrateurs. Pour ajouter des administrateurs, allez dans les paramètres du groupe."
let strVous_pouvez_limiter_la_consultation_group  = "Habituellement, tout le monde peut consulter dans un groupe, mais si besoin, vous pouvez limiter la consultation aux administrateurs. Pour ajouter des administrateurs, allez dans les paramètres du groupe."
let stramis_en_commun  = "amis en commun"
let strLogin_Title  = "Login_Title"
let strForgot_Password  = "Forgot_Password"
let strOr  = "Or"
let strReset_Connection  = "Reset-Connection"
let strLogin  = "Login"
let strRegister  = "Register"
let strVoulez_vous_blacklister  = "Voulez-vous blacklister \n %@. \n\nVous ne verrez plus ses publications sur le mur. Vous pourrez l'enlever de votre liste noire en vous rendant dans paramètres."
let NO_FAV_PUBLICATION  = "Vous n'avez actuellement aucun publication favorite"
let strOU_CHASSEZ_VOUS  = "OÙ CHASSEZ-VOUS ?\n\n"
let strMoteur_de_recherche_des_villes  = "Moteur de recherche des villes"
let strMoteur_de_recheche_pays  = "Moteur de recheche pays"

let strVOS_CHIENS  = "VOS CHIENS"
let strVOS_ARMES  = "VOS ARMES"
let strVOS_PAPIERS  = "VOS PAPIERS"
let strVouloir_supprimer_ce_chien  = "Etes-vous sur de vouloir supprimer ce chien"
let strVouloir_supprimer_cette_arme  = "Etes-vous sur de vouloir supprimer cette arme"
let strVouloir_supprimer_les_informations_liees_papier  = "Etes-vous sur de vouloir supprimer les informations liées à ce papier"
let strVoir  = "Voir"

let strAjout_ou_modification_chien  = "Ajout ou modification d'un chien"
let strModification_arme  = "Modification d'une arme"
let strAjout_arme  = "Ajout d'une arme"
let strSexe  = "Sexe"
let strFemale  = "Female"
let strMale  = "Male"
let strTType  = "Type"
let strCarabine  = "Carabine"
let strFusil  = "Fusil"
let strNom_de_larme  = "Nom de l'arme"
let strMarque  = "Marque"
let strCalibre  = "Calibre"
let strRace  = "Race"
let strEtes_vous_sur_de_vouloir_supprimer  = "Etes-vous sur de vouloir supprimer ?"

let strNom_du_chien  = "Nom du chien"
let strModification_dun_papier  = "Modification d'un papier"
let strAjout_dun_papier  = "Ajout d'un papier"
let strEntrer_un_texte  = "Entrer un texte"
let strRACE  = "RACE"
let strSEXE  = "SEXE"
let strDATE_DE_NAISANCE  = "DATE DE NAISANCE"
let strTYPE  = "TYPE"
let strBRAND  = "BRAND"
let strCALIBRE  = "CALIBRE"
let strFEMALE  = "FEMALE"
let strMALE  = "MALE"

let strPRENDRE_UNE_PHOTO  = "PRENDRE UNE PHOTO"
let strPRENDRE_UNE_VIDEO  = "PRENDRE UNE VIDÉO"
let strCHOISIR_DANS_MA_BIBLIOTHEQUE  = "CHOISIR DANS MA BIBLIOTHÈQUE"
let strVeuillez_remplir_le_champs  = "Veuillez remplir le champs \"%@\" qui est obligatoire."
let strMMembre  = "membre"
let strEt_un_autre_membre  = "et un autre membre"
let strPOSTVIDEO  = "POSTVIDEO"
let strFilmer_une_video  = "Filmer une video"
let strVotre_publication_modifiee  = "Votre publication a été modifiée."
let strVoulez_vous_faire_modifications  = "Voulez-vous faire d'autres modifications ?"
let strBlacklister  = "Blacklister"

let strMenu_item_Blacklister  = "Menu_item_Blacklister"
let strVoulez_vous_vraiment_supprimer  = "Voulez-vous vraiment supprimer cet élément?"
let strAmi  = "ami"
let strMessages_limites_aux_administrateurs  = "strMessages_limites_aux_administrateurs"
let strMembres_blacklister  = "Membres blacklister"
let strMEMBRES_BLACKLISTER  = "MEMBRES BLACKLISTER"
let strDELETE_BLACKLISTER  = "DELETE_BLACKLISTER"
let strTryAgainRequest  = "strTryAgainRequest"
let strWarningNoBlocker  = "strWarningNoBlocker"
let strZeroInvitaionGroup  = "strZeroInvitaionGroup"
let strZeroInvitaionAmis  = "strZeroInvitaionAmis"
let strDownload  = "Download"
let strNewVertionAvailale  = "strNewVertionAvailale"
let strIgnore  = "Ignore"
let strNewInThisVersion  = "strNewInThisVersion"
