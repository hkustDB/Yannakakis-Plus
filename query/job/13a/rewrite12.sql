create or replace view aggJoin2244751566058423501 as (
with aggView250496257551190906 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView250496257551190906 where mc.company_type_id=aggView250496257551190906.v8);
create or replace view aggJoin8355512230555368001 as (
with aggView118679407366936369 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView118679407366936369 where miidx.info_type_id=aggView118679407366936369.v10);
create or replace view aggJoin7643941119434702882 as (
with aggView1792797599269656822 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView1792797599269656822 where mi.info_type_id=aggView1792797599269656822.v12);
create or replace view aggJoin6144819087994127778 as (
with aggView8083542021228846770 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin2244751566058423501 join aggView8083542021228846770 using(v1));
create or replace view aggJoin3150013944334999391 as (
with aggView5018244366883503232 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView5018244366883503232 where t.kind_id=aggView5018244366883503232.v14);
create or replace view aggJoin4612430395482311188 as (
with aggView178239942597694486 as (select v22, MIN(v32) as v45 from aggJoin3150013944334999391 group by v22)
select v22, v45 from aggJoin6144819087994127778 join aggView178239942597694486 using(v22));
create or replace view aggJoin9115636734044540323 as (
with aggView3968499047459606146 as (select v22, MIN(v45) as v45 from aggJoin4612430395482311188 group by v22,v45)
select v22, v29, v45 from aggJoin8355512230555368001 join aggView3968499047459606146 using(v22));
create or replace view aggJoin3897734173172660131 as (
with aggView8803564904584657949 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin9115636734044540323 group by v22,v45)
select v24, v45, v44 from aggJoin7643941119434702882 join aggView8803564904584657949 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3897734173172660131;
