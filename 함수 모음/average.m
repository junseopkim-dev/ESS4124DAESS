function result = avg(vector)
    % This function calculates the average of a column vector without using the mean function.
    if size(vector, 2) ~= 1
        error('Input must be a column vector');
    end
    total = sum(vector); % Calculate the sum of all elements in the vector
    n = length(vector);  % Get the number of elements in the vector
    result = total / n;  % Calculate the average
end
