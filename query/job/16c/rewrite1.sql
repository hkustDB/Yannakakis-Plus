create or replace view aggView1761159884163818117 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin447438355549451924 as (
with aggView5162943963425833925 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView5162943963425833925 where mk.keyword_id=aggView5162943963425833925.v33);
create or replace view aggJoin6751921922556133573 as (
with aggView6314833255384706300 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView6314833255384706300 where mc.company_id=aggView6314833255384706300.v28);
create or replace view aggJoin1069712450365164637 as (
with aggView4232109586329925926 as (select v11 from aggJoin447438355549451924 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView4232109586329925926 where t.id=aggView4232109586329925926.v11 and episode_nr<100);
create or replace view aggJoin9183299066068855813 as (
with aggView1080256212325162035 as (select v11 from aggJoin6751921922556133573 group by v11)
select v11, v44, v52 from aggJoin1069712450365164637 join aggView1080256212325162035 using(v11));
create or replace view aggView8946785134863282242 as select v44, v11 from aggJoin9183299066068855813 group by v44,v11;
create or replace view aggJoin346394767830730772 as (
with aggView518292625098722846 as (select v11, MIN(v44) as v56 from aggView8946785134863282242 group by v11)
select person_id as v2, v56 from cast_info as ci, aggView518292625098722846 where ci.movie_id=aggView518292625098722846.v11);
create or replace view aggJoin2222087153380092442 as (
with aggView2509633652692293624 as (select id as v2 from name as n)
select v2, v56 from aggJoin346394767830730772 join aggView2509633652692293624 using(v2));
create or replace view aggJoin2941697452199713849 as (
with aggView5638882948088530347 as (select v2, MIN(v56) as v56 from aggJoin2222087153380092442 group by v2,v56)
select v3, v56 from aggView1761159884163818117 join aggView5638882948088530347 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin2941697452199713849;
