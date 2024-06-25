a=700;
b=0.007;
c=300;
x=1:a;
y=b*(1-exp(-x/c)).*(x);
plot(x,y)