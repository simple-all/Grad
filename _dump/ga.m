function ga()
counter = 1;
A = '011110';
B = '100110';
C = '101110';
D = '010110';

f = @(x) x(2)^2 - 7 * x(1);
[c1 c2] = genChildren(B, C); 
keyboard;


    function r = myRand()
        rands = [0.91 0.16 0.46 0.42 0.42 0.77];
        r = rands(counter);
        counter = counter + 1;
        if counter > numel(rands)
            counter = 1;
        end
    end

    function x = decode(c)
        for i = 1:2
            this = c((i - 1) * 3 + 1:(i - 1) * 3 + 3);
            x(i) = bin2dec(this);
        end
    end

    function [c1, c2] = genChildren(a, b)
        parents = {a, b};
        for i = 1:numel(a)
            if myRand() >= 0.5
                p1 = a;
                p2 = b;
            else
                p1 = b;
                p2 = a;
            end
            c1(i) = p1(i);
            c2(i) = p2(i);
        end
    end
end