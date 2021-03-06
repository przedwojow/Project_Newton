function [ t,t_r,t_l ] = GoldsteinTest( t,t_r,t_l,X,G,beta,d_val,y,max_iteracji_goldstein)
licznik_iteracji_goldstein=0;
p=evaluated_fx(G, X)'*d_val;
while 1
    % krok 2 - obliczanie f(x0) oraz f(x0+ td);
    t=0.5*(t_l+t_r);
    f_x_td=evaluated_fx(y, X + t*d_val);
    f_x = evaluated_fx(y, X);
    % krok 3 - sprawdzanie warunku mniejszosci/wiekszosci
    if(f_x_td < (f_x + (1-beta)*p*t))
        t_l=t;
    end
    % krok 4 - t_r => t
    if(f_x_td > (f_x + beta*p*t))
        t_r=t;
    end
    if((f_x_td >= (f_x + (1-beta)*p*t)) && (f_x_td <= (f_x + beta*p*t)))
        break
    end
    if(licznik_iteracji_goldstein>max_iteracji_goldstein)
        break
    end
    %zwiekszanie licznika iteracji dla petli minimum w kierunku
    licznik_iteracji_goldstein=licznik_iteracji_goldstein+1;
end
end

