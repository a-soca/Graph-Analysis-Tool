%--------- \/ Initialisation \/ -----------------------------------------------------------------------------------------------------------------------

clear % clears the variables stored in memory
clc % clears the console window
clf % clears figure

aValues = []; % initialises a value array for use later
bValues = []; % initialises b value array for use later
cValues = []; % initialises c value array for use later
lineTypes = string([]); % initialises array of the types of lines entered (setting the type of variables stored as string)
roots = []; % initialises array to store the roots of each quadratic
rootCount = []; % initialises the array to count number of roots in each line

%--------- \/ User Input \/ ---------------------------------------------------------------------------------------------------------------------------

repeat = true; % declares boolean variable repeat and sets to true. When the user has input all lines they wish to enter, this is set to false and the while loop exits
while repeat == true % loops for as many lines as user wishes to input
    
    titleGenerator('unspecified'); % calls function used to generate the title of the program
    
    while ~exist('userQ', 'var') % exist must be used first as the variable has not yet been declared, the variable 'userQ' will be cleared if an invalid input has been provided
    userQ = input('Would you like to input a linear or quadratic? [l/q] : ', 's'); % outputs to console and asks user which line type they would like to use
        switch userQ % depending on what line the user selects, a different number of variables will be queried for and the variable tracker will adjust accordingly
            case 'l' % if the line is linear, the following will execute
                userInputPath = 'linear'; % sets a variable used later to perform the correct calculation for a linear line / output the correct messages
                titleGenerator(userInputPath); % clears the previous user input from console and reprints title
            case 'q' % if the line is quadratic, the following will execute
                userInputPath = 'quadratic'; % sets a variable used later to perform the correct calculation for a quadratic line / output the correct messages
                titleGenerator(userInputPath); % clears the previous user input from console and reprints title
            otherwise % if the user input an invalid input (not l or q), the following will execute
                titleGenerator('unspecified'); % clears the previous user input
                clearvars userQ; % clears the variable fulfilling the requirement for the loop to proceed
                fprintf(2, 'Invalid input. Please re-enter.\n'); % prints error for user in red
        end % ends the switch statement
    end % ends the while loop
    
    while ~exist('a', 'var') % loops as long as a has an invalid input, exist must be checked first as a has not yet been declared and when it is cleared in the if statement, a does not exist.
        a = input('Please enter a value for a : ', 's'); % asks the user for a value for a and stores it in memory
        a = str2double(a); % converts the user input into a number.
        if isnan(a) || ~isreal(a) || isinf(a) % if a is not a number, not a real number or is infinite, the following code will execute
            titleGenerator(userInputPath); % clears the invalid input from the console window and reprints title
            fprintf(2, 'Invalid input for a, it must be a (real) number. Please try again.\n'); % prints a prompt to retry the entry
            clearvars a; % clears a allowing the input to loop
        elseif a == 0 && userInputPath == "quadratic" % quadratic equations must have a non 0 x^2 coefficient otherwise they are linear
            titleGenerator(userInputPath); % clears the invalid input text from the console window and reprints title
            fprintf(2, 'Invalid input for a, it must not be 0 in a quadratic equation. Please try again.\n'); % prints a prompt to retry the entry
            clearvars a; % clears a allowing the input to loop
        end % ends if statement
    end % if the input was invalid, this section will loop and ask for user input again

    titleGenerator(userInputPath, a); % updates variable display with the validated user input of a

    while ~exist('b', 'var') % loops as long as b has an invalid input, exist must be checked first as b has not yet been declared and when it is cleared in the if statement, b does not exist.
        b = input('Please enter a value for b : ', 's'); % asks the user for a value for b and stores it in memory
        b = str2double(b); % converts the user input into a number.
        if isnan(b) || ~isreal(b) || isinf(b) % if b is not a number, not a real number or is infinite, the following code will execute
            titleGenerator(userInputPath, a); % clears the invalid input from the console window and reprints title
            fprintf(2, 'Invalid input for b, it must be a (real) number. Please try again.\n'); % prints a prompt to retry the entry
            clearvars b; % clears b allowing the input to loop
        end % ends if statement
    end % if the input was invalid, this section will loop and ask for user input again

    titleGenerator(userInputPath, a, b); % updates variable display with the validated user input of b
    
    if userInputPath == "quadratic" % if the user has selected a quadratic line, the following code will be executed
        while ~exist('c', 'var') % loops as long as c has an invalid input, exist must be checked first as c has not yet been declared and when it is cleared in the if statement, c does not exist.
            c = input('Please enter a value for c : ', 's'); % asks the user for a value for c and stores it in memory
            c = str2double(c); % converts the user input into a number.
            if isnan(c) || ~isreal(c) || isinf(c) % if c is not a number, not a real number or is infinite, the following code will execute
                titleGenerator(userInputPath, a, b); % clears the invalid input from the console window and reprints title
                fprintf(2, 'Invalid input for c, it must be a (real) number. Please try again.\n'); % prints a prompt to retry the entry
                clearvars c; % clears c allowing the input to loop
            end % ends if statement
        end % if the input was invalid, this section will loop and ask for user input again
        titleGenerator(userInputPath, a, b, c); % updates variable display with the validated user input of c
    end % ends if statement for quadratic path

    aValues(length(aValues)+1) = a; % assigns variable a to the end of an array of a values to be used in the graph plotting section
    bValues(length(bValues)+1) = b; % assigns variable b to the end of an array of b values to be used in the graph plotting section
    if userInputPath == "quadratic" % because c is not used in linear, the variable is only assigned if the quadratic path was selected
        cValues(length(cValues)+1) = c; % assigns variable c to the end of an array of c values to be used in the graph plotting section
        lineTypes(length(lineTypes)+1) = "quadratic"; % stores quadratic in the linetypes array so that the future switch case knows which operations to perform on this line
    else % if the line is not quadratic (linear) then a placeholder value must be used so that the lines after can be called from the same i in the for loop
        cValues(length(cValues)+1) = "linear"; % assigns placeholder value in c value array to be skipped
        lineTypes(length(lineTypes)+1) = "linear"; % stores linear in the linetypes vector so that the future switch case knows which operations to perform on this line
    end % ends if statement
    
    clearvars a b c userQ; % clears variables for next use
    
    while ~exist('userQ', 'var') % loops as long as userQ has an invalid input
        userQ = input('Would you like to compare to another line? [y/n] : ', 's');  % asks user if they would like to enter another line to graph and compare
        switch userQ % depending on the users response, the following cases may occur
            case 'y' % if the user entered y, the following code will execute
                repeat = true; % asks user for another line
            case 'n' % if the user entered n, the following code will execute
                repeat = false; % the user will not be asked to input another line
                titleGenerator('unspecified'); % clears the console and reprints title
            otherwise % if the user input is invalid the following will execute
                titleGenerator('unspecified'); % clears console and reprints title
                clearvars userQ; % clears the variable fulfilling the requirement for the loop to proceed
                fprintf(2, 'Invalid input. Please re-enter.\n'); % prints error for user in red
        end % ends the switch statement for y/n
    end % ends the while loop for user input validation
    clearvars userQ; % clears the variable fulfilling the requirement for the loop to proceed
