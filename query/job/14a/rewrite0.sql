create or replace view aggJoin7650020952565524645 as (
with aggView5641809259560136401 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView5641809259560136401 where mi_idx.info_type_id=aggView5641809259560136401.v3);
create or replace view aggJoin1549513026187702191 as (
with aggView950047320001576027 as (select v23, v18 from aggJoin7650020952565524645 group by v23,v18)
select v23, v18 from aggView950047320001576027 where v18<'8.5');
create or replace view aggJoin4253455159156020493 as (
with aggView8132110291075651853 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView8132110291075651853 where mk.keyword_id=aggView8132110291075651853.v5);
create or replace view aggJoin2656998290321967782 as (
with aggView5942801411854886922 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView5942801411854886922 where mi.info_type_id=aggView5942801411854886922.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin66944478227158816 as (
with aggView5617214216667183263 as (select v23 from aggJoin4253455159156020493 group by v23)
select v23, v13 from aggJoin2656998290321967782 join aggView5617214216667183263 using(v23));
create or replace view aggJoin2966160611277570914 as (
with aggView401673841784793115 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView401673841784793115 where t.kind_id=aggView401673841784793115.v8 and production_year>2010);
create or replace view aggJoin5565760563114092060 as (
with aggView2095556868723224462 as (select v23 from aggJoin66944478227158816 group by v23)
select v23, v24, v27 from aggJoin2966160611277570914 join aggView2095556868723224462 using(v23));
create or replace view aggView851212362497453043 as select v23, v24 from aggJoin5565760563114092060 group by v23,v24;
create or replace view aggJoin3402644428472066041 as (
with aggView2699685260089078350 as (select v23, MIN(v18) as v35 from aggJoin1549513026187702191 group by v23)
select v24, v35 from aggView851212362497453043 join aggView2699685260089078350 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin3402644428472066041;
