create or replace view aggJoin1158830326814487762 as (
with aggView5642316572290111399 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView5642316572290111399 where mc.company_id=aggView5642316572290111399.v1);
create or replace view aggJoin4467216184329170072 as (
with aggView1411401231993486499 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin1158830326814487762 join aggView1411401231993486499 using(v8));
create or replace view aggJoin218830156077728150 as (
with aggView5694412820097434996 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView5694412820097434996 where mi.info_type_id=aggView5694412820097434996.v12);
create or replace view aggJoin4960606958454447654 as (
with aggView9043309936801766229 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView9043309936801766229 where miidx.info_type_id=aggView9043309936801766229.v10);
create or replace view aggJoin3272100896693484617 as (
with aggView5453317898077914198 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView5453317898077914198 where t.kind_id=aggView5453317898077914198.v14 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin5280570473165638119 as (
with aggView3153743442210661113 as (select v22, MIN(v32) as v45 from aggJoin3272100896693484617 group by v22)
select v22, v43 as v43, v45 from aggJoin4467216184329170072 join aggView3153743442210661113 using(v22));
create or replace view aggJoin4144236978545830874 as (
with aggView6008819499196259517 as (select v22, MIN(v43) as v43, MIN(v45) as v45 from aggJoin5280570473165638119 group by v22,v43,v45)
select v22, v29, v43, v45 from aggJoin4960606958454447654 join aggView6008819499196259517 using(v22));
create or replace view aggJoin3371409715353517969 as (
with aggView4862166865852320031 as (select v22, MIN(v43) as v43, MIN(v45) as v45, MIN(v29) as v44 from aggJoin4144236978545830874 group by v22,v43,v45)
select v43, v45, v44 from aggJoin218830156077728150 join aggView4862166865852320031 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3371409715353517969;
