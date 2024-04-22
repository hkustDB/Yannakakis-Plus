create or replace view aggJoin5161636579289204772 as (
with aggView4256010741831754447 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4256010741831754447 where mc.company_id=aggView4256010741831754447.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4076374737081656321 as (
with aggView1003183939963918868 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1003183939963918868 where mi_idx.info_type_id=aggView1003183939963918868.v20 and info>'6.5');
create or replace view aggJoin1463641893545454622 as (
with aggView2915499474093429172 as (select v45, MIN(v40) as v58 from aggJoin4076374737081656321 group by v45)
select movie_id as v45, subject_id as v5, status_id as v7, v58 from complete_cast as cc, aggView2915499474093429172 where cc.movie_id=aggView2915499474093429172.v45);
create or replace view aggJoin7602760388002739350 as (
with aggView969562961187295309 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select v45, v5, v58 from aggJoin1463641893545454622 join aggView969562961187295309 using(v7));
create or replace view aggJoin5824683230173305026 as (
with aggView5841357078498065289 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin5161636579289204772 join aggView5841357078498065289 using(v16));
create or replace view aggJoin4671700340005416325 as (
with aggView1489558188172983284 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView1489558188172983284 where t.kind_id=aggView1489558188172983284.v25 and production_year>2005);
create or replace view aggJoin4602168265307409473 as (
with aggView4034894675583100597 as (select v45, MIN(v46) as v59 from aggJoin4671700340005416325 group by v45)
select v45, v31, v57 as v57, v59 from aggJoin5824683230173305026 join aggView4034894675583100597 using(v45));
create or replace view aggJoin4306386443289739243 as (
with aggView938540027225522604 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45, v58 from aggJoin7602760388002739350 join aggView938540027225522604 using(v5));
create or replace view aggJoin7445970481385044427 as (
with aggView6873160475955260284 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView6873160475955260284 where mi.info_type_id=aggView6873160475955260284.v18 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin6185937471585294033 as (
with aggView2193989793385115631 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView2193989793385115631 where mk.keyword_id=aggView2193989793385115631.v22);
create or replace view aggJoin3108606189732777453 as (
with aggView6771167630955811500 as (select v45 from aggJoin7445970481385044427 group by v45)
select v45, v31, v57 as v57, v59 as v59 from aggJoin4602168265307409473 join aggView6771167630955811500 using(v45));
create or replace view aggJoin2886397818443879464 as (
with aggView3567150372849451982 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin3108606189732777453 group by v45,v59,v57)
select v45, v58 as v58, v57, v59 from aggJoin4306386443289739243 join aggView3567150372849451982 using(v45));
create or replace view aggJoin6607213532217602870 as (
with aggView3558076886402564520 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v59) as v59 from aggJoin2886397818443879464 group by v45,v59,v58,v57)
select v58, v57, v59 from aggJoin6185937471585294033 join aggView3558076886402564520 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin6607213532217602870;
