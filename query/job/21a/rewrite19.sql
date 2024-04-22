create or replace view aggJoin6122662393356471373 as (
with aggView2024587718563959253 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView2024587718563959253 where ml.link_type_id=aggView2024587718563959253.v13);
create or replace view aggJoin8476711840078873235 as (
with aggView9012216987224650531 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView9012216987224650531 where mc.company_id=aggView9012216987224650531.v17);
create or replace view aggJoin4896087726768393176 as (
with aggView4009972439576329078 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView4009972439576329078 where mk.keyword_id=aggView4009972439576329078.v27);
create or replace view aggJoin6123107402190849803 as (
with aggView9187935088195128492 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v29 from aggJoin4896087726768393176 join aggView9187935088195128492 using(v29));
create or replace view aggJoin3840562390615729099 as (
with aggView8993601188972060693 as (select v29, MIN(v45) as v45 from aggJoin6122662393356471373 group by v29,v45)
select v29, v45 from aggJoin6123107402190849803 join aggView8993601188972060693 using(v29));
create or replace view aggJoin6064957088066202450 as (
with aggView2817878958478117980 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin8476711840078873235 join aggView2817878958478117980 using(v18));
create or replace view aggJoin6407870222129517067 as (
with aggView6560081432623331235 as (select v29, MIN(v44) as v44 from aggJoin6064957088066202450 group by v29,v44)
select id as v29, title as v33, production_year as v36, v44 from title as t, aggView6560081432623331235 where t.id=aggView6560081432623331235.v29 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin1537237908909725209 as (
with aggView800563352014411682 as (select v29, MIN(v44) as v44, MIN(v33) as v46 from aggJoin6407870222129517067 group by v29,v44)
select v45 as v45, v44, v46 from aggJoin3840562390615729099 join aggView800563352014411682 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin1537237908909725209;
