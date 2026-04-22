-- SELECT *
-- FROM edge_walkability_scores
-- WHERE edge_id = 24395;

-- SELECT *
-- FROM edge_walkability_scores
-- LIMIT 100;

-- SELECT COUNT(*) 
-- FROM ways;
-- SELECT w.id, w.name, s.base_safety_cost, w.geom 
-- FROM ways w
-- JOIN edge_walkability_scores s ON w.id = s.edge_id
-- WHERE w.geom && ST_MakeEnvelope(-84.3895, 33.7710, -84.3815, 33.7820, 4326);

-- CREATE TABLE manual_edges(edge_id);

-- INSERT INTO manual_edges (edge_id)
-- SELECT CAST(value AS BIGINT)
-- FROM regexp_split_to_table(
-- $$
-- 18039
-- 4307
-- 10516
-- 12058
-- 22827
-- 4053
-- 14524
-- 10515
-- 9414
-- 19134
-- $$,
-- E'\n'
-- ) AS value
-- WHERE value <> '';

-- UPDATE edge_walkability_scores s
-- SET 
--     sidewalk_quality = vals.sidewalk,
--     lighting_density = vals.lighting,
--     business_activity = vals.business
-- FROM ways w,
-- LATERAL (
--     SELECT 
--         FLOOR(2 + RANDOM() * 3) AS sidewalk,
--         FLOOR(RANDOM() * 3) AS lighting,
--         FLOOR(RANDOM() * 3) AS business
-- ) vals
-- WHERE w.id = s.edge_id
--   AND w.geom && ST_MakeEnvelope(-84.3895, 33.7710, -84.3815, 33.7820, 4326)
--   AND s.edge_id NOT IN (
--       SELECT edge_id FROM manual_edges
--   );

-- SELECT 
--     w.id, 
--     w.name,
--     s.sidewalk_quality,
--     s.lighting_density,
--     s.business_activity,
--     s.base_safety_cost,
-- 	s.base_night_safety_cost
-- FROM ways w
-- JOIN edge_walkability_scores s 
--   ON w.id = s.edge_id
-- WHERE w.geom && ST_MakeEnvelope(-84.3895, 33.7710, -84.3815, 33.7820, 4326);

-- UPDATE edge_walkability_scores s
-- SET base_safety_cost = GREATEST(6 * (5 - s.sidewalk_quality) + 1 * (2 - s.lighting_density) + 3 * (2 - s.business_activity))
-- FROM ways w
-- WHERE w.id = s.edge_id
--   AND w.geom && ST_MakeEnvelope(-84.3895, 33.7710, -84.3815, 33.7820, 4326);

-- ALTER TABLE edge_walkability_scores
-- ADD COLUMN base_night_safety_cost DOUBLE PRECISION;

-- UPDATE edge_walkability_scores s
-- SET base_night_safety_cost = GREATEST(2 * (5 - s.sidewalk_quality) + 5 * (2 - s.lighting_density) + 3 * (2 - s.business_activity))
-- FROM ways w
-- WHERE w.id = s.edge_id
--   AND w.geom && ST_MakeEnvelope(-84.3895, 33.7710, -84.3815, 33.7820, 4326);