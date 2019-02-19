%% BCRG - OGR: Mission d�assistance technique en analyse 
%% et pr�vision macro�conomiques 
% gn_driver: driver pour executer tous les codes en une clique

%% M�nage
clear all
close all 
clc

%% Executer les codes pour la prevision
a0_screening_report;    % Pr�parer un rapport pour les faits stylis�
a1_model_data;          % Lire la base de donn�es, transformes les donn�es brut en variables du modele
a2_read_model;          % Lire et r�soudre le modele
a3_run_filter;          % Ex�cuter le filtre du Kalman
a4_report_filter;       % Pr�pare un rapport sur les r�sultats de la filtration

% Codes auxilliaire pour la calibration
b1_analyze_model;       % Pr�parer des rapports pour analyser le modele: FRI, decomposition de la variance
b2_run_histsim;         % Preparer un rapport pour examiner la performance historique du modele