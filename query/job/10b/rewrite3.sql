create or replace view aggView8847101434423959069 as select id as v1, name as v2 from char_name as chn;
create or replace view aggView2933921177043685152 as select title as v32, id as v31 from title as t where production_year>2010;
create or replace view aggJoin1277826525766407680 as (
with aggView9015032691257761686 as (select v1, MIN(v2) as v43 from aggView8847101434423959069 group by v1)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView9015032691257761686 where ci.person_role_id=aggView9015032691257761686.v1 and note LIKE '%(producer)%');
create or replace view aggJoin1257015986539760701 as (
with aggView3755874890886865939 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v12, v43 from aggJoin1277826525766407680 join aggView3755874890886865939 using(v29));
create or replace view aggJoin5754447430953836370 as (
with aggView3040014537424827589 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView3040014537424827589 where mc.company_type_id=aggView3040014537424827589.v22);
create or replace view aggJoin4767173253826806178 as (
with aggView4609406937985300766 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin5754447430953836370 join aggView4609406937985300766 using(v15));
create or replace view aggJoin2739661096745759795 as (
with aggView6086622030721866284 as (select v31 from aggJoin4767173253826806178 group by v31)
select v31, v12, v43 as v43 from aggJoin1257015986539760701 join aggView6086622030721866284 using(v31));
create or replace view aggJoin4493130980067733523 as (
with aggView9121187214990391044 as (select v31, MIN(v43) as v43 from aggJoin2739661096745759795 group by v31,v43)
select v32, v43 from aggView2933921177043685152 join aggView9121187214990391044 using(v31));
select MIN(v43) as v43,MIN(v32) as v44 from aggJoin4493130980067733523;
