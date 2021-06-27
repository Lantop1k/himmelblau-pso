clc
close all
clear 


CostFunction= @(x) himmelblau(x); % specify the cost function


nvar=2;  %Number of variable to optimized (x,y)
popsize=100;   %population size for PSO
maxit=500;     %specify the maximum interations

%PSO parameters 
w=1;
wdamp=0.80;
c1=1.75;
c2=2.5;


gBest.Cost=inf; %initial Global Best cost

%=======Populates particles============
Particle={};

for i =1:popsize  %for each population size
    
       Particle(i).Pos=rand(nvar,1);    %create random particle position
       Particle(i).Vel=zeros(nvar,1);   %create zeros velocity for the particle 
       
       Particle(i).Cost=CostFunction(Particle(i).Pos);  %compute the particle cost value
       
       Particle(i).Best.Pos=Particle(i).Pos;           %set the particle position as the best position
       Particle(i).Best.Cost=Particle(i).Cost;          %set the particle cost as the best cost value
       
       %Determine if the Best cost is the global best cost
       if Particle(i).Best.Cost<gBest.Cost
            gBest=Particle(i).Best;
       end
    
end


BestCosts=zeros(maxit,1);

%%====== PSO LOOPs==============

for it=1:maxit %loop to the maximum iteration
    
    for i=1:popsize  %for each item in the population size
        
        %updating particle velocity
        Particle(i).Vel=w*Particle(i).Vel+c1*rand(nvar,1).*(Particle(i).Best.Pos-Particle(i).Pos)+c2*rand(nvar,1).*(gBest.Pos-Particle(i).Pos);
     
        %updating the position based on the particle velocity
        Particle(i).Pos=Particle(i).Pos+Particle(i).Vel;
        
        %compute the cost function for the given particle position
        Particle(i).Cost=CostFunction(Particle(i).Pos);
        
        %determine if the particle position is the best position using the
        %computed cost
        if Particle(i).Cost<Particle(i).Best.Cost
            Particle(i).Best.Pos=Particle(i).Pos;
            Particle(i).Best.Cost=Particle(i).Cost;
            
            %determine if the best position is the global best position 
            if Particle(i).Best.Cost<gBest.Cost
                gBest=Particle(i).Best;
            end
            
        end
   
    end
    
    %store best cost 
    BestCosts(it)=gBest.Cost;
    
    %display result
    disp([' Global Best Cost at Iterations: ' num2str(it) ' = ' num2str(BestCosts(it))])
    w=w*wdamp;
end

%========== plot Best Global Cost for all the iterations ============
figure(1);
plot(1:maxit,BestCosts,'LineWidth',1.2)
xlabel('Iterations');
ylabel('Best Cost');
grid on;