function imgSintetizata = realizeazaSintezaTexturii(parametri)

dimBloc = parametri.dimensiuneBloc;
nrBlocuri = parametri.nrBlocuri;

[inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = size(parametri.texturaInitiala);
H = inaltimeTexturaInitiala;
W = latimeTexturaInitiala;
c = nrCanale;

H2 = parametri.dimensiuneTexturaSintetizata(1);
W2 = parametri.dimensiuneTexturaSintetizata(2);
overlap = parametri.portiuneSuprapunere;

% o imagine este o matrice cu 3 dimensiuni: inaltime x latime x nrCanale
% variabila blocuri - matrice cu 4 dimensiuni: punem fiecare bloc (portiune din textura initiala) 
% unul peste altul 
dims = [dimBloc dimBloc c nrBlocuri];
blocuri = uint8(zeros(dims(1), dims(2),dims(3),dims(4)));

%selecteaza blocuri aleatoare din textura initiala
%genereaza (in maniera vectoriala) punctul din stanga sus al blocurilor
y = randi(H-dimBloc+1,nrBlocuri,1);
x = randi(W-dimBloc+1,nrBlocuri,1);
%extrage portiunea din textura initiala continand blocul
for i =1:nrBlocuri
    blocuri(:,:,:,i) = parametri.texturaInitiala(y(i):y(i)+dimBloc-1,x(i):x(i)+dimBloc-1,:);
end

imgSintetizata = uint8(zeros(H2,W2,c));
nrBlocuriY = ceil(size(imgSintetizata,1)/dimBloc);
nrBlocuriX = ceil(size(imgSintetizata,2)/dimBloc);
imgSintetizataMaiMare = uint8(zeros(nrBlocuriY * dimBloc,nrBlocuriX * dimBloc,size(parametri.texturaInitiala,3)));

switch parametri.metodaSinteza
    
    case 'blocuriAleatoare'
        %%
        %completeaza imaginea de obtinut cu blocuri aleatoare
        for y=1:nrBlocuriY
            for x=1:nrBlocuriX
                indice = randi(nrBlocuri);
                imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:)=blocuri(:,:,:,indice);
            end
        end
        
        imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
        
        figure, imshow(parametri.texturaInitiala)
        figure, imshow(imgSintetizata);
        title('Rezultat obtinut pentru blocuri selectatate aleator');
        return

    
    case 'eroareSuprapunere'
        %%
        %completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere         
	case 'frontieraCostMinim'
        %
        %completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere + forntiera de cost minim
        
       
end
       
    
