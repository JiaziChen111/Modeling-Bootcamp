%% BCRG - OGR: Mission d�assistance technique en analyse 
%% et pr�vision macro�conomiques 
% a2_read_model: Lire le modele

%% M�nage
clear all
close all
clc

% Cr�er une dossier pour les r�sultats
resDir = 'results\a2_read_model';
[~,~,~] = mkdir(resDir);

% Ajouter la dossier des donn�es au Chemin de Recherche
addpath('donnees');


%% Lire le modele
% Le command 'model' lit le fichier texte 'model.mod' (qui contient les �quations du mod?le), 
% attribue les param?tres et valeurs de tendance pr�d�finis  
% et transforme le mod?le pour l'alg?bre matricielle. Le mod?le transform� est �crit dans l'objet 'm'.
m = model('gn.mod','linear',true);

% Le command 'solve' prend le mod?le sauvegard� dans l'objet 'm' et r�sout le mod?le
% pour sa forme r�duite (en utilisant l'algorithme Blanchard-Kahn). La forme r�duite est
% �crit dans l'objet 'm'
m = solve(m);

% Command 'sstate' prend le mod?le r�solu dans l'objet 'm', calcule l'�tat
% d'�quilibre du mod?le et �crit tout dans l'objet 'm'. 
% Tapez 'mss' dans la fen?tre de commande du Matlab pour afficher les valeurs de l'�tat stationnaire.
m = sstate(m);
mss = get(m,'sstate');

% V�rifier l'�tat d'�quilibre du mod?le
[flag resids listeq] = chksstate(m);
if flag == 0
    err = sprintf('Le mod?le n''a pas un �tat stable appropri� pour les �quations suivantes.:\n %s\n',listeq{:});
    error(err);
end

fprintf('Parfait, votre modele fonctionne! \n')

% Enregistrer le modele
save([resDir filesep 'model.mat'],'m');

