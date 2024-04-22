create or replace view aggView1665513694980106134 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin8958182655822117230 as (
with aggView1310872621401529521 as (select name as v36, id as v35 from name as n where gender= 'f')
select v35, v36 from aggView1310872621401529521 where v36 LIKE '%Angel%');
create or replace view aggView3751525196948012038 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin3848016762683633552 as (
with aggView3346111712528588885 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView3346111712528588885 where mc.company_id=aggView3346111712528588885.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin4325952356808267037 as (
with aggView821384177147776293 as (select v18 from aggJoin3848016762683633552 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView821384177147776293 where t.id=aggView821384177147776293.v18 and production_year>=2007 and production_year<=2010);
create or replace view aggView4928840026842392870 as select v47, v18 from aggJoin4325952356808267037 group by v47,v18;
create or replace view aggJoin3188862516605643745 as (
with aggView3560407973547591356 as (select v35, MIN(v3) as v58 from aggView1665513694980106134 group by v35)
select v35, v36, v58 from aggJoin8958182655822117230 join aggView3560407973547591356 using(v35));
create or replace view aggJoin5860334409226928095 as (
with aggView1320218585430450865 as (select v35, MIN(v58) as v58, MIN(v36) as v60 from aggJoin3188862516605643745 group by v35,v58)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v58, v60 from cast_info as ci, aggView1320218585430450865 where ci.person_id=aggView1320218585430450865.v35 and note= '(voice)');
create or replace view aggJoin4034770899380671984 as (
with aggView967763353829208208 as (select v18, MIN(v47) as v61 from aggView4928840026842392870 group by v18)
select v9, v20, v22, v58 as v58, v60 as v60, v61 from aggJoin5860334409226928095 join aggView967763353829208208 using(v18));
create or replace view aggJoin838539249429304192 as (
with aggView8456157835817028396 as (select id as v22 from role_type as rt where role= 'actress')
select v9, v20, v58, v60, v61 from aggJoin4034770899380671984 join aggView8456157835817028396 using(v22));
create or replace view aggJoin8515588257926952894 as (
with aggView2285607678560146842 as (select v9, MIN(v58) as v58, MIN(v60) as v60, MIN(v61) as v61 from aggJoin838539249429304192 group by v9,v58,v60,v61)
select v10, v58, v60, v61 from aggView3751525196948012038 join aggView2285607678560146842 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin8515588257926952894;
