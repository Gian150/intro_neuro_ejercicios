%Inicializamos la pantalla
screenNum=0;
res=[1280 1024];
clrdepth=32;
[wPtr,rect]=Screen('OpenWindow',screenNum,0,[0 0 res(1) res(2)],clrdepth);
%Colores
black=BlackIndex(wPtr);
white = WhiteIndex(wPtr);
gray = [128 128 128];

files = dir('Imagenes');  % Conseguimos todos los archivos del directorio
fileSizes = size(files);  % Cantidad de archivos del directorio
cantArchivos = fileSizes(1); 
vImg = []

% Los primeros 2 archivos del directorio son '.' y '..'. Estos dos no nos
% sirven y los salteamos, el resto asumimos que son todas imagenes jpg y
% metemos todos los nombres en un vector
for c = 3:cantArchivos
   vImg = cat(1,vImg,[files(c).name])
end
 
cantImagenes = cantArchivos - 2;  %La cantidad de imagenes del directorio

resultados = [];
counter = 0;
HideCursor;

while(counter < 1)
   
    infoInstancia = [];    % [ sexo_sujeto, cue, imgD, imgI, responseCue, Rta, Tiempo ]
    
    
    %%%%%%%%% TODO %%%%%%%%%%%%%
    %%%%% AGREGAR QUE EL USUARIO INDIQUE SEXO %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    woman = imread('woman.jpg', 'jpg');
    man = imread('man.jpg', 'jpg');
    
    Screen('PutImage', wPtr, woman, [220 412 347 649]);
    Screen('PutImage', wPtr, man, [860 412 964 649]);
    Screen(wPtr, 'Flip');
    
    tic
    while toc < 1
     ;
    end
    
    % infoInstancia = cat(2, infoInstancia, [sexo])
    
    cueCoords = [[320 256 350 286]; [635 507 665 537]; [960 256 990 286] ];   % Defino una matriz con las posiciones del cue atencional. Primer fila: Periferico izquierdo, Segunda fila: Periferico derecho, Tercer fila: Neutral
    fila = randi([1, 3], 1);  %Hacemos random entre 1 y 3 para decidir que cue atencional usar.
    infoInstancia = cat(2, infoInstancia, [fila]);
    
    %Hacemos dos randoms para elegir las dos imagenes que se van a presentar en
    %pantalla
    imgRight = randi([1, cantImagenes], 1); 
    imgLeft = randi([1, cantImagenes], 1); 
    while(imgLeft == imgRight) 
      imgLeft = randi([1, cantImagenes], 1);
    end

    infoInstancia = cat(2, infoInstancia, [imgRight]);
    infoInstancia = cat(2, infoInstancia, [imgLeft]);
    
    %Elegimo una imagen de a
    imagenRight = imread(cat(2,'Imagenes/', vImg(imgRight,:)), 'jpg');
    imagenLeft = imread(cat(2,'Imagenes/', vImg(imgLeft,:)), 'jpg');

    barCoords = [[570 512 630 532]; [670 512 730 532]];
    ALaIzquierda = randi([1,2], 1);
    infoInstancia = cat(2, infoInstancia, [ALaIzquierda]);
    % 
    % if (quienVaALaIzquierda == 1) 
    %     imagenLeft  = imread(img1, 'jpg');
    %     imagenRight = imread(img2,'jpg');
    % else
    %     imagenLeft  = imread(img2, 'jpg');
    %     imagenRight = imread(img1, 'jpg');
    % end

    Screen('FillRect',wPtr,gray);  %Pintamos la pantalla de gris
    Screen('FillOval', wPtr, black, [640 512 660 532]); %Circulo de fijacion en el centro de la pantalla
    Screen(wPtr, 'Flip');

    tic
    while toc<0.5 %segundos
    ;
    end

    

    Screen('FillRect',wPtr,gray);  %Pintamos la pantalla de gris
    Screen('FillOval', wPtr, black, [640 512 660 532]); %Circulo de fijacion en el centro de la pantalla
    Screen('FillOval', wPtr, black, cueCoords(fila, :)); %Cue perfiferico a la izquierda; Usamos las coordenadas indicadas por fila (el numero random).
    Screen(wPtr, 'Flip');

    tic
    while toc<0.5
    ;
    end

    Screen('FillRect',wPtr,gray);  %Pintamos la pantalla de gris
    Screen('PutImage', wPtr, imagenLeft, [220 412 420 656]);
    Screen('PutImage', wPtr, imagenRight, [860 412 1060 656]);
    Screen('FillOval', wPtr, black, [640 512 660 532]); %Circulo de fijacion en el centro de la pantalla
    Screen(wPtr,'Flip');

    tic
    while toc<0.5
    ;
    end

    %Pantalla de la barra negra
    Screen('FillRect',wPtr,gray);  %Pintamos la pantalla de gris
    Screen('FillOval', wPtr, black, [640 512 660 532]); %Circulo de fijacion en el centro de la pantalla
    Screen('FillRect', wPtr, black, barCoords(ALaIzquierda,:));
    Screen(wPtr,'Flip');

    tic
    while toc<0.5
    ;
    end
    
    Screen('FillRect',wPtr,gray);  %Pintamos la pantalla de gris
    Screen('FillOval', wPtr, black, [640 512 660 532]); %Circulo de fijacion en el centro de la pantalla
    Screen(wPtr, 'Flip');
    
    buttons = [0 0 0];
    responseTime = 0;
    tic
    while and(~any(buttons), toc < 1) % Espera repuesta del mouse durante un tiempo acotado, sino sigue.
        [x,y,buttons] = GetMouse;
        responseTime = toc;
    end
    
        pressedButton = find(buttons);
        infoInstancia = cat(2, infoInstancia, pressedButton);
        infoInstancia = cat(2, infoInstancia, responseTime);
    
        infoInstancia
        counter = counter + 1;
end

Screen('CloseAll');
ShowCursor; 