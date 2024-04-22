create or replace view aggJoin2086787430956677188 as (
with aggView6973897802977082451 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView6973897802977082451 where pi.info_type_id=aggView6973897802977082451.v16 and note= 'Volker Boehm');
create or replace view aggJoin6595878213812807373 as (
with aggView3059511926501727380 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView3059511926501727380 where ml.link_type_id=aggView3059511926501727380.v18);
create or replace view aggJoin1534851510830764226 as (
with aggView3311744904067560910 as (select v24 from aggJoin2086787430956677188 group by v24)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView3311744904067560910 where n.id=aggView3311744904067560910.v24 and name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F');
create or replace view aggJoin1987688316856740080 as (
with aggView5803002757133294045 as (select v24, MIN(v25) as v50 from aggJoin1534851510830764226 group by v24)
select person_id as v24, name as v3, v50 from aka_name as an, aggView5803002757133294045 where an.person_id=aggView5803002757133294045.v24 and name LIKE '%a%');
create or replace view aggJoin5781440945620490382 as (
with aggView5591585911847383773 as (select v24, MIN(v50) as v50 from aggJoin1987688316856740080 group by v24,v50)
select movie_id as v38, v50 from cast_info as ci, aggView5591585911847383773 where ci.person_id=aggView5591585911847383773.v24);
create or replace view aggJoin906501731121047385 as (
with aggView1795749273151086547 as (select v38 from aggJoin6595878213812807373 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView1795749273151086547 where t.id=aggView1795749273151086547.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggJoin8613307231384996400 as (
with aggView6162146215616541715 as (select v38, MIN(v39) as v51 from aggJoin906501731121047385 group by v38)
select v50 as v50, v51 from aggJoin5781440945620490382 join aggView6162146215616541715 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin8613307231384996400;
