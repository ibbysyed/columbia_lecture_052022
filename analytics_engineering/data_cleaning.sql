
-- creates a table that basically figures out the ranking for each event
-- for each user 

create table events_ranked as (
    select *, 
    row_number () OVER (PARTITION BY user_domain_id
     ORDER BY event_timestamp ASC NULLS LAST, random() desc NULLS LAST) ranker
     from test_events
);

-- gets the first record for each user
drop table first_event;
create table first_event as (
    select 
	user_domain_id,
	user_custom_id,
	utm_campaign campaign_converted_from, 
	utm_content ad_converted_from, 
	utm_source source_converted_from,
	utm_medium medium_conversion,
	referer_medium initial_referral_medium,
	geo_timezone geographic_timezone, 
	device_type user_device_type,
	case when device_is_mobile then 'mobile' else 'desktop' end as mobile_or_desktop_user, 
	user_genre user_preferred_genre
	from events_ranked
    where ranker = 1
);

-- does some calcs based on the first time a user joined (attribution)

drop table demo_user_features;
create table demo_user_features as (
select
	d.user_domain_id,
	d.user_custom_id,
	f.campaign_converted_from, 
	f.ad_converted_from, 
	f.source_converted_from,
	f.medium_conversion,
	f.initial_referral_medium,
	f.geographic_timezone, 
	f.user_device_type,
	f.mobile_or_desktop_user, 
	f.user_preferred_genre,
	sum(case when d.page_definition = 'hd' then 1 else 0 end) as high_definition_episode_watches, 
	sum(case when d.page_definition = 'sd' then 1 else 0 end) as standard_definition_watches, 
	sum(case when d.page_url_path = '/law_order' then 1 else 0 end) as law_and_order_watches,
	sum(case when d.page_url_path = '/brooklyn_99' then 1 else 0 end) as brooklyn_99_watches,
	sum(d.seconds_buffered) as total_seconds_buffered,
	avg(d.seconds_buffered) as average_seconds_buffered,
	sum(d.minutes_watched) as total_minutes_watched,
	avg(d.minutes_watched) as average_minutes_watched
	from test_events d
	left join first_event f on f.user_domain_id = d.user_domain_id
group by 1,2,3,4,5,6,7,8,9,10,11)