end % end of user line input loop

% ----------------- after all lines have been input and their variables -----------------
% ----------------------------- have been stored in arrays ------------------------------

%--------- \/ Calculations \/ -------------------------------------------------------------------------------------------------------------------------

for i = 1:length(aValues) % for the number of lines inputted by the user, the following will loop
    if string(lineTypes(i)) == "quadratic" % if the line corrosponding to the current iteration is quadratic, the following code will exeute
        discriminant = bValues(i)^2 - 4 * aValues(i) * cValues(i); % calculates the discriminant
        if discriminant == 0 % finds the number of roots from the discriminant
            rootCount(length(rootCount)+1) = 1; % stores the number of roots in memory (1 repeated root)
            roots(length(roots)+1) = (-bValues(i) + discriminant^0.5)/(2 * aValues(i)); % calculates the x intercept value when the positive quadratic formula variant is used
        elseif discriminant > 0 % if the discriminant is greater than 0, there are 2 real roots
            rootCount(length(rootCount)+1) = 2; % stores the number of roots in memory (2 real distinct roots)
            roots(length(roots)+1) = ((-bValues(i)) + discriminant^0.5)/(2 * aValues(i)); % calculates the x intercept value when the positive quadratic formula variant is used
            roots(length(roots)+1) = ((-bValues(i)) - discriminant^0.5)/(2 * aValues(i)); % calculates the x intercept value when the negative quadratic formula variant is used
        elseif discriminant < 0 % if the discriminant is less than 0, there are no real roots
            rootCount(length(rootCount)+1) = 0; % stores the number of roots in memory (no real roots)
            roots(length(roots)+1) = NaN; % stores a placeholder value in roots array
        end % end of if statement
    elseif string(lineTypes(i)) == "linear" && aValues(i) ~= 0 % if the line gradient is not 0
        rootCount(length(rootCount)+1) = 1; % linear lines have one x intercept
        roots(length(roots)+1) = -(bValues(i)/aValues(i)); % finds the x intercept of the line and stores it in the roots array
    elseif string(lineTypes(i)) == "linear" && aValues(i) == 0 % if the line gradient is 0
        rootCount(length(rootCount)+1) = 0; % stores the number of roots in memory (no real roots)
        roots(length(roots)+1) = NaN; % stores a placeholder value in roots array
    end % ends if statement
