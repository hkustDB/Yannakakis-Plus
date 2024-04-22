create or replace view aggJoin5284434863359378703 as (
with aggView956620787152476195 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView956620787152476195 where ml.link_type_id=aggView956620787152476195.v13);
create or replace view aggJoin520797438077751803 as (
with aggView4826180547638009223 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView4826180547638009223 where mc.company_id=aggView4826180547638009223.v17);
create or replace view aggJoin9017623035401982242 as (
with aggView8017092791463724077 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView8017092791463724077 where mk.keyword_id=aggView8017092791463724077.v27);
create or replace view aggJoin5534003663548254919 as (
with aggView3110296017420856575 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin520797438077751803 join aggView3110296017420856575 using(v18));
create or replace view aggJoin7215128105447599753 as (
with aggView2461511215676694572 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView2461511215676694572 where t.id=aggView2461511215676694572.v29 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin8680666000935035625 as (
with aggView291204873183480344 as (select v29, MIN(v33) as v46 from aggJoin7215128105447599753 group by v29)
select v29, v44 as v44, v46 from aggJoin5534003663548254919 join aggView291204873183480344 using(v29));
create or replace view aggJoin5755802224175281594 as (
with aggView1318511786085355903 as (select v29, MIN(v44) as v44, MIN(v46) as v46 from aggJoin8680666000935035625 group by v29,v46,v44)
select v29, v45 as v45, v44, v46 from aggJoin5284434863359378703 join aggView1318511786085355903 using(v29));
create or replace view aggJoin1779493896333193052 as (
with aggView2809746736545838546 as (select v29, MIN(v45) as v45, MIN(v44) as v44, MIN(v46) as v46 from aggJoin5755802224175281594 group by v29,v46,v44,v45)
select v45, v44, v46 from aggJoin9017623035401982242 join aggView2809746736545838546 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin1779493896333193052;
