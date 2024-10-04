import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/models/basket.dart';
import 'package:new_app/models/buteur.dart';
import 'package:new_app/models/commentaires.dart';
import 'package:new_app/models/commission.dart';
import 'package:new_app/models/enums/sport_type.dart';
import 'package:new_app/models/equipe.dart';
import 'package:new_app/models/football.dart';
import 'package:new_app/models/jeu.dart';
import 'package:new_app/models/jeux_esprit.dart';
import 'package:new_app/models/joueur.dart';
import 'package:new_app/models/joueur_jeu.dart';
import 'package:new_app/models/match.dart';
import 'package:new_app/models/session_jeu.dart';
import 'package:new_app/models/utilisateur.dart';
import 'package:new_app/models/volleyball.dart';

class JeuService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> jeuxCollection =
      FirebaseFirestore.instance.collection("JEUX");

  Future<List<Jeu>> getAllJeux() async {
    List<Jeu> list = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await jeuxCollection.get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var d in data) {
        list.add(Jeu.fromJson(d));
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<String> postJeu(dynamic football) async {
    try {
      await jeuxCollection
          .doc(football.equipeA.nom +
              " VS " +
              football.equipeB.nom +
              football.date.toString())
          .set(football.toJson());
      return "OK";
    } catch (e) {
      return "Erreur lors de la création du match : $e";
    }
  }

  Future<Jeu?> getJeuId(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await jeuxCollection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        return Jeu.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Jeu?> postSessionJeu(String idJeu, String lieu) async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;

      // Récupérer l'utilisateur avec l'email
      QuerySnapshot userSnapshot = await _firestore
          .collection("USER")
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) return null;

      Map<String, dynamic> userData =
          userSnapshot.docs.first.data() as Map<String, dynamic>;
      Utilisateur utilisateur = Utilisateur.fromJson(userData);

      // Rechercher le document de jeu avec l'id spécifié
      QuerySnapshot jeuxSnapshot =
          await jeuxCollection.where('id', isEqualTo: idJeu).limit(1).get();

      if (jeuxSnapshot.docs.isEmpty) {
        print("Jeu non trouvé");
        return null;
      }

      // Récupérer la référence et les données du document trouvé
      DocumentReference matchDoc = jeuxSnapshot.docs.first.reference;
      Map<String, dynamic> jeuData =
          jeuxSnapshot.docs.first.data() as Map<String, dynamic>;

      // Créer une nouvelle session
      SessionJeu nouvelleSession = SessionJeu(
        date: DateTime.now(),
        lieu: lieu,
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(), // ID de la session sera généré par Firestore
        joueurs: [], // Liste vide de joueurs initialement
        creatorId: utilisateur.id!, // ID de l'utilisateur créateur
      );

      // Créer un nouveau joueur pour l'utilisateur qui crée la session
      JoueurJeu joueurCreant = JoueurJeu(
        id: utilisateur.id!,
        waiting: true,
        email: email,
        prenom: utilisateur.prenom,
        nom: utilisateur.nom,
      );

      // Ajouter le joueur à la liste des joueurs
      nouvelleSession.joueurs.add(joueurCreant);

      // Convertir la nouvelle session en JSON
      Map<String, dynamic> sessionData = nouvelleSession.toJson();

      // Ajouter la session à la liste des sessions existantes
      List<dynamic> sessions = jeuData['sessions'] ?? [];
      sessions.add(sessionData);

      // Mettre à jour le document du jeu avec la nouvelle session
      await matchDoc.update({
        'sessions': sessions,
      });

      // Récupérer les données mises à jour
      DocumentSnapshot querySnapshot = await matchDoc.get();
      return Jeu.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Jeu?> rejoindreSessionJeu(String idJeu, String idSession) async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;

      // Récupérer l'utilisateur avec l'email
      QuerySnapshot userSnapshot = await _firestore
          .collection("USER")
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) return null;

      Map<String, dynamic> userData =
          userSnapshot.docs.first.data() as Map<String, dynamic>;
      Utilisateur utilisateur = Utilisateur.fromJson(userData);

      // Rechercher le document de jeu avec l'id spécifié
      QuerySnapshot jeuxSnapshot =
          await jeuxCollection.where('id', isEqualTo: idJeu).limit(1).get();

      if (jeuxSnapshot.docs.isEmpty) {
        print("Jeu non trouvé");
        return null;
      }

      // Récupérer la référence et les données du document trouvé
      DocumentReference matchDoc = jeuxSnapshot.docs.first.reference;
      Map<String, dynamic> jeuData =
          jeuxSnapshot.docs.first.data() as Map<String, dynamic>;

      // Récupérer les sessions dans le jeu
      List<dynamic> sessions = jeuData['sessions'] ?? [];
      Map<String, dynamic>? sessionToJoin;

      // Trouver la session à rejoindre
      for (var session in sessions) {
        if (session['id'] == idSession) {
          sessionToJoin = session;
          break;
        }
      }

      if (sessionToJoin == null) {
        print("Session non trouvée");
        return null;
      }

      // Créer un nouveau joueur pour l'utilisateur qui rejoint la session
      JoueurJeu nouveauJoueur = JoueurJeu(
        id: utilisateur.id!,
        waiting: true,
        email: email,
        prenom: utilisateur.prenom,
        nom: utilisateur.nom,
      );

      // Ajouter le joueur à la liste des joueurs de la session
      List<dynamic> joueurs = sessionToJoin['joueurs'] ?? [];
      bool dejaPresent = joueurs.any((j) => j['email'] == email);

      if (!dejaPresent) {
        joueurs.add(nouveauJoueur.toJson());
      }

      sessionToJoin['joueurs'] = joueurs;

      // Mettre à jour uniquement la session concernée
      int indexSession =
          sessions.indexWhere((session) => session['id'] == idSession);
      if (indexSession != -1) {
        sessions[indexSession] = sessionToJoin;
      }

      // Mettre à jour le document du jeu avec la session modifiée
      await matchDoc.update({
        'sessions': sessions,
      });

      // Récupérer les données mises à jour
      DocumentSnapshot querySnapshot = await matchDoc.get();
      return Jeu.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Jeu?> quitterSessionJeu(String idJeu, String idSession) async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;

      // Rechercher le document de jeu avec l'id spécifié
      QuerySnapshot jeuxSnapshot =
          await jeuxCollection.where('id', isEqualTo: idJeu).limit(1).get();

      if (jeuxSnapshot.docs.isEmpty) {
        print("Jeu non trouvé");
        return null;
      }

      // Récupérer la référence et les données du document trouvé
      DocumentReference matchDoc = jeuxSnapshot.docs.first.reference;
      Map<String, dynamic> jeuData =
          jeuxSnapshot.docs.first.data() as Map<String, dynamic>;

      // Récupérer les sessions dans le jeu
      List<dynamic> sessions = jeuData['sessions'] ?? [];
      Map<String, dynamic>? sessionToLeave;

      // Trouver la session à quitter
      for (var session in sessions) {
        if (session['id'] == idSession) {
          sessionToLeave = session;
          break;
        }
      }

      if (sessionToLeave == null) {
        print("Session non trouvée");
        return null;
      }

      // Retirer le joueur de la liste des joueurs de la session
      List<dynamic> joueurs = sessionToLeave['joueurs'] ?? [];
      joueurs.removeWhere((joueur) => joueur['email'] == email);

      sessionToLeave['joueurs'] = joueurs;

      // Mettre à jour uniquement la session concernée
      int indexSession =
          sessions.indexWhere((session) => session['id'] == idSession);
      if (indexSession != -1) {
        sessions[indexSession] = sessionToLeave;
      }

      // Mettre à jour le document du jeu avec la session modifiée
      await matchDoc.update({
        'sessions': sessions,
      });

      // Récupérer les données mises à jour
      DocumentSnapshot querySnapshot = await matchDoc.get();
      return Jeu.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Jeu?> deleteSessionJeu(String idJeu, SessionJeu session) async {
    try {
      // Rechercher le document de jeu avec l'id spécifié
      QuerySnapshot jeuxSnapshot =
          await jeuxCollection.where('id', isEqualTo: idJeu).limit(1).get();

      if (jeuxSnapshot.docs.isEmpty) {
        print("Jeu non trouvé");
        return null;
      }

      // Récupérer la référence et les données du document trouvé
      DocumentReference matchDoc = jeuxSnapshot.docs.first.reference;
      Map<String, dynamic> jeuData =
          jeuxSnapshot.docs.first.data() as Map<String, dynamic>;

      // Récupérer les sessions dans le jeu
      List<dynamic> sessions = jeuData['sessions'] ?? [];

      // Vérifier si la session à supprimer existe
      if (sessions.isNotEmpty) {
        // Supprimer la session spécifiée
        sessions.removeWhere((s) => s['id'] == session.id);

        // Mettre à jour le document du jeu avec les sessions modifiées
        await matchDoc.update({
          'sessions':
              sessions, // Remplacer l'ensemble des sessions mises à jour
        });

        // Récupérer les données mises à jour
        DocumentSnapshot querySnapshot = await matchDoc.get();

        return Jeu.fromJson(querySnapshot.data() as Map<String, dynamic>);
      } else {
        print("Aucune session trouvée");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Football?> updateStatistique(
      String matchId, String libelle, int value) async {
    try {
      DocumentReference matchDoc = _firestore.collection("MATCH").doc(matchId);
      await matchDoc.update(
        {"statistiques.$libelle": FieldValue.increment(value)},
      );

      DocumentSnapshot querySnapshot = await matchDoc.get();

      return Football.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Football?> addButeur(String matchId, Joueur joueur, int minute,
      String libelleScore, String libelleBut,
      [int increment = 1]) async {
    try {
      DocumentReference matchDoc = _firestore.collection("MATCH").doc(matchId);
      But but = But(
          joueur: joueur,
          id: DateTime.now().toString(),
          date: DateTime.now(),
          minute: minute);
      await matchDoc.update(
        {
          libelleBut: FieldValue.arrayUnion([but.toJson()]),
          libelleScore: FieldValue.increment(increment)
        },
      );

      DocumentSnapshot querySnapshot = await matchDoc.get();
      print(querySnapshot.data());

      return Football.fromJson(querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