end % ends for loop

%--------- \/ Console Solution Output \/ --------------------------------------------------------------------------------------------------------------

tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % outputs a table of the equations of the lines inputted by the user

while ~exist('xUser1', 'var') % loops as long as the input is invalid
    fprintf('Range = __ to __\n'); % prints the ranges (empty)
    xUser1 = input('Please enter the range of x values you would like to plot, enter the minimum : ', 's'); % asks the user for the minimum x value to be plotted from and stores it in memory
    xUser1 = str2double(xUser1); % converts the input from a string to a number
    if isnan(xUser1) || isinf(xUser1) || ~isreal(xUser1) % if the user input is invalid (not a number, infinite or not real), the following code will execute
        titleGenerator('unspecified'); % clears previous user input and reprints title
        tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % reprints table
        clearvars xUser1; % clears value so the loop can occur
        fprintf(2, 'Invalid input for range min, it must be a number. Please try again.\n'); % prints a prompt to retry the entry
    elseif xUser1 > min(roots) % if the user input is larger than the smallest root, the following code will execute
        titleGenerator('unspecified'); % clears previous user input and reprints title
        tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % reprints table
        fprintf(2, 'Invalid input for range min, it must be a number smaller than the smallest root %g. Please try again.\n', min(roots)); % prints a prompt to retry the entry
        clearvars xUser1; % clears value so the loop can occur
    end % ends if statement
end % ends while loop for validation routine

titleGenerator('unspecified'); % clears user input and reprints title
tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % reprints table

while ~exist('xUser2', 'var') % loops as long as xUser2 has an invalid input
    fprintf('Range = %G to __\n', xUser1); % prints the minimum range
    xUser2 = input('Please enter the range of x values you would like to plot, enter the maximum : ', 's'); % asks user to input a maximum x value to be plotted to and stores it in memory
    xUser2 = str2double(xUser2); % converts the input to a number
    if isnan(xUser2) || isinf(xUser2) || ~isreal(xUser2) % if the user input is invalid (not a number, infinite or not real), the following code will execute
        titleGenerator('unspecified'); % clears the previous user input and prints the title again
        tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % reprints table
        clearvars xUser2; % clears value so the loop can occur
        fprintf(2, 'Invalid input for range max, it must be a number. Please try again.\n'); % prints a prompt to retry the entry
    elseif xUser2 <= xUser1 % if the maximum value is less than the minimum value,
        titleGenerator('unspecified'); % clears the previous user input and prints the title again
        tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % reprints table
        clearvars xUser2; % clears value so the loop can occur
        fprintf(2, 'Invalid input for range max, it must be a number greater than the x minimum value. Please try again.\n'); % prints a prompt to retry the entry
    elseif xUser2 < max(roots) % if the input is less than the largest root, the following code will execute
        titleGenerator('unspecified'); % clears the previous user input and prints the title again
        tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % reprints table
        clearvars xUser2; % clears value so the loop can occur
        fprintf(2, 'Invalid input for range max, it must be a number greater than the largest root %g. Please try again.\n', max(roots)); % prints a prompt to retry the entry
    end % ends if statement
