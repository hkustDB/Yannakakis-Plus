create or replace view aggView2826521298192834492 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin362537351900314581 as (
with aggView8447662996410528939 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView8447662996410528939 where t.kind_id=aggView8447662996410528939.v25 and production_year>2005);
create or replace view aggView8940014281916443445 as select v45, v46 from aggJoin362537351900314581 group by v45,v46;
create or replace view aggJoin3069369118173759606 as (
with aggView823701315211802694 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView823701315211802694 where cc.subject_id=aggView823701315211802694.v5);
create or replace view aggJoin131391939065557195 as (
with aggView4655066256164388461 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView4655066256164388461 where mi_idx.info_type_id=aggView4655066256164388461.v20 and info<'8.5');
create or replace view aggJoin920651230894852392 as (
with aggView3430242605768540728 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin3069369118173759606 join aggView3430242605768540728 using(v7));
create or replace view aggJoin536280408656941591 as (
with aggView6032419754647614549 as (select v45 from aggJoin920651230894852392 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView6032419754647614549 where mi.movie_id=aggView6032419754647614549.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2190809287339024360 as (
with aggView6337588992680865209 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin536280408656941591 join aggView6337588992680865209 using(v18));
create or replace view aggJoin3567549980452756477 as (
with aggView3779158711255491878 as (select v45 from aggJoin2190809287339024360 group by v45)
select movie_id as v45, keyword_id as v22 from movie_keyword as mk, aggView3779158711255491878 where mk.movie_id=aggView3779158711255491878.v45);
create or replace view aggJoin348834779086260629 as (
with aggView6840103843510339062 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v45 from aggJoin3567549980452756477 join aggView6840103843510339062 using(v22));
create or replace view aggJoin1387366758874190413 as (
with aggView2197579722369578428 as (select v45 from aggJoin348834779086260629 group by v45)
select v45, v40 from aggJoin131391939065557195 join aggView2197579722369578428 using(v45));
create or replace view aggView2339114169589374134 as select v45, v40 from aggJoin1387366758874190413 group by v45,v40;
create or replace view aggJoin3628464042185741986 as (
with aggView1019973526886969523 as (select v45, MIN(v46) as v59 from aggView8940014281916443445 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v59 from movie_companies as mc, aggView1019973526886969523 where mc.movie_id=aggView1019973526886969523.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7898277862408293739 as (
with aggView1693826509061765656 as (select v45, MIN(v40) as v58 from aggView2339114169589374134 group by v45)
select v9, v16, v31, v59 as v59, v58 from aggJoin3628464042185741986 join aggView1693826509061765656 using(v45));
create or replace view aggJoin5226285231148391961 as (
with aggView3104215290883436494 as (select id as v16 from company_type as ct)
select v9, v31, v59, v58 from aggJoin7898277862408293739 join aggView3104215290883436494 using(v16));
create or replace view aggJoin8704856621522251643 as (
with aggView262306557663310807 as (select v9, MIN(v59) as v59, MIN(v58) as v58 from aggJoin5226285231148391961 group by v9)
select v10, v59, v58 from aggView2826521298192834492 join aggView262306557663310807 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin8704856621522251643;
