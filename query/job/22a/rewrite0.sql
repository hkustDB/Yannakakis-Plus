create or replace view aggView153747948947568698 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin5148602897257137097 as (
with aggView2966383466699778462 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2966383466699778462 where mi_idx.info_type_id=aggView2966383466699778462.v12 and info<'7.0');
create or replace view aggJoin1267144170349009650 as (
with aggView424847923749314407 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView424847923749314407 where t.kind_id=aggView424847923749314407.v17 and production_year>2008);
create or replace view aggView6053779100794432382 as select v38, v37 from aggJoin1267144170349009650 group by v38,v37;
create or replace view aggJoin3021851908764763456 as (
with aggView463903924112463892 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView463903924112463892 where mi.info_type_id=aggView463903924112463892.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin1746803340354498776 as (
with aggView251461982960187631 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView251461982960187631 where mk.keyword_id=aggView251461982960187631.v14);
create or replace view aggJoin6702967072783104820 as (
with aggView8400457748285587413 as (select v37 from aggJoin1746803340354498776 group by v37)
select v37, v27 from aggJoin3021851908764763456 join aggView8400457748285587413 using(v37));
create or replace view aggJoin1637382405899036541 as (
with aggView762800989236572399 as (select v37 from aggJoin6702967072783104820 group by v37)
select v37, v32 from aggJoin5148602897257137097 join aggView762800989236572399 using(v37));
create or replace view aggView9149352416275499954 as select v32, v37 from aggJoin1637382405899036541 group by v32,v37;
create or replace view aggJoin5914370949311252250 as (
with aggView2863550787748040480 as (select v37, MIN(v32) as v50 from aggView9149352416275499954 group by v37)
select v38, v37, v50 from aggView6053779100794432382 join aggView2863550787748040480 using(v37));
create or replace view aggJoin4455366642653606188 as (
with aggView8555544217537295351 as (select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin5914370949311252250 group by v37,v50)
select company_id as v1, company_type_id as v8, note as v23, v50, v51 from movie_companies as mc, aggView8555544217537295351 where mc.movie_id=aggView8555544217537295351.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3176205223985389785 as (
with aggView1902905777064523904 as (select id as v8 from company_type as ct)
select v1, v23, v50, v51 from aggJoin4455366642653606188 join aggView1902905777064523904 using(v8));
create or replace view aggJoin4522920510195162542 as (
with aggView4911947716272594608 as (select v1, MIN(v50) as v50, MIN(v51) as v51 from aggJoin3176205223985389785 group by v1,v50,v51)
select v2, v50, v51 from aggView153747948947568698 join aggView4911947716272594608 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4522920510195162542;