end % ends while loop for validation routine

titleGenerator('unspecified'); % clears user input and reprints title
tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % outputs a table of the equations of the lines inputted by the user
fprintf('Range = %G to %G\n\n', xUser1, xUser2); % prints the range with x min/max values selected by user

%--------- \/ Graph Plotting \/ -----------------------------------------------------------------------------------------------------------------------

x = linspace(xUser1,xUser2); % creates a vector array of values for x in user specified range to be used in the graph plot

fprintf(2, "Plotting graph...\n\n"); % outputs text to console

clf('reset'); % clears previous lines plotted on graph from last run
hold on; % makes sure lines plotted do not overwrite eachother so they are all visible simultaneously
for i = 1:length(aValues) % for the number of lines inputted by the user, the following code will execute
    switch lineTypes(i) % depending on the line type, the following cases will be selected
        case "quadratic" % if the line is quadratic, the following code will execute
            y = aValues(i) * x.^2 + bValues(i) * x + cValues(i); % calculates the y values for each x value in the x vector array
            equationPrint = sprintf('y = %dx^{2} + %dx + %d', aValues(i), bValues(i), cValues(i)); % sets a variable to the equation of the line in plain text to be used in the legend
        case "linear" % if the line is linear, the following code will execute
            y = aValues(i) * x + bValues(i); % calculates the y values for each x value in the x vector array
            equationPrint = sprintf('y = %dx + %d', aValues(i), bValues(i)); % sets a variable to the equation of the line in plain text to be used in the legend
    end % ends switch
    plot(x, y,'DisplayName', char(equationPrint), 'LineWidth', 2); % plots x and y values on a graph, sets name to equation of the line for legend and sets the thickness of the line
end % ends for loop
legend % adds the legend to the graph with all lines labelled with their equations

for i = 1:length(roots) % for the number of roots
    if ~isnan(roots(i)) % if they are real
        text(roots(i),0,sprintf('(%3.2f, 0)', roots(i)),'Color','w'); % print the root coordinate on the graph
    end % ends if statement
end % ends for loop

set(gca, 'Color', 'black', 'LineWidth', 2) % makes the background of the graph black and sets the thickness of the grid lines
xline(0, '--', 'DisplayName', '', 'Color', 'w', 'LineWidth', 1); % adds an x axis line, sets dashed line, hides from legend, white colour and width
yline(0, '--', 'DisplayName', '', 'Color', 'w', 'LineWidth', 1); % adds a y axis line, sets dashed line, hides from legend, white colour and width
title('Your Graph'); % adds a title to the graph
xlabel('X axis'); % adds a label to the x axis
ylabel('Y axis'); % adds a label to the y axis
grid on; % enables the grid for easier reading of values plotted

%--------- \/ Finding line intercepts \/ --------------------------------------------------------------------------------------------------------------

