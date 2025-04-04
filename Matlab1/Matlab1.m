filename = {'SEMM1013.txt', 'SEMM3233.txt'}; % File names
titles = {'Grade for Students of SEMM1013', 'Grade for Students of SEMM3233'}; % Titles

for i = 1:length(filename)
    abc = filename{i};
    fileID = fopen(abc, 'r'); % Open the file for reading

    if fileID == -1
        error('The file %s could not be opened.', abc);
    end

    % Read the header line
    header = fgetl(fileID);

    % Read the data line by line as strings
    data = textscan(fileID, '%d %s %d', 'Delimiter', '\t'); % Read No, Identification and Mark
    fclose(fileID); % Close the file after reading

    % Extract columns
    ID = data{2}; % Second column: Identification numbers as strings
    mark = data{3}; % Third column: Marks as numeric values
    m = length(mark); % Total number of students

    % Find the highest and lowest marks
    highest = max(mark);
    lowest = min(mark);
    totalstudent = m;

    % Initialize grade counters
    count_grade = zeros(1, 13); % 13 grades (A+ to E)

    % Classify marks into grades
    for j = 1:m
        if (mark(j) >= 90)
            count_grade(1) = count_grade(1) + 1;
        elseif (mark(j) >= 80)
            count_grade(2) = count_grade(2) + 1;
        elseif (mark(j) >= 75)
            count_grade(3) = count_grade(3) + 1;
        elseif (mark(j) >= 70)
            count_grade(4) = count_grade(4) + 1;
        elseif (mark(j) >= 65)
            count_grade(5) = count_grade(5) + 1;
        elseif (mark(j) >= 60)
            count_grade(6) = count_grade(6) + 1;
        elseif (mark(j) >= 55)
            count_grade(7) = count_grade(7) + 1;
        elseif (mark(j) >= 50)
            count_grade(8) = count_grade(8) + 1;
        elseif (mark(j) >= 45)
            count_grade(9) = count_grade(9) + 1;
        elseif (mark(j) >= 40)
            count_grade(10) = count_grade(10) + 1;
        elseif (mark(j) >= 35)
            count_grade(11) = count_grade(11) + 1;
        elseif (mark(j) >= 30)
            count_grade(12) = count_grade(12) + 1;
        else
            count_grade(13) = count_grade(13) + 1;
        end
    end

    % Plot the bar chart
    subplot(1, length(filename), i);
    grades = {'A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'E'};
    bar(count_grade, 'FaceColor', 'b');
    set(gca, 'XTick', 1:length(grades), 'XTickLabel', grades);
    ylim([0 max(count_grade) + 2]);
    xlabel('Grades');
    ylabel('Number of Students');
    title(titles{i});

    % Display counts above bars
    for k = 1:length(count_grade)
        text(k, count_grade(k) + 0.5, num2str(count_grade(k)), 'HorizontalAlignment', 'center');
    end

    % Add a text summary
    status = sprintf('Highest mark: %d\nLowest mark: %d\nTotal students: %d', highest, lowest, totalstudent);
    text(length(grades) + 0.5, max(count_grade), ...
    status, 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', 'FontSize', 10);

    % Preallocate 'count_repeat' for maximum possible size
    count_repeat = cell(m, 1); % Preallocate a cell array with 'm' rows
    repeat_count = 0; % Counter to track the number of students who need to repeat

    for l = 1:m
        if mark(l) < 40
            repeat_count = repeat_count + 1; % Increment counter
            count_repeat{repeat_count} = ID{l}; % Store the ID in the preallocated array
        end
    end

    % Trim unused portion of 'count_repeat'
    count_repeat = count_repeat(1:repeat_count);

    % Display IDs of students who need to repeat
    if ~isempty(count_repeat)
        fprintf('Students who need to repeat for %s:\n', titles{i});
        fprintf('%s\n', count_repeat{:}); % Print IDs as strings
    else
        fprintf('No students have to repeat for %s.\n', titles{i});
    end
end