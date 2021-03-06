% f = sin(x).*cos(0)
% %hist(z)
% 
% fp = f(randperm(length(f)));
% hold on
% hist(fp,20)
% hold off
% Este es el help de mi tercera funcion,
% Juan Kamienkowski, 10-08-2016
% blablablablablablablablabla

        [h b] = hist(f,20);     % 20 es el numero de bins que uso para el histograma

        Nf = length(f);         % Tamanio de f
        fp = f(randperm(Nf));   % randperm, devuelve la secuencia 1:Nf permutada
                                % sampleo sin reposicion, y evaluo f en esa
                                % secuencia para obtener la permutacion.
        [hp] = hist(fp,b);      % En vez del numero de bines le paso los centros.

        figure(2); clf
            subplot(1,2,1)
                hold on
                    plot(x,fp,'r-','LineWidth',3)
                    plot(x,f,'k-','LineWidth',3)
                hold off
                xlabel('X')
                ylabel('F(X,Y=0)')
            subplot(1,2,2)
                hold on
        %             plot(b,hp,'r-','LineWidth',3)
        %             plot(b,h,'k-','LineWidth',3)
                    hb=barh(b,[h' hp'], 'grouped');
                hold off
                set(hb(1),'FaceColor','k')
                set(hb(2),'FaceColor','r')
                set(gca, 'YTickLabel',[])
                xlabel('Cuentas')