if length(aValues) > 1 % if there is more than one line, they can be compared so the following code will execute
    inputting = true; % sets a variable to loop the comparison user input until they no longer wish to compare the lines they entered
        while ~exist('userQ', 'var') || inputting == true % 'userQ' will be empty if an invalid input has been provided
            clearvars userQ; % clears previous user input from memory
            userQ = input('Would you like to find the intercept between 2 lines? [y/n] : ', 's'); % outputs to console and asks user which line type they would like to use
            switch userQ % depending on what line the user selects, a different number of variables will be queried for and the variable tracker will adjust accordingly
                case 'y' % if the user input y, the following code will execute
                    clearvars eqNum1 eqNum2; % clears eqNum1 and eqNum2 from memory
                    titleGenerator('unspecified'); % clears user input and reprints title
                    tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % outputs a table of the equations of the lines inputted by the user
    
                    while exist('eqNum1', 'var') == false % if eqNum1 does not exist, the following code will execute. (does not exist after being cleared from memory)
                        eqNum1 = input('Enter the number of first equation [Eq#] : ','s'); % asks the user for the number of the first equation they wish to compare
                        eqNum1 = str2double(eqNum1); % converts the input to a number, if the input is not a number it will be set to empty
                        if isinf(eqNum1) || ~isreal(eqNum1) || isnan(eqNum1) || eqNum1 < 1 || eqNum1 > length(aValues) || mod(eqNum1,1) ~= 0 % checks to see if the input is NOT within the range of equation numbers or not a real whole number
                            clearvars eqNum1; % clears the variable eqNum1 to fulfil the requirement for the loop to occur
                            titleGenerator('unspecified'); % clears previous user input and reprints title
                            tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % outputs a table of the equations of the lines inputted by the user
                            fprintf(2, 'Invalid input, it must be the number of an equation in the table. Please try again.\n'); % prints a prompt to retry the entry
                        end % ends if statement
                    end % ends while loop
        
                    titleGenerator('unspecified'); % clears previous user input and reprints title
                    tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % outputs a table of the equations of the lines inputted by the user
                    
                    while ~exist('eqNum2', 'var') % if eqNum1 does not exist, the following code will execute. (does not exist after being cleared from memory)
                        eqNum2 = input('Enter the number of second equation [Eq#] : ','s'); % asks the user for the number of the second equation they wish to compare
                        eqNum2 = str2double(eqNum2); % converts the input to a number, if the input is not a number it will be set to empty
                         if isinf(eqNum2) || ~isreal(eqNum2) || isnan(eqNum2) || eqNum2 < 1 || eqNum2 > length(aValues) || mod(eqNum2,1) ~= 0 || eqNum2 == eqNum1 % the variable 'eqNum2' will only be empty at this point if the user input a character which was not numeric (invalid) previously, also checks to see if the input is NOT within the range of equation numbers or not a whole number
                            clearvars eqNum2; % clears the variable eqNum2 to fulfil the requirement for the loop to occur
                            titleGenerator('unspecified'); % clears previous user input and reprints title
                            tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % outputs a table of the equations of the lines inputted by the user
                            fprintf(2, 'Invalid input, it must be the number of an equation in the table and cannot be the same as the first input. Please try again.\n'); % prints a prompt to retry the entry
                        end % ends if statement
                    end % ends while loop
    
    
               %finding intercepts
            containsQuadratic = true; % linear equation comparisons require a different method so this variable is set to false if both lines are linear, however in all other cases it is true so it is set to true outside of the if/else to avoid unnecessarily repeating it
            if lineTypes(eqNum1) == "quadratic" && lineTypes(eqNum2) == "quadratic" % if both lines are quadratic, the following will execute
                d = aValues(eqNum1) - aValues(eqNum2); % difference between a values
                e = bValues(eqNum1) - bValues(eqNum2); % difference between b values
                f = cValues(eqNum1) - cValues(eqNum2); % difference between c values
            elseif lineTypes(eqNum1) == "quadratic" && lineTypes(eqNum2) == "linear" % if one line is linear, the following will execute
                d = aValues(eqNum1); % the coefficient of x^2 is not present in linear equations so it is missed here
                e = bValues(eqNum1) - aValues(eqNum2); % difference in coefficient of x
                f = cValues(eqNum1) - bValues(eqNum2); % difference in constant
            elseif lineTypes(eqNum1) == "linear" && lineTypes(eqNum2) == "quadratic" % if one line is linear, the following will execute. Repeat is necessary as the user could select the linear equation in position one or two and this position must be known in order to find the difference between coefficients.
                d = aValues(eqNum2); % the coefficient of x^2 is not present in linear equations so it is missed here
                e = bValues(eqNum2) - aValues(eqNum1); % difference in coefficient of x
                f = cValues(eqNum2) - bValues(eqNum1); % difference in constant
            elseif lineTypes(eqNum1) == "linear" && lineTypes(eqNum2) == "linear" % if both lines are linear, the following code will execute
                containsQuadratic = false; % sets variable to false so the switch statement later knows that both lines are linear
                d = aValues(eqNum1) - aValues(eqNum2); % difference between coefficients of x
                e = bValues(eqNum2) - bValues(eqNum1); % difference between constants
            end % ends if statement
    
            switch containsQuadratic % depending on whether or not the inputted equations contain a quadratic the following will execute
                case true % if there is a quadratic in the input
                    if d == 0 && e == 0 && f == 0 % if there is no difference between the equations, the following will execute
                        titleGenerator('unspecified'); % clears console and reprints title
                        tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % prints the table of lines again
                        fprintf("Lines are the same\n\n"); % tells user both lines are the same
                    else % if lines are not the same
                        discriminantIntercept = (e^2 - 4*d*f); % calculates the discriminant of the equation formed by the difference of both equations selected
                        if discriminantIntercept > 0 % if the discriminant is greater than 0, there are 2 intercepts and the following code will execute
                            interceptPosX = (-e + discriminantIntercept^(1/2))/(2*d); % uses the positive form of the quadratic formula to find an x value
                            interceptNegX = (-e - discriminantIntercept^(1/2))/(2*d); % uses the negative form of the quadratic formula to find an x value
                            if isnan(cValues(eqNum1)) % if the first formula is linear, the c value will be NaN as this is what it is set to as a placeholder earlier in the code
                                interceptPosY = aValues(eqNum2)*interceptPosX^2 + bValues(eqNum2)*interceptPosX + cValues(eqNum2); % substitutes x value from positive quadratic equation into the quadratic equation 
                                interceptNegY = aValues(eqNum2)*interceptNegX^2 + bValues(eqNum2)*interceptNegX + cValues(eqNum2); % substitutes x value from negative quadratic equation into the quadratic equation 
                            else % if the first formula is a quadratic, the following code will execute
                                interceptPosY = aValues(eqNum1)*interceptPosX^2 + bValues(eqNum1)*interceptPosX + cValues(eqNum1); % substitutes x value from positive quadratic equation into the first equation 
                                interceptNegY = aValues(eqNum1)*interceptNegX^2 + bValues(eqNum1)*interceptNegX + cValues(eqNum1); % substitutes x value from negative quadratic equation into the first equation 
                            end % ends if statement
                            titleGenerator('unspecified'); % clears console and reprints title
                            tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % prints the table of lines again
                            fprintf("Lines intercept twice at (%g , %g) and (%g , %g)\n\n", interceptPosX, interceptPosY, interceptNegX, interceptNegY); % prints the intercept coordinates to console
                            plot(interceptPosX, interceptPosY,'.', 'MarkerSize', 10); % plots positive quadratic point of intercept on the graph
                            text(interceptPosX, interceptPosY, sprintf('(%g, %g)',interceptPosX, interceptPosY), 'color', 'w'); % labels the intercept point on the graph
                            plot(interceptNegX, interceptNegY,'.', 'MarkerSize', 10); % plots negative quadratic point of intercept on the graph
                            text(interceptNegX, interceptNegY, sprintf('(%g, %g)',interceptNegX, interceptNegY), 'color', 'w'); % labels the intercept point on the graph
                        elseif discriminantIntercept == 0 % if the discriminant is 0, there is one intercept and the following code will execute
                            interceptPosX = (-e + discriminantIntercept^(1/2))/(2*d); % finds the x coordinate of the intercept
                            if isnan(cValues(eqNum1)) % if the first formula is linear, the c value will be NaN as this is what it is set to as a placeholder earlier in the code
                                interceptPosY = aValues(eqNum2)*interceptPosX^2 + bValues(eqNum2)*interceptPosX + cValues(eqNum2); % substitutes previously calculated x coordinate into the equation to find the y coordinate
                            else % if the first formula is a quadratic, the following code will execute
                                interceptPosY = aValues(eqNum1)*interceptPosX^2 + bValues(eqNum1)*interceptPosX + cValues(eqNum1); % substitutes previously calculated x coordinate into the equation to find the y coordinate
                            end % ends if statement
                                titleGenerator('unspecified'); % clears console and reprints title
                                tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % prints the table of lines again
                            fprintf("Lines intercept once at (%g , %g)\n\n", interceptPosX, interceptPosY); % prints the intercept coordinate to console
                            plot(interceptPosX, interceptPosY,'.', 'MarkerSize', 10); % plots point of intercept on the graph
                            text(interceptPosX, interceptPosY, sprintf('(%g, %g)',interceptPosX, interceptPosY), 'color', 'w'); % labels the intercept point on the graph
                        else % if the discriminant is less than 0, there are no intercepts and the following code will execute
                            titleGenerator('unspecified'); % clears console and reprints title
                            tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % prints the table of lines again
                            fprintf("Lines do not intercept\n\n"); % tells the user the lines do not intercept in console
                        end % ends if statement
                    end % ends if statement
                case false % if both lines are linear, the following code will execute
                    if d == 0 && e == 0 % if there is no difference between the two equations, the following code will execute
                        titleGenerator('unspecified'); % clears console and reprints title
                        tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % prints the table of lines again
                        fprintf("lines are the same\n\n"); % tells the user the lines are the same in the console
                    elseif aValues(eqNum1) == aValues(eqNum2) % if the gradient of the lines is equal, they are parallel and will not intercept. the following code will execute
                        titleGenerator('unspecified'); % clears console and reprints title
                        tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % prints the table of lines again
                        fprintf("Lines are parallel and do not intercept\n\n"); % tells the user the lines do not intercept and are parallel in console  
                    else % if the lines are different and not parallel
                        interceptPosX = e/d; % finds the x coordinate of the intercept
                        interceptPosY = aValues(eqNum1)*interceptPosX + bValues(eqNum1); % substitutes x coordinate into the first equation to find the y coordinate
                        titleGenerator('unspecified'); % clears console and reprints title
                        tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % prints the table of lines again
                        fprintf("Lines intercept once at (%g , %g)\n\n", interceptPosX, interceptPosY); % tells the user where the lines intercept in the console
                        plot(interceptPosX, interceptPosY,'.', 'MarkerSize', 10); % plots the point of intercept on the graph
                        text(interceptPosX, interceptPosY, sprintf('(%g, %g)',interceptPosX, interceptPosY), 'color', 'w'); % labels the intercept point on the graph
                    end % ends if statement
            end % ends switch
    
                case 'n' % if the user input n, the following code will execute
                    inputting = false;
                    fprintf(2, '\nProgram ended successfully.\n');
                otherwise % if the user input an invalid input (not y or n), the following will execute
                    clearvars userQ; % clears the variable fulfilling the requirement for the loop to proceed
                    titleGenerator('unspecified'); % clears console and reprints title
                    tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots); % prints the table of lines again
                    fprintf(2, 'Invalid input. Please re-enter.\n'); % prints error for user in red
            end % ends the switch statement
        end % ends while loop
