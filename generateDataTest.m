%starter code for project 1: linear regression
%pattern recognition, CSE583/EE552
%Weina Ge, Aug 2008

%generate noisy observations from the "ground true" curve

npts = 50; %number of sample points -- change this number when you want to vary the sample size
zz = linspace(1,4*pi,npts);
yt = sin(.5*zz);

%define the noise model
nmu = 0;
nsigma = 0.3;
noise = nmu+nsigma.*randn(1,npts); %generate npts number of saxxmples from the N(nmu,nsigma^2)
tt  = yt + noise; %noisy observation

%save the data points
save datatest.mat zz yt tt


