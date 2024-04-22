create or replace view aggJoin8942873372609846299 as (
with aggView1189817154531425447 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView1189817154531425447 where an.person_id=aggView1189817154531425447.v2);
create or replace view aggView867647805837739764 as select v2, v3 from aggJoin8942873372609846299 group by v2,v3;
create or replace view aggJoin6473376605769797573 as (
with aggView8844652628183335664 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView8844652628183335664 where mk.keyword_id=aggView8844652628183335664.v33);
create or replace view aggJoin2096614104741402961 as (
with aggView7011189589617371167 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView7011189589617371167 where mc.company_id=aggView7011189589617371167.v28);
create or replace view aggJoin9013652306432944289 as (
with aggView1504573101854372625 as (select v11 from aggJoin6473376605769797573 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView1504573101854372625 where t.id=aggView1504573101854372625.v11 and episode_nr<100);
create or replace view aggJoin4646456470244033810 as (
with aggView4076827196000318468 as (select v11 from aggJoin2096614104741402961 group by v11)
select v11, v44, v52 from aggJoin9013652306432944289 join aggView4076827196000318468 using(v11));
create or replace view aggView6420156931929853530 as select v44, v11 from aggJoin4646456470244033810 group by v44,v11;
create or replace view aggJoin5269700590157659400 as (
with aggView4587756198657305157 as (select v11, MIN(v44) as v56 from aggView6420156931929853530 group by v11)
select person_id as v2, v56 from cast_info as ci, aggView4587756198657305157 where ci.movie_id=aggView4587756198657305157.v11);
create or replace view aggJoin4591719325051776246 as (
with aggView4424289328860361003 as (select v2, MIN(v56) as v56 from aggJoin5269700590157659400 group by v2,v56)
select v3, v56 from aggView867647805837739764 join aggView4424289328860361003 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin4591719325051776246;
