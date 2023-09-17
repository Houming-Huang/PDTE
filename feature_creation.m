cleanedData = readtable('cleaned_dataset.csv');

timeDiff = seconds(cleanedData.actual_delivery_time - cleanedData.created_at);
cleanedData.time_diff = timeDiff;

cleanedData.actual_delivery_time = [];
cleanedData.created_at = [];

newFilename = 'processed_dataset.csv';
writetable(cleanedData, newFilename);
