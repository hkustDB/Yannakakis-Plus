create or replace view aggJoin5911320777668262398 as (
with aggView2480130736644117559 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView2480130736644117559 where mc.company_id=aggView2480130736644117559.v20);
create or replace view aggJoin984582943340645798 as (
with aggView2766119089729273383 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2766119089729273383 where mk.keyword_id=aggView2766119089729273383.v25);
create or replace view aggJoin4249233427552518487 as (
with aggView6918630282030750557 as (select v3 from aggJoin984582943340645798 group by v3)
select id as v3 from title as t, aggView6918630282030750557 where t.id=aggView6918630282030750557.v3);
create or replace view aggJoin3521583502179663084 as (
with aggView2025786666373642301 as (select v3 from aggJoin5911320777668262398 group by v3)
select v3 from aggJoin4249233427552518487 join aggView2025786666373642301 using(v3));
create or replace view aggJoin5243109472471494069 as (
with aggView7665178264667570347 as (select v3 from aggJoin3521583502179663084 group by v3)
select person_id as v26 from cast_info as ci, aggView7665178264667570347 where ci.movie_id=aggView7665178264667570347.v3);
create or replace view aggJoin3289639478089080896 as (
with aggView8368048895994070069 as (select v26 from aggJoin5243109472471494069 group by v26)
select name as v27 from name as n, aggView8368048895994070069 where n.id=aggView8368048895994070069.v26);
create or replace view aggJoin166850354463398014 as (
with aggView3233697599135549025 as (select v27 from aggJoin3289639478089080896 group by v27)
select v27 from aggView3233697599135549025 where v27 LIKE 'B%');
select MIN(v27) as v47 from aggJoin166850354463398014;
