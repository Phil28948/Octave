#setup
x = [0:10];
p = []

for i = 1:5000
  if isprime(i);
    p = [p,i]
  end
end

