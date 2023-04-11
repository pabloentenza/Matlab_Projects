clc
close all
format shortEng

%% Declaracion de variables
%Tiempo
t=time;

%Estados reales
x1=states(:,1);
x2=states(:,2);
x3=states(:,3);

%Estimaciones FESO
x1FESO=FESO(:,1);
x2FESO=FESO(:,2);
x3FESO=FESO(:,3);

%Error FESO
e1FESO=x1-x1FESO;
e2FESO=x2-x2FESO;
e3FESO=x3-x3FESO;
eFESO=[e1FESO';e2FESO';e3FESO'];

%Estimaciones LESO
x1LESO=LESO(:,1);
x2LESO=LESO(:,2);
x3LESO=LESO(:,3);

%Error ESO
e1LESO=x1-x1LESO;
e2LESO=x2-x2LESO;
e3LESO=x3-x3LESO;
eLESO=[e1LESO';e2LESO';e3LESO'];

%Estimaciones LESO
x1NESO=NESO(:,1);
x2NESO=NESO(:,2);
x3NESO=NESO(:,3);

%Error ESO
e1NESO=x1-x1NESO;
e2NESO=x2-x2NESO;
e3NESO=x3-x3NESO;
eNESO=[e1NESO';e2NESO';e3NESO'];

%% Ganancia L2
%Norma L2 FESO
Norm_eFESO=zeros(1,length(eFESO));
for i=1:length(eFESO)
    Norm_eFESO(1,i)=norm(eFESO(:,i));
end
Square_Norm_eFESO=Norm_eFESO.^2;
L2_NORM_FESO=cumtrapz(t,Square_Norm_eFESO');

%Norma L2 LESO
Norm_eLESO=zeros(1,length(eLESO));
for i=1:length(eLESO)
    Norm_eLESO(1,i)=norm(eLESO(:,i));
end
Square_Norm_eLESO=Norm_eLESO.^2;
L2_NORM_LESO=cumtrapz(t,Square_Norm_eLESO');

%Norma L2 LESO
Norm_eNESO=zeros(1,length(eNESO));
for i=1:length(eLESO)
    Norm_eNESO(1,i)=norm(eNESO(:,i));
end
Square_Norm_eNESO=Norm_eNESO.^2;
L2_NORM_NESO=cumtrapz(t,Square_Norm_eNESO');

%% Indices
% Mean Absolute Error (MAE)
n=length(time);
Abs_eFESO=abs(eFESO');
Abs_eLESO=abs(eLESO');
Abs_eNESO=abs(eNESO');

MAE_FESO=sum(Abs_eFESO)/n;
MAE_LESO=sum(Abs_eLESO)/n;
MAE_NESO=sum(Abs_eNESO)/n;

FESO_MAE=MAE_FESO';
LESO_MAE=MAE_LESO';
NESO_MAE=MAE_NESO';

disp('Mean Absolute Error (MAE)')
Table=table(FESO_MAE,LESO_MAE,NESO_MAE);
disp(Table)
disp(' ')

% Mean Square Error (MSE)
Square_eFESO=eFESO'.^2;
Square_eLESO=eLESO'.^2;
Square_eNESO=eNESO'.^2;

MSE_FESO=sum(Square_eFESO)/n;
MSE_LESO=sum(Square_eLESO)/n;
MSE_NESO=sum(Square_eNESO)/n;

FESO_MSE=MSE_FESO';
LESO_MSE=MSE_LESO';
NESO_MSE=MSE_NESO';

disp('Mean Square Error (MSE)')
Table=table(FESO_MSE,LESO_MSE,NESO_MSE);
disp(Table)
disp(' ')

%% Plots
figure(1); set(figure(1),'Color','w')
    plot(t,x1,'b','Linewidth',2); hold on;
    plot(t,x1FESO,'--r','Linewidth',2); xlim([0 40]); ylim([-2.5 3]);
    plot(t,x1ESO,'--r','Linewidth',2);
    h_legend=legend('$x_{1}$','$\widehat{x}_{1}$','Orientation','horizontal','Location','NorthEast');
    set(h_legend,'Interpreter','latex','FontSize',22,'FontWeight','bold','box','off');
    ylabel('$x_{1}(t)$','Interpreter','latex','FontSize',20);
    xlabel('time [s]','Interpreter','latex','FontSize',20);

figure(2); set(figure(2),'Color','w')
    plot(t,x2,'b','Linewidth',2); hold on;
    plot(t,x2FESO,'--r','Linewidth',2); xlim([0 40]); ylim([-3 4.5]);
%     plot(t,x2ESO,'--r','Linewidth',2); xlim([0 40]); ylim([-3 4]);
    h_legend=legend('$x_{2}$','$\widehat{x}_{2}$','Orientation','horizontal','Location','NorthEast');
    set(h_legend,'Interpreter','latex','FontSize',22,'FontWeight','bold','box','off');
    ylabel('$x_{2}(t)$','Interpreter','latex','FontSize',20);
    xlabel('time [s]','Interpreter','latex','FontSize',20);
    
figure(3); set(figure(3),'Color','w')
    plot(t,x3,'b','Linewidth',2); hold on;
    plot(t,x3FESO,'--r','Linewidth',2); xlim([0 40]); ylim([-1.2 1.4]);
%     plot(t,x3ESO,'--r','Linewidth',2); xlim([0 40]); ylim([-1.5 1.5]);
    h_legend=legend('$x_{3}$','$\widehat{x}_{3}$','Orientation','horizontal','Location','NorthEast');
    set(h_legend,'Interpreter','latex','FontSize',22,'FontWeight','bold','box','off');
    ylabel('$x_{3}(t)$','Interpreter','latex','FontSize',20);
    xlabel('time [s]','Interpreter','latex','FontSize',20);
    
figure(4); set(figure(4),'Color','w')
   plot(t,e1FESO,'b','Linewidth',2); hold on;
   plot(t,e2FESO,'r','Linewidth',2); xlim([0 40]); ylim([-1.0 0.3]);
   plot(t,e3FESO,'Color',[0 0.5 0],'Linewidth',2); %axis([0 max(t) -0.020 0.015]);    
   h_legend=legend('$\widetilde{x}_{1}$','$\widetilde{x}_{2}$','$\widetilde{x}_{3}$','Orientation','horizontal','Location','NorthEast');
   set(h_legend,'Interpreter','latex','FontSize',22,'FontWeight','bold','box','off');
   ylabel('$\widetilde{x}(t)$','Interpreter','latex','FontSize',20);
   xlabel('time [s]','Interpreter','latex','FontSize',20);

figure(5); set(figure(5),'Color','w')
    plot(t,L2_NORM_FESO,'b','Linewidth',2); hold on;
    plot(t,L2_NORM_LESO,'--r','Linewidth',2);
    plot(t,L2_NORM_NESO,'Color',[0 0.5 0],'LineStyle','--','Linewidth',2);
    ylim([0 0.21]);
%     plot(t,e2FESO,'r','Linewidth',2); xlim([0 40]); ylim([-1 0.3]);
%     plot(t,e3FESO,'Color',[0 0.5 0],'Linewidth',2); %axis([0 max(t) -0.020 0.015]);
    h_legend=legend('FESO','LESO','NESO','Orientation','horizontal','Location','NorthEast');
    set(h_legend,'Interpreter','latex','FontSize',22,'FontWeight','bold','box','off');
    ylabel('$\int\Vert \widetilde{x}(t)\Vert^{2}dt$','Interpreter','latex','FontSize',20);
    xlabel('time [s]','Interpreter','latex','FontSize',20);