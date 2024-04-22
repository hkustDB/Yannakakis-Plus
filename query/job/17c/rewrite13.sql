create or replace view aggJoin3458080286651743211 as (
with aggView4378830696903795612 as (select id as v26, name as v47 from name as n where name LIKE 'X%')
select movie_id as v3, v47 from cast_info as ci, aggView4378830696903795612 where ci.person_id=aggView4378830696903795612.v26);
create or replace view aggJoin8769227498227869341 as (
with aggView5646842446068380090 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView5646842446068380090 where mc.company_id=aggView5646842446068380090.v20);
create or replace view aggJoin5204916094446429706 as (
with aggView644472511918698983 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView644472511918698983 where mk.keyword_id=aggView644472511918698983.v25);
create or replace view aggJoin6881151219803342596 as (
with aggView3056673949655926188 as (select v3 from aggJoin8769227498227869341 group by v3)
select v3 from aggJoin5204916094446429706 join aggView3056673949655926188 using(v3));
create or replace view aggJoin7713365092280874578 as (
with aggView4869645971664334758 as (select v3 from aggJoin6881151219803342596 group by v3)
select id as v3 from title as t, aggView4869645971664334758 where t.id=aggView4869645971664334758.v3);
create or replace view aggJoin8629271982415737415 as (
with aggView6760353537970599226 as (select v3 from aggJoin7713365092280874578 group by v3)
select v47 as v47 from aggJoin3458080286651743211 join aggView6760353537970599226 using(v3));
select MIN(v47) as v47 from aggJoin8629271982415737415;
