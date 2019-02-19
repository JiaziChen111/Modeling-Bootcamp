%% BCRG - OGR: Mission d�assistance technique en analyse 
%% et pr�vision macro�conomiques 
% a1_model_data: Proc�d�r la base de donn�es
%% M�nage
clear all
close all
clc

% Cr�er une dossier pour les r�sultats
resDir  = 'results\a1_model_data';
[~,~,~] = mkdir(resDir);

% Ajouter la dossier des donn�es au Search PAth
addpath('donnees');

%% Charger les donn�es
disp('*** Chargez les donn�es...')
dm = dbload('db_monthly.csv','delimiter',';');
dy = dbload('db_yearly.csv','delimiter',';');
dx = dbload('db_external.csv','delimiter',';');

% Base de donn�es pour le modele
dobs.obs_l_y        = 100*log(convert(dy.pib_reel,'q'));
dobs.obs_l_ym       = 100*log(convert(dy.GDP_sec,'q'));
dobs.obs_l_yxm      = 100*log(convert(sum([dy.GDP_prim,dy.GDP_tert,dy.GDP_DTI],2),'q'));
dobs.obs_dl_cpi     = diff(100*log(convert(x12(dm.cpi),'q')),-1)*4;
dobs.obs_l_s        = 0.5*100*log(convert(dm.usd_gnf_p,'q')) + 0.5*100*log(convert(dm.usd_gnf,'q'));
dobs.obs_l_cpif     = 100*log(dx.cpi_us);
dobs.obs_i_f        = 100*log(1+dx.i_fed_us/100);
dobs.obs_l_y_gap_f  = dx.l_y_us_gap;
dobs.obs_rf_tnd     = dx.r_fed_us_tnd;

%% D�finir les intervalles de la tracage (? utiliser dans tous les codes suivants)
firstHist = qq(2009,1);
lastHist  = qqtoday()-1;
firstFore = lastHist+1;
lastFore  = firstFore+5*4;

% D�finissez l'interval de filtrage. Nous sp�cifions l'interval que nous voulons ex�cuter le filtre de Kalman, 
rngFilt     = firstHist:lastHist;
rngFcast    = firstFore:lastFore;
plot_hlight = firstFore:lastFore;

% Enregistrer les r�sultats
save([resDir filesep 'observed_db.mat'],'dobs','firstHist','lastHist',...
                                                                'firstFore','lastFore',...
                                                           'rngFilt','rngFcast');
disp('*** Fait!')