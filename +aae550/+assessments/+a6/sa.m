function sa()

x0 = [3 -2 3 1];
v0 = [3 3 3 3];
T = 1;

counter = 1;

f = @(x) (-5 * cos(7 * norm(x))) / (3 * norm(x)^2);

x = x0;

bestX = x;
bestF = f(x);
lastF = bestF;
for i = 1:20
    % Loops
    
    % Update next value
    for j = 1:4
        ei = zeros(1, 4);
        ei(j) = 1;
        flag = 1;
        while(flag)
            x_test = x + myRand() * v0 .* ei;
            if all(abs(x_test) <= 10)
                flag = 0;
            end
        end
        y = f(x_test);
        df = y - lastF;
        if df < 0
            x = x_test;
            if y < bestF
                bestF = y;
                bestX = x;
            end
            lastF = y;
        else
            P = exp(-df / T);
            pp = abs(myRand());
            if pp <= P
                x = x_test;
                if y < bestF
                    bestF = y;
                    bestX = x;
                end
            end
        end
    end
end

    function a = myRand()
        vals = [0.5605 0.1504 0.2982 0.3735 -0.0264 0.2886 0.2449 -0.5481 0.8097 0.2056];
        a = vals(counter);
        counter = counter + 1;
        if counter > numel(vals)
            counter = 1;
        end
    end
end