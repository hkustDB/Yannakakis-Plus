create or replace view aggView6150887968152157552 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2945339116096153144 as (
with aggView8723590841097242373 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView8723590841097242373 where t.kind_id=aggView8723590841097242373.v25 and production_year>2005);
create or replace view aggView1262501725474812558 as select v45, v46 from aggJoin2945339116096153144 group by v45,v46;
create or replace view aggJoin4857148417661506195 as (
with aggView320399767322249898 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView320399767322249898 where mi_idx.info_type_id=aggView320399767322249898.v20 and info<'8.5');
create or replace view aggView8753509899852805070 as select v45, v40 from aggJoin4857148417661506195 group by v45,v40;
create or replace view aggJoin2451621623666262190 as (
with aggView8729517726190492381 as (select v45, MIN(v46) as v59 from aggView1262501725474812558 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v59 from movie_companies as mc, aggView8729517726190492381 where mc.movie_id=aggView8729517726190492381.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1305313570011395560 as (
with aggView3038739794244169107 as (select v45, MIN(v40) as v58 from aggView8753509899852805070 group by v45)
select v45, v9, v16, v31, v59 as v59, v58 from aggJoin2451621623666262190 join aggView3038739794244169107 using(v45));
create or replace view aggJoin5748176233366829434 as (
with aggView5934838693507903821 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView5934838693507903821 where cc.subject_id=aggView5934838693507903821.v5);
create or replace view aggJoin5043747693822409213 as (
with aggView5122802821809369089 as (select id as v16 from company_type as ct)
select v45, v9, v31, v59, v58 from aggJoin1305313570011395560 join aggView5122802821809369089 using(v16));
create or replace view aggJoin8757998708543734683 as (
with aggView2014643018472814280 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin5748176233366829434 join aggView2014643018472814280 using(v7));
create or replace view aggJoin6741996290941950749 as (
with aggView2443313014156870883 as (select v45 from aggJoin8757998708543734683 group by v45)
select v45, v9, v31, v59 as v59, v58 as v58 from aggJoin5043747693822409213 join aggView2443313014156870883 using(v45));
create or replace view aggJoin1586298974587725919 as (
with aggView4888399883025921327 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView4888399883025921327 where mk.keyword_id=aggView4888399883025921327.v22);
create or replace view aggJoin9113831057290297372 as (
with aggView1923118745052129019 as (select v45 from aggJoin1586298974587725919 group by v45)
select v45, v9, v31, v59 as v59, v58 as v58 from aggJoin6741996290941950749 join aggView1923118745052129019 using(v45));
create or replace view aggJoin4400517887712834729 as (
with aggView590940764169690949 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView590940764169690949 where mi.info_type_id=aggView590940764169690949.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin5888500301316295831 as (
with aggView6132332780105875345 as (select v45 from aggJoin4400517887712834729 group by v45)
select v9, v31, v59 as v59, v58 as v58 from aggJoin9113831057290297372 join aggView6132332780105875345 using(v45));
create or replace view aggJoin1638188722170700834 as (
with aggView29399728141282432 as (select v9, MIN(v59) as v59, MIN(v58) as v58 from aggJoin5888500301316295831 group by v9)
select v10, v59, v58 from aggView6150887968152157552 join aggView29399728141282432 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1638188722170700834;
