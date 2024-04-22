create or replace view aggJoin9185550577375130825 as (
with aggView3886926825984953892 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView3886926825984953892 where mc.company_id=aggView3886926825984953892.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5516075055041402155 as (
with aggView1840195880709469151 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView1840195880709469151 where mk.keyword_id=aggView1840195880709469151.v22);
create or replace view aggJoin5117897308968164828 as (
with aggView2143938513369586372 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView2143938513369586372 where mi.info_type_id=aggView2143938513369586372.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8197977999259743301 as (
with aggView2041708379287793078 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView2041708379287793078 where cc.status_id=aggView2041708379287793078.v7);
create or replace view aggJoin9042828259917245632 as (
with aggView3223841926079865305 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin8197977999259743301 join aggView3223841926079865305 using(v5));
create or replace view aggJoin6334414649363039814 as (
with aggView8128212641889156083 as (select v45 from aggJoin9042828259917245632 group by v45)
select v45, v35 from aggJoin5117897308968164828 join aggView8128212641889156083 using(v45));
create or replace view aggJoin5826638616982855690 as (
with aggView1813102725864250295 as (select v45 from aggJoin6334414649363039814 group by v45)
select v45 from aggJoin5516075055041402155 join aggView1813102725864250295 using(v45));
create or replace view aggJoin2160094200482518937 as (
with aggView8916241017118219483 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin9185550577375130825 join aggView8916241017118219483 using(v16));
create or replace view aggJoin8612140491906257770 as (
with aggView2501641280945280005 as (select v45, MIN(v57) as v57 from aggJoin2160094200482518937 group by v45,v57)
select movie_id as v45, info_type_id as v20, info as v40, v57 from movie_info_idx as mi_idx, aggView2501641280945280005 where mi_idx.movie_id=aggView2501641280945280005.v45 and info<'8.5');
create or replace view aggJoin4902462598895426458 as (
with aggView5287345585174309251 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView5287345585174309251 where t.kind_id=aggView5287345585174309251.v25 and production_year>2000);
create or replace view aggJoin8248096821015510861 as (
with aggView5264821345582334694 as (select v45, MIN(v46) as v59 from aggJoin4902462598895426458 group by v45)
select v45, v20, v40, v57 as v57, v59 from aggJoin8612140491906257770 join aggView5264821345582334694 using(v45));
create or replace view aggJoin4548728149502226999 as (
with aggView8182713621799813955 as (select id as v20 from info_type as it2 where info= 'rating')
select v45, v40, v57, v59 from aggJoin8248096821015510861 join aggView8182713621799813955 using(v20));
create or replace view aggJoin8221163884157152340 as (
with aggView2283627756797517697 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v40) as v58 from aggJoin4548728149502226999 group by v45,v59,v57)
select v57, v59, v58 from aggJoin5826638616982855690 join aggView2283627756797517697 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin8221163884157152340;
