create or replace view aggJoin2937529728950399072 as (
with aggView4425330582825477745 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView4425330582825477745 where an.person_id=aggView4425330582825477745.v2);
create or replace view aggView4303656964134372390 as select v2, v3 from aggJoin2937529728950399072 group by v2,v3;
create or replace view aggJoin2453523328692664788 as (
with aggView5440570953901259428 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView5440570953901259428 where mc.company_id=aggView5440570953901259428.v28);
create or replace view aggJoin7858090631879298315 as (
with aggView9045071277231083545 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView9045071277231083545 where mk.keyword_id=aggView9045071277231083545.v33);
create or replace view aggJoin3181653623200969407 as (
with aggView743106247503063314 as (select v11 from aggJoin7858090631879298315 group by v11)
select v11 from aggJoin2453523328692664788 join aggView743106247503063314 using(v11));
create or replace view aggJoin1678346774268457419 as (
with aggView4805655608373426037 as (select v11 from aggJoin3181653623200969407 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView4805655608373426037 where t.id=aggView4805655608373426037.v11 and episode_nr>=5 and episode_nr<100);
create or replace view aggView2218910840857209875 as select v44, v11 from aggJoin1678346774268457419 group by v44,v11;
create or replace view aggJoin2320035378573931512 as (
with aggView8826467123848142054 as (select v2, MIN(v3) as v55 from aggView4303656964134372390 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView8826467123848142054 where ci.person_id=aggView8826467123848142054.v2);
create or replace view aggJoin2614604921291715529 as (
with aggView1505320728548730536 as (select v11, MIN(v55) as v55 from aggJoin2320035378573931512 group by v11,v55)
select v44, v55 from aggView2218910840857209875 join aggView1505320728548730536 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin2614604921291715529;
