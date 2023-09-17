data=readtable("filled_dataset.csv");

negativeRows = any(data.total_items < 0 | data.subtotal < 0 | data.num_distinct_items < 0 | ...
    data.min_item_price < 0 | data.max_item_price < 0 | data.total_onshift_partners < 0 | ...
    data.total_busy_partners < 0 | data.total_outstanding_orders < 0, 2);

cleanedData = data(~negativeRows, :);

filename = 'cleaned_dataset.csv';
writetable(cleanedData, filename);
