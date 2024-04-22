create or replace view aggJoin7415471969038750260 as (
with aggView5578030013121318706 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView5578030013121318706 where ml.link_type_id=aggView5578030013121318706.v13);
create or replace view aggJoin6038503477634113030 as (
with aggView5422485090414265956 as (select id as v29, title as v46 from title as t where production_year<=2000 and production_year>=1950)
select v29, v45, v46 from aggJoin7415471969038750260 join aggView5422485090414265956 using(v29));
create or replace view aggJoin8333599242446001345 as (
with aggView1206308959839354718 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView1206308959839354718 where mc.company_id=aggView1206308959839354718.v17);
create or replace view aggJoin3472025131492609095 as (
with aggView3194103013767188376 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3194103013767188376 where mk.keyword_id=aggView3194103013767188376.v27);
create or replace view aggJoin2997616685481695767 as (
with aggView4332401569768149692 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v29 from aggJoin3472025131492609095 join aggView4332401569768149692 using(v29));
create or replace view aggJoin8747939647761184228 as (
with aggView5320252812209948120 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin6038503477634113030 group by v29,v46,v45)
select v29, v45, v46 from aggJoin2997616685481695767 join aggView5320252812209948120 using(v29));
create or replace view aggJoin3143971587177649752 as (
with aggView6627248641908167354 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin8333599242446001345 join aggView6627248641908167354 using(v18));
create or replace view aggJoin4273481298489923024 as (
with aggView2776302758236445041 as (select v29, MIN(v44) as v44 from aggJoin3143971587177649752 group by v29,v44)
select v45 as v45, v46 as v46, v44 from aggJoin8747939647761184228 join aggView2776302758236445041 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin4273481298489923024;
