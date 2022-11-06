SELECT
 ab.interval_start,
 ab.interval_end,
 ab.status AS booking_status,
 MAX(lt_desc.text) AS description,
 MAX(lt.text) AS amenity_title,
 ab.id AS booking_id,
 a.id AS amenity_id,
 a.status AS amenity_status,
 a.vendor_id AS vendor_id,
 a.maximum_capacity AS amenity_capacity,
 ab.additional_services AS additional_services,
 ab.submitted_at,
 ab.customer_id AS customer_id,
 a.created_at AS amenity_creation_at,
 (apd.net_price_in_cents/100) AS net_price,
 apd.vat AS vat,
 apd.reservation_unit_time_minutes,
 apd.currency_code AS currency_code,
 v.vendor_type AS vendor_type,
 v.vendor_status AS vendor_status,
 v.created_at AS vendor_created_at,
 hshs.hierarchy_subject_source AS space_id
FROM
 vendors__2022_06_23_0d2a2.vendor v
JOIN
 vendors__2022_06_23_0d2a2.amenity a
ON
 v.id=a.vendor_id
JOIN
 vendors__2022_06_23_0d2a2.amenity_booking ab
ON
 ab.amenity_id = a.id
JOIN
 vendors__2022_06_23_0d2a2.amenity_title at2
ON
 at2.title_id = a.id
JOIN
 vendors__2022_06_23_0d2a2.localized_text lt
ON
 lt.id = at2.localized_text_id
JOIN
 vendors__2022_06_23_0d2a2.amenity_description ad
ON
 ad.description_id = a.id
JOIN
 vendors__2022_06_23_0d2a2.localized_text lt_desc
ON
 lt_desc.id = ad.localized_text_id
LEFT JOIN
 vendors__2022_06_23_0d2a2.amenity_payment_details apd
ON
 a.amenity_payment_details_id=apd.id
JOIN
 vendors__2022_06_23_0d2a2.hierarchy_subject hsv
ON
 a.vendor_id = hsv.id
 AND hsv.subject_type = 'vendor'
JOIN
 vendors__2022_06_23_0d2a2.hierarchy_subject_hierarchy_subject hshs
ON
 hshs.hierarchy_subject_target = hsv.id
JOIN
 vendors__2022_06_23_0d2a2.hierarchy_subject hs
ON
 hs.id = hshs.hierarchy_subject_source
 AND hs.subject_type = 'space'
WHERE
 ab.submitted_at IS NOT NULL
GROUP BY
 booking_id,
 a.id,
 amenity_status,
 a.vendor_id,
 amenity_capacity,
 booking_status,
 ab.interval_start,
 ab.interval_end,
 additional_services,
 ab.submitted_at,
 customer_id,
 amenity_creation_at,
 net_price,
 vat,
 apd.reservation_unit_time_minutes,
 currency_code,
 vendor_type,
 vendor_status,
 vendor_created_at,
 space_id
ORDER BY
 ab.interval_start,
 ab.interval_end