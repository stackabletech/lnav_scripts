CREATE TRIGGER IF NOT EXISTS add_vector_specific_filters
    AFTER INSERT ON lnav_events WHEN
    -- Check the event type
    jget(NEW.content, '/$schema') =
    'https://lnav.org/event-file-format-detected-v1.schema.json' AND
    -- Only create the filter when a given format is seen
    jget(NEW.content, '/format') = 'vector_json' AND
    -- Don't create the filter if it's already there
    NOT EXISTS (
SELECT 1 FROM lnav_view_filters WHERE pattern = 'noisy message')
BEGIN
INSERT INTO lnav_view_filters (view_name, enabled, type, pattern) VALUES
    ('log', 1, 'OUT', ':container != \'containerdebug\'');
END;