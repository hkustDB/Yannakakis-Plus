create or replace view aggJoin3407427086656399719 as (
with aggView2591129745312501136 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView2591129745312501136 where mc.company_id=aggView2591129745312501136.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4697359064724810061 as (
with aggView1345448111956322075 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView1345448111956322075 where t.kind_id=aggView1345448111956322075.v25 and production_year>2005);
create or replace view aggJoin40829359585976394 as (
with aggView8819488543677495043 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView8819488543677495043 where mi_idx.info_type_id=aggView8819488543677495043.v20 and info<'8.5');
create or replace view aggJoin5484978589587145861 as (
with aggView3370344198564242011 as (select v45, MIN(v40) as v58 from aggJoin40829359585976394 group by v45)
select v45, v46, v49, v58 from aggJoin4697359064724810061 join aggView3370344198564242011 using(v45));
create or replace view aggJoin2078369663438298615 as (
with aggView1798817593913002044 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView1798817593913002044 where cc.subject_id=aggView1798817593913002044.v5);
create or replace view aggJoin2293357455131478930 as (
with aggView8903502860545715210 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin3407427086656399719 join aggView8903502860545715210 using(v16));
create or replace view aggJoin5738620664426842506 as (
with aggView5155433271887896295 as (select v45, MIN(v57) as v57 from aggJoin2293357455131478930 group by v45)
select v45, v46, v49, v58 as v58, v57 from aggJoin5484978589587145861 join aggView5155433271887896295 using(v45));
create or replace view aggJoin4953292534152806979 as (
with aggView4680300184267960125 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin2078369663438298615 join aggView4680300184267960125 using(v7));
create or replace view aggJoin4964525018064014432 as (
with aggView6922434702602755751 as (select v45 from aggJoin4953292534152806979 group by v45)
select v45, v46, v49, v58 as v58, v57 as v57 from aggJoin5738620664426842506 join aggView6922434702602755751 using(v45));
create or replace view aggJoin5201637961404102062 as (
with aggView3764676557621039352 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v46) as v59 from aggJoin4964525018064014432 group by v45)
select movie_id as v45, keyword_id as v22, v58, v57, v59 from movie_keyword as mk, aggView3764676557621039352 where mk.movie_id=aggView3764676557621039352.v45);
create or replace view aggJoin654426166142830639 as (
with aggView8453357152826946483 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v45, v58, v57, v59 from aggJoin5201637961404102062 join aggView8453357152826946483 using(v22));
create or replace view aggJoin6956949451153512556 as (
with aggView2519225272895082564 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView2519225272895082564 where mi.info_type_id=aggView2519225272895082564.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4930455338842625786 as (
with aggView5669991243168236108 as (select v45 from aggJoin6956949451153512556 group by v45)
select v58 as v58, v57 as v57, v59 as v59 from aggJoin654426166142830639 join aggView5669991243168236108 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin4930455338842625786;
