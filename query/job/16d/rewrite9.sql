create or replace view aggView2015766184897168910 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin5602181638502453540 as (
with aggView4874773143508571025 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView4874773143508571025 where mc.company_id=aggView4874773143508571025.v28);
create or replace view aggJoin4063094529109694820 as (
with aggView2640701010710382334 as (select v11 from aggJoin5602181638502453540 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView2640701010710382334 where t.id=aggView2640701010710382334.v11 and episode_nr>=5 and episode_nr<100);
create or replace view aggView5708311097546341475 as select v44, v11 from aggJoin4063094529109694820 group by v44,v11;
create or replace view aggJoin4501130805422471962 as (
with aggView5147032853608938161 as (select v2, MIN(v3) as v55 from aggView2015766184897168910 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView5147032853608938161 where ci.person_id=aggView5147032853608938161.v2);
create or replace view aggJoin300637597696831073 as (
with aggView6042355022994548726 as (select id as v2 from name as n)
select v11, v55 from aggJoin4501130805422471962 join aggView6042355022994548726 using(v2));
create or replace view aggJoin6647313667011422192 as (
with aggView3071344891783508448 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView3071344891783508448 where mk.keyword_id=aggView3071344891783508448.v33);
create or replace view aggJoin7904540821554448032 as (
with aggView3006816653130488656 as (select v11 from aggJoin6647313667011422192 group by v11)
select v11, v55 as v55 from aggJoin300637597696831073 join aggView3006816653130488656 using(v11));
create or replace view aggJoin7845829068732461158 as (
with aggView4126369454129710465 as (select v11, MIN(v55) as v55 from aggJoin7904540821554448032 group by v11,v55)
select v44, v55 from aggView5708311097546341475 join aggView4126369454129710465 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin7845829068732461158;
