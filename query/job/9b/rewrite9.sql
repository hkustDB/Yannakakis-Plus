create or replace view aggView7686464232045827404 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin7692820415632680522 as (
with aggView7219489586695283364 as (select name as v36, id as v35 from name as n where gender= 'f')
select v35, v36 from aggView7219489586695283364 where v36 LIKE '%Angel%');
create or replace view aggView2625708252083369788 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin7533624650944157917 as (
with aggView709979878629991153 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView709979878629991153 where mc.company_id=aggView709979878629991153.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin6083709110405614154 as (
with aggView1632327781855933405 as (select v18 from aggJoin7533624650944157917 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView1632327781855933405 where t.id=aggView1632327781855933405.v18 and production_year>=2007 and production_year<=2010);
create or replace view aggView5589369386436348864 as select v47, v18 from aggJoin6083709110405614154 group by v47,v18;
create or replace view aggJoin4899668778549959938 as (
with aggView7392862755423291830 as (select v35, MIN(v36) as v60 from aggJoin7692820415632680522 group by v35)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60 from cast_info as ci, aggView7392862755423291830 where ci.person_id=aggView7392862755423291830.v35 and note= '(voice)');
create or replace view aggJoin5222552377491134150 as (
with aggView114370983222994058 as (select v35, MIN(v3) as v58 from aggView7686464232045827404 group by v35)
select v18, v9, v20, v22, v60 as v60, v58 from aggJoin4899668778549959938 join aggView114370983222994058 using(v35));
create or replace view aggJoin8872121276601830659 as (
with aggView384244467671909311 as (select v18, MIN(v47) as v61 from aggView5589369386436348864 group by v18)
select v9, v20, v22, v60 as v60, v58 as v58, v61 from aggJoin5222552377491134150 join aggView384244467671909311 using(v18));
create or replace view aggJoin1250485532663537281 as (
with aggView1491176138428998664 as (select id as v22 from role_type as rt where role= 'actress')
select v9, v20, v60, v58, v61 from aggJoin8872121276601830659 join aggView1491176138428998664 using(v22));
create or replace view aggJoin6020877272461642321 as (
with aggView8901290063165404693 as (select v9, MIN(v60) as v60, MIN(v58) as v58, MIN(v61) as v61 from aggJoin1250485532663537281 group by v9,v58,v60,v61)
select v10, v60, v58, v61 from aggView2625708252083369788 join aggView8901290063165404693 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin6020877272461642321;
