function [b] = BOLD1(T,r)
% DCM 2003
% global itaus itauf itauo ialpha Eo dt

dt = 0.001;%0.001;    % (s)
t0 = (dt:dt:T)';
n_t = length(t0);

% t_min = 20; % remove the first 20s
% n_min = round(t_min/dt);

n_min = 1;
% ------------BOLD model parameters------------
taus = 0.65; % 0.8;    % time unit (s)
tauf = 0.41; % 0.4;    % time unit (s)
tauo = 0.98; % 1;      % mean transit time (s)
alpha = 0.32; % 0.2;    % a stiffness exponent
itaus = 1/taus;
itauf = 1/tauf;
itauo = 1/tauo;
ialpha = 1/alpha;
Eo = 0.34;
vo = 0.02;
k1 = 7*Eo;
k2 = 2;
k3 = 2*Eo-0.2;
% ------------Initial conditions--------------
x0 = [0 1 1 1];
x = zeros(n_t,4);
x(1,:) = x0;
b1=zeros(1,n_t);
for n = 1 : n_t-1;
    x(n+1,1) = x(n,1) + dt*( r(n)-itaus*x(n,1)-itauf*(x(n,2)-1));
    x(n+1,2) = x(n,2) + dt*x(n,1);
    x(n+1,3) = x(n,3) + dt*itauo*(x(n,2)-x(n,3)^ialpha);
    x(n+1,4) = x(n,4) + dt*itauo*(x(n,2)*(1-(1-Eo)^(1/x(n,2)))/Eo - (x(n,3)^ialpha)*x(n,4)/x(n,3));
    b1(n+1) = 100/Eo*vo*( k1.*(1-x(n+1,4)) + k2*(1-x(n+1,4)./x(n+1,3)) + k3*(1-x(n+1,3)));
end

v  = x(n_min:end,3);
q  = x(n_min:end,4);
b  = 100/Eo*vo*( k1.*(1-q) + k2*(1-q./v) + k3*(1-v));







