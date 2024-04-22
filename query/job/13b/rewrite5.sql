create or replace view aggJoin6139457454149130854 as (
with aggView2242865425831688807 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView2242865425831688807 where mc.company_id=aggView2242865425831688807.v1);
create or replace view aggJoin8999698672648494200 as (
with aggView4464051470281223317 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin6139457454149130854 join aggView4464051470281223317 using(v8));
create or replace view aggJoin8299154220160923067 as (
with aggView4948724309422271201 as (select v22, MIN(v43) as v43 from aggJoin8999698672648494200 group by v22,v43)
select id as v22, title as v32, kind_id as v14, v43 from title as t, aggView4948724309422271201 where t.id=aggView4948724309422271201.v22 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin4175907153231086849 as (
with aggView462890534689992304 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView462890534689992304 where mi.info_type_id=aggView462890534689992304.v12);
create or replace view aggJoin6662938877566960953 as (
with aggView5881198662435037063 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView5881198662435037063 where miidx.info_type_id=aggView5881198662435037063.v10);
create or replace view aggJoin2124894710624769486 as (
with aggView8410490101709958015 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v43 from aggJoin8299154220160923067 join aggView8410490101709958015 using(v14));
create or replace view aggJoin7254655843838800811 as (
with aggView9177794301335719734 as (select v22, MIN(v43) as v43, MIN(v32) as v45 from aggJoin2124894710624769486 group by v22,v43)
select v22, v29, v43, v45 from aggJoin6662938877566960953 join aggView9177794301335719734 using(v22));
create or replace view aggJoin1091622309893537228 as (
with aggView5287392011751395216 as (select v22, MIN(v43) as v43, MIN(v45) as v45, MIN(v29) as v44 from aggJoin7254655843838800811 group by v22,v43,v45)
select v43, v45, v44 from aggJoin4175907153231086849 join aggView5287392011751395216 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1091622309893537228;
