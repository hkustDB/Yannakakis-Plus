create or replace view aggJoin4151957262080979640 as (
with aggView5765961454922763565 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5765961454922763565 where mk.keyword_id=aggView5765961454922763565.v25);
create or replace view aggJoin6904761045032270903 as (
with aggView7224962328321892248 as (select v3 from aggJoin4151957262080979640 group by v3)
select id as v3 from title as t, aggView7224962328321892248 where t.id=aggView7224962328321892248.v3);
create or replace view aggJoin993070181484388890 as (
with aggView5994176803773778820 as (select v3 from aggJoin6904761045032270903 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView5994176803773778820 where ci.movie_id=aggView5994176803773778820.v3);
create or replace view aggJoin8254100649422129920 as (
with aggView6438851444313180746 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView6438851444313180746 where mc.company_id=aggView6438851444313180746.v20);
create or replace view aggJoin6099440936237896084 as (
with aggView2491977507049305891 as (select v3 from aggJoin8254100649422129920 group by v3)
select v26 from aggJoin993070181484388890 join aggView2491977507049305891 using(v3));
create or replace view aggJoin9105425141868735738 as (
with aggView5755857584414096130 as (select v26 from aggJoin6099440936237896084 group by v26)
select name as v27 from name as n, aggView5755857584414096130 where n.id=aggView5755857584414096130.v26 and name LIKE '%B%');
create or replace view aggView789075752934873898 as select v27 from aggJoin9105425141868735738 group by v27;
select MIN(v27) as v47 from aggView789075752934873898;
