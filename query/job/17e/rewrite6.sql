create or replace view aggJoin954485415105596346 as (
with aggView2070185154432152369 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView2070185154432152369 where mc.movie_id=aggView2070185154432152369.v3);
create or replace view aggJoin3083467788283292856 as (
with aggView6824775825430200367 as (select id as v20 from company_name as cn where country_code= '[us]')
select v3 from aggJoin954485415105596346 join aggView6824775825430200367 using(v20));
create or replace view aggJoin970047309667183896 as (
with aggView3514168594975380195 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView3514168594975380195 where mk.keyword_id=aggView3514168594975380195.v25);
create or replace view aggJoin5116067934811350494 as (
with aggView4783582131707009824 as (select v3 from aggJoin3083467788283292856 group by v3)
select v3 from aggJoin970047309667183896 join aggView4783582131707009824 using(v3));
create or replace view aggJoin2063316730987604995 as (
with aggView7506088489452707906 as (select v3 from aggJoin5116067934811350494 group by v3)
select person_id as v26 from cast_info as ci, aggView7506088489452707906 where ci.movie_id=aggView7506088489452707906.v3);
create or replace view aggJoin5104648892001882591 as (
with aggView5203086096972659324 as (select v26 from aggJoin2063316730987604995 group by v26)
select name as v27 from name as n, aggView5203086096972659324 where n.id=aggView5203086096972659324.v26);
create or replace view aggView4721408675292491046 as select v27 from aggJoin5104648892001882591 group by v27;
select MIN(v27) as v47 from aggView4721408675292491046;
