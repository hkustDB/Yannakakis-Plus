create or replace view aggView6072402387007635230 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin5054712494885863850 as (
with aggView5451240539084310971 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView5451240539084310971 where mc.company_id=aggView5451240539084310971.v28);
create or replace view aggJoin4086277483736749828 as (
with aggView4011719610413061090 as (select v11 from aggJoin5054712494885863850 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView4011719610413061090 where t.id=aggView4011719610413061090.v11 and episode_nr>=5 and episode_nr<100);
create or replace view aggView3314691420818486871 as select v44, v11 from aggJoin4086277483736749828 group by v44,v11;
create or replace view aggJoin2395820521349086985 as (
with aggView8089595089915879002 as (select v11, MIN(v44) as v56 from aggView3314691420818486871 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView8089595089915879002 where ci.movie_id=aggView8089595089915879002.v11);
create or replace view aggJoin6200889639470577886 as (
with aggView7995521651715569265 as (select id as v2 from name as n)
select v2, v11, v56 from aggJoin2395820521349086985 join aggView7995521651715569265 using(v2));
create or replace view aggJoin5883940504818093846 as (
with aggView6494720781656377298 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView6494720781656377298 where mk.keyword_id=aggView6494720781656377298.v33);
create or replace view aggJoin2937531179624851545 as (
with aggView6519136562158057085 as (select v11 from aggJoin5883940504818093846 group by v11)
select v2, v56 as v56 from aggJoin6200889639470577886 join aggView6519136562158057085 using(v11));
create or replace view aggJoin7313562498890586319 as (
with aggView7939811506110768556 as (select v2, MIN(v56) as v56 from aggJoin2937531179624851545 group by v2,v56)
select v3, v56 from aggView6072402387007635230 join aggView7939811506110768556 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin7313562498890586319;
