%start code for project #1: linear regression
%pattern recognition, CSE583/EE552
%Weina Ge, Aug 2008

%% Name: RUTVIJ DHOTEY  ; PROJECT 1 ; Pattern Recogition and Machine Learning.
    


%load the data points
load data.mat
load datatest.mat

% User inputs the order of the Polynomial 

m= input('Enter the order of the polynomial(Less than 10): ');
n= input('Enter number of samples (Use the Number used in Generate Data file (Default= 10)): ');
val= input('Enter the Regularisation term ln(L): ');


M=m+1;


%plot the groud truth curve
figure(3)
title('Part 3');
xx = linspace(1,4*pi,50);
yy = sin(.5*xx);


%%start your curve fitting program here

%% The linear regression Error Equation : E(w)= 0.5 ....put the equation here....
% after solving the linear regression : minimising the Sum of squares error
% we have this following equation in terms of W*

%% Part 1: Error Minimisation using Sum of Squares

 %we have already defined the x(input) and t(output) vectors above so no
 %need to define them again.
 
X0 = ones (1,n); %for W0

trainX= zeros(m,n);         %initialise Array

%Create the X Vector

for i=1:m
    for j=1:n
        trainX(j,i)= x(1,j).^i;
    end
end

%Add the column for x^0

X= horzcat(X0',trainX);


%Select only those columns that are related to the Order.
useX= X(:,1:M);



%Calculate Wstar

T= t';
Q=  (useX') * useX;
V= inv(Q);

%Calculate W* or the coefficients

Wstar = Q \ useX'*T;


%Calculate the Xvector(for Testing 50 test points) for the test inputs

trainX= zeros(50, m);

for k=1:m
    for l=1:50
        trainX(l,k)= xx(1,l).^k;
    end
end

TESTX0= ones (50,1);
TESTX= horzcat(TESTX0,trainX);


testinginput= TESTX(:,1:M);   %(Selecting only those order terms required)


%Calculate the output for the respective Coeff.

FuncY = testinginput * Wstar;   % FOR WITHOUT REGULARISATION

FuncYtrain= useX * Wstar;       %The Curve for Training data (w/o regularisation)




%% Part 2: with the regularisation
L= exp(val);
I = eye(m+1,m+1);


% Wstar with Regularisation

Wstarreg= (Q+ L.*I)\useX'*T  ;


FuncYreg = testinginput * Wstarreg;     %FOR WITH REGULARISATION

FuncYtrainREG= useX * Wstarreg;         %For Training data (w regularisation)





%% Part 3: Minimum Likelihood using Bayesian: 

% We have already calculated the Wstar from Sum of squares error. And that can be used here.

FuncYML= useX * Wstar;
diff =(FuncYML' - t);
sqdiff= diff.^2;
betasum= sum(sqdiff);



% Calculate Variance
var= betasum/n;

%Calculate Erms
Ewforspecificorder = 0.5*betasum; 

%Calculate Standard Deviation
stdd= sqrt(var);


FuncYplus= FuncYML + 2*stdd;
FuncYminus= FuncYML - 2*stdd;

hold on;
 
% Plots for without Regularisation but with Variance
fill ([x, fliplr(x) ],[FuncYplus' , fliplr(FuncYminus')], 'r');


plot(xx,yy,'-','color','b');
hold on;
plot(x,y,'o','MarkerSize',8,'color','b');
%plot the noisy observations

xlabel('x')
ylabel('t')
plot(x, FuncYtrain','-o','MarkerSize',8,'color','y');
%plot(xx, FuncYreg','-o','MarkerSize',8,'color','g');
plot(x, FuncYplus','-o','MarkerSize',8,'color','r');
plot(x, FuncYminus','-o','MarkerSize',8,'color','r');
plot(xx,tt,'ro','MarkerSize',8,'color','b');

figure(1)
title('Part 1');
plot(xx,yy,'-','color','b');
hold on;
plot(x,y,'o','MarkerSize',8,'color','b');
%plot the noisy observations

xlabel('x')
ylabel('t')
plot(x, FuncYtrain','-o','MarkerSize',8,'color','g');
%plot(xx, FuncYreg','-o','MarkerSize',8,'color','g');
%plot(x, FuncYplus','-o','MarkerSize',8,'color','r');
%plot(x, FuncYminus','-o','MarkerSize',8,'color','r');
plot(xx,tt,'ro','MarkerSize',8,'color','b');




%% Part 4: MAP Plots using alpha and Beta .

% We have already calculated the Wstar from Sum of squares error(with regularisation). And that can be used here.

FuncYMAP= useX * Wstarreg;
diffMAP =(FuncYMAP' - t);
sqdiffMAP= diffMAP.^2;
betasumMAP= sum(sqdiffMAP);

% Calculate Variance
varMAP= betasumMAP/n;

%Calculate Standard Deviation
stddMAP= sqrt(varMAP);

% Here : L= alpha/beta where beta= 1/var

alpha= L / varMAP;


FuncYMAPplus= FuncYMAP + 2*stddMAP;
FuncYMAPminus= FuncYMAP - 2*stddMAP;



figure(2)

title('Part 2');

hold on;

%fill ([x, fliplr(x) ],[FuncYMAPplus' , fliplr(FuncYMAPminus')], 'r');

plot(xx,yy,'-','color','b');
plot(x, FuncYtrainREG','-o','MarkerSize',8,'color','g');
%plot(x, FuncYMAPplus','-o','MarkerSize',8,'color','g');
%plot(x, FuncYMAPminus','-o','MarkerSize',8,'color','g');
plot(xx,tt,'ro','MarkerSize',8,'color','b');

figure(4)

title('Part 4');

hold on;

fill ([x, fliplr(x) ],[FuncYMAPplus' , fliplr(FuncYMAPminus')], 'r');

plot(xx,yy,'-','color','b');
plot(x, FuncYtrainREG','-o','MarkerSize',8,'color','y');
plot(x, FuncYMAPplus','-o','MarkerSize',8,'color','g');
plot(x, FuncYMAPminus','-o','MarkerSize',8,'color','g');
plot(xx,tt,'ro','MarkerSize',8,'color','b');


figure(5)
Erms= [ 2.4462 1.2659  1.2644  0.1900 0.1648 0.0981 0.0362  0.0282 0.0164 0 0] ;
order= [0 1 2 3 4 5 6 7 8 9 10];
plot (order, Erms , 'color', 'r');
xlabel('Order');
ylabel('Erms');




 
