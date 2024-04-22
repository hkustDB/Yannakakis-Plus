create or replace view aggView2762818590778502010 as select name as v32, id as v31 from name as n;
create or replace view aggJoin2140533614820066122 as (
with aggView6989503115934930009 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView6989503115934930009 where t.kind_id=aggView6989503115934930009.v26 and production_year>2000);
create or replace view aggJoin2741792925573552185 as (
with aggView2206264476468913690 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView2206264476468913690 where mk.keyword_id=aggView2206264476468913690.v23);
create or replace view aggJoin5662053936200583743 as (
with aggView3657860177626778905 as (select v40 from aggJoin2741792925573552185 group by v40)
select v40, v41, v44 from aggJoin2140533614820066122 join aggView3657860177626778905 using(v40));
create or replace view aggView8330331485032685438 as select v40, v41 from aggJoin5662053936200583743 group by v40,v41;
create or replace view aggJoin3910475185853678473 as (
with aggView6677777737367095642 as (select v31, MIN(v32) as v52 from aggView2762818590778502010 group by v31)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView6677777737367095642 where ci.person_id=aggView6677777737367095642.v31);
create or replace view aggJoin7246639132162289621 as (
with aggView6682968527100780720 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin3910475185853678473 join aggView6682968527100780720 using(v9));
create or replace view aggJoin8307799209525627314 as (
with aggView8708032133234030036 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView8708032133234030036 where cc.status_id=aggView8708032133234030036.v7);
create or replace view aggJoin3805546428005317764 as (
with aggView1382401532818236368 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin8307799209525627314 join aggView1382401532818236368 using(v5));
create or replace view aggJoin5364096129036512132 as (
with aggView357996799574768762 as (select v40 from aggJoin3805546428005317764 group by v40)
select v40, v52 as v52 from aggJoin7246639132162289621 join aggView357996799574768762 using(v40));
create or replace view aggJoin2169210517219379177 as (
with aggView5835701498358557709 as (select v40, MIN(v52) as v52 from aggJoin5364096129036512132 group by v40,v52)
select v41, v52 from aggView8330331485032685438 join aggView5835701498358557709 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin2169210517219379177;