end % ends if statement

%--------- \/ Functions \/ ----------------------------------------------------------------------------------------------------------------------------

function [] = titleGenerator(lineType, a1, b1, c1) % this function generates a formatted title and live variable value display for the user
    clc % clears the console window

    border = '\n------------------------------------\n%s\n%s\n------------------------------------\n\n'; % seperately sets formatting for the title (border) for readability
    fprintf(2, border,'            Graph Plotter', '           Alex Soca 2022'); % outputs line to console. fprintf is used rather than disp in this case to change the colour and add formatting

    if ~exist('a1', 'var') % checks if a has been assigned, if not then a placeholder is used for the output
        a1 = 'unassigned'; % sets a1 to unassigned
    elseif isempty(a1) == false && isnumeric(a1) % if a1 has a value assigned and it is a number
        a1 = num2str(a1); % converts from a number to a string so that it may be output in the console in the same format as the placeholder text
    end % ends if statement
    if ~exist('b1', 'var') % checks if b has been assigned, if not then a placeholder is used for the output
        b1 = 'unassigned';  % sets b1 to unassigned
    elseif isempty(b1) == false && isnumeric(b1) % if b1 has a value assigned and it is a number
        b1 = num2str(b1); % converts from a number to a string so that it may be output in the console in the same format as the placeholder text
    end % ends if statement
    if ~exist('c1', 'var') % checks if c has been assigned, if not then a placeholder is used for the output
        c1 = 'unassigned'; % sets c1 to unassigned
    elseif ~isempty(c1) && isnumeric(c1) % if c1 has a1 value assigned and it is a number
        c1 = num2str(c1); % converts from a number to a string so that it may be output in the console in the same format as the placeholder text
    end % ends if statement
    switch lineType % depending on the value of lineType, the following cases will be selected from
        case "linear" % if the line is linear, the following code will execute
            fprintf('Line type : linear [y = ax + b]\na = %s\nb = %s\n\n', a1, b1); % outputs to console
        case "quadratic" % if the line is quadratic, the following code will execute
            fprintf('Line type : quadtratic [y = ax^2 + bx + c]\na = %s\nb = %s\nc = %s\n\n', a1, b1, c1); % outputs to console
    end % ends switch
    clearvars lineType a1 b1 c1; % clears function variables from memory for next use
