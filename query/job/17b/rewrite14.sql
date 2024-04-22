create or replace view aggJoin3548590055015388021 as (
with aggView41871435435843297 as (select id as v26, name as v47 from name as n where name LIKE 'Z%')
select movie_id as v3, v47 from cast_info as ci, aggView41871435435843297 where ci.person_id=aggView41871435435843297.v26);
create or replace view aggJoin8954030359282087591 as (
with aggView719069186328302441 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView719069186328302441 where mc.company_id=aggView719069186328302441.v20);
create or replace view aggJoin331269944878529751 as (
with aggView2704386053097640450 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2704386053097640450 where mk.keyword_id=aggView2704386053097640450.v25);
create or replace view aggJoin8807339165878304758 as (
with aggView5293015200315907673 as (select v3 from aggJoin331269944878529751 group by v3)
select v3 from aggJoin8954030359282087591 join aggView5293015200315907673 using(v3));
create or replace view aggJoin869912780115512847 as (
with aggView5907811644384349843 as (select v3 from aggJoin8807339165878304758 group by v3)
select id as v3 from title as t, aggView5907811644384349843 where t.id=aggView5907811644384349843.v3);
create or replace view aggJoin2035726330969404020 as (
with aggView4276694562654993427 as (select v3 from aggJoin869912780115512847 group by v3)
select v47 as v47 from aggJoin3548590055015388021 join aggView4276694562654993427 using(v3));
select MIN(v47) as v47 from aggJoin2035726330969404020;
