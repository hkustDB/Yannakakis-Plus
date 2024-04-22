create or replace view aggJoin1289745432323721529 as (
with aggView6134315179231881184 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView6134315179231881184 where mc.company_id=aggView6134315179231881184.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4223044419578389719 as (
with aggView7210769305438239297 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView7210769305438239297 where mk.keyword_id=aggView7210769305438239297.v22);
create or replace view aggJoin3772368456587901378 as (
with aggView1561073343230841586 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView1561073343230841586 where mi.info_type_id=aggView1561073343230841586.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4393097801030367282 as (
with aggView6771331761092432620 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView6771331761092432620 where cc.status_id=aggView6771331761092432620.v7);
create or replace view aggJoin6544287114770450657 as (
with aggView3079543039844044414 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin4393097801030367282 join aggView3079543039844044414 using(v5));
create or replace view aggJoin6574043115391045897 as (
with aggView6039212989052110799 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin1289745432323721529 join aggView6039212989052110799 using(v16));
create or replace view aggJoin6619301795532027984 as (
with aggView3314344647489670783 as (select v45, MIN(v57) as v57 from aggJoin6574043115391045897 group by v45,v57)
select v45, v57 from aggJoin4223044419578389719 join aggView3314344647489670783 using(v45));
create or replace view aggJoin8447550776527478448 as (
with aggView7108694221969504998 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7108694221969504998 where mi_idx.info_type_id=aggView7108694221969504998.v20 and info<'8.5');
create or replace view aggJoin4998589033933955765 as (
with aggView4433126290685535851 as (select v45, MIN(v40) as v58 from aggJoin8447550776527478448 group by v45)
select v45, v58 from aggJoin6544287114770450657 join aggView4433126290685535851 using(v45));
create or replace view aggJoin6041435530585913736 as (
with aggView5456949554392306076 as (select v45, MIN(v58) as v58 from aggJoin4998589033933955765 group by v45,v58)
select v45, v35, v58 from aggJoin3772368456587901378 join aggView5456949554392306076 using(v45));
create or replace view aggJoin5150795804836440360 as (
with aggView7834979477717199174 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7834979477717199174 where t.kind_id=aggView7834979477717199174.v25 and production_year>2000);
create or replace view aggJoin3852437397632588497 as (
with aggView2830743094281891420 as (select v45, MIN(v46) as v59 from aggJoin5150795804836440360 group by v45)
select v45, v35, v58 as v58, v59 from aggJoin6041435530585913736 join aggView2830743094281891420 using(v45));
create or replace view aggJoin1331732150033074225 as (
with aggView5712689690517959786 as (select v45, MIN(v58) as v58, MIN(v59) as v59 from aggJoin3852437397632588497 group by v45,v58,v59)
select v57 as v57, v58, v59 from aggJoin6619301795532027984 join aggView5712689690517959786 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1331732150033074225;