end % ends function

function [] = tableGenerator(lineTypes, aValues, bValues, cValues, rootCount, roots) % this function generates a formatted table of the equations of the lines inputted
    fprintf('Eq#  | Line Type | Equation               | Number of Roots         | Roots                      | Y intercept\n-----|-----------|------------------------|-------------------------|----------------------------|------------\n'); % prints the table heading to console
    
    j = 1; % initialises iterating variable used within for loop, increases by either 1 or 2 depending on number of roots within the for loop. In this case, i only ever increases by 1 as it scrolls through the line variable arrays so a seperate variable, j, is required.
    for i = 1:length(aValues) % loops for the number of lines the user has entered
        if string(lineTypes(i)) == "quadratic" % if the user selected a quadratic line, the following code will be executed
            switch rootCount(i) % based on the number of roots, the following outputs will be selected
                case 2 % this case is ran if there are 2 roots
                    fprintf('%2d   | Quadratic | y = %+3.1d * x^2 %+3.1dx %+3.1d | 2 real roots            | (%2.2f , 0) and (%2.2f , 0) | %G\n', i, aValues(i), bValues(i), cValues(i), roots(j), roots(j+1), cValues(i)); % prints the output text
                case 1 % this case is ran if there is 1 root
                    fprintf('%2d   | Quadratic | y = %+3.1d * x^2 %+3.1dx %+3.1d | 1 repeated root         | (%2.2f , 0)                 | %G\n', i, aValues(i), bValues(i), cValues(i), roots(j), cValues(i)); % prints the output text
                case 0 % this case is ran if there are no roots
                    fprintf('%2d   | Quadratic | y = %+3.1d * x^2 %+3.1dx %+3.1d | No real distinct roots. |                            | %G\n', i, aValues(i), bValues(i), cValues(i), cValues(i)); % prints the output text
            end % ends switch
        elseif string(lineTypes(i)) == "linear" % if the line is linear, the following code is executed
            switch rootCount(i) % based on the number of roots, the following outputs will be selected
                case 0 % this case is ran if there are 2 roots
                    fprintf('%2d   | Linear    | y = %+3.1d * x %+3.1d        | No real distinct roots. |                            | %G\n', i, aValues(i), bValues(i), bValues(i)); % prints the output text
                case 1 % this case is ran if there is 1 root
                    fprintf('%2d   | Linear    | y = %+3.1d * x %+3.1d        | 1 root                  | (%2.2f , 0)                | %G\n', i, aValues(i), bValues(i), roots(i), bValues(i)); % prints the output text % prints the output text
            end
        end % ends if statement
    
        if rootCount(i) == 2 % if the line has 2 roots, the j iterator is increased by 2
            j = j + 2; % adds 2 to j
        else % if the line is linear or has one/no roots, the following is executed
            j = j + 1; % j is increased by 1
        end % ends if statement
    end % ends for loop
    fprintf("\n"); % prints a newline so following text is on next line
end % ends function