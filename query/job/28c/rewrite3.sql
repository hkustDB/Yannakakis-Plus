create or replace view aggView8430388510356583152 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7569321015927338008 as (
with aggView7536517097002450165 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7536517097002450165 where t.kind_id=aggView7536517097002450165.v25 and production_year>2005);
create or replace view aggView1313438289078848255 as select v45, v46 from aggJoin7569321015927338008 group by v45,v46;
create or replace view aggJoin6148104464892322367 as (
with aggView8859899725664882694 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView8859899725664882694 where mi_idx.info_type_id=aggView8859899725664882694.v20 and info<'8.5');
create or replace view aggJoin5972271160850456098 as (
with aggView9025745861422752335 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView9025745861422752335 where mk.keyword_id=aggView9025745861422752335.v22);
create or replace view aggJoin2836223607731626409 as (
with aggView7481152271208377124 as (select v45 from aggJoin5972271160850456098 group by v45)
select v45, v40 from aggJoin6148104464892322367 join aggView7481152271208377124 using(v45));
create or replace view aggView4312724900645669225 as select v45, v40 from aggJoin2836223607731626409 group by v45,v40;
create or replace view aggJoin1709195145906607147 as (
with aggView6170995780151836448 as (select v9, MIN(v10) as v57 from aggView8430388510356583152 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView6170995780151836448 where mc.company_id=aggView6170995780151836448.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8222368711597887262 as (
with aggView3160552594661301014 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView3160552594661301014 where cc.subject_id=aggView3160552594661301014.v5);
create or replace view aggJoin5244338273691153040 as (
with aggView3272252623138379008 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin1709195145906607147 join aggView3272252623138379008 using(v16));
create or replace view aggJoin9083548898060094967 as (
with aggView9199186321117898899 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin8222368711597887262 join aggView9199186321117898899 using(v7));
create or replace view aggJoin2890668320101276807 as (
with aggView2101530057147037218 as (select v45 from aggJoin9083548898060094967 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView2101530057147037218 where mi.movie_id=aggView2101530057147037218.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin810048057586441374 as (
with aggView3558925986650177928 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin2890668320101276807 join aggView3558925986650177928 using(v18));
create or replace view aggJoin7757638517581361424 as (
with aggView5883472125206593844 as (select v45 from aggJoin810048057586441374 group by v45)
select v45, v31, v57 as v57 from aggJoin5244338273691153040 join aggView5883472125206593844 using(v45));
create or replace view aggJoin8335614126235484766 as (
with aggView940629262017944415 as (select v45, MIN(v57) as v57 from aggJoin7757638517581361424 group by v45)
select v45, v40, v57 from aggView4312724900645669225 join aggView940629262017944415 using(v45));
create or replace view aggJoin4981637359919818604 as (
with aggView1389436591979538224 as (select v45, MIN(v57) as v57, MIN(v40) as v58 from aggJoin8335614126235484766 group by v45)
select v46, v57, v58 from aggView1313438289078848255 join aggView1389436591979538224 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin4981637359919818604;
