create or replace view aggView4137415398900023412 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2414397372788554919 as (
with aggView8936245091380323941 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView8936245091380323941 where mi_idx.info_type_id=aggView8936245091380323941.v20 and info>'6.5');
create or replace view aggJoin7199703885135371927 as (
with aggView1197353023020793231 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView1197353023020793231 where cc.status_id=aggView1197353023020793231.v7);
create or replace view aggJoin8647552276332746669 as (
with aggView401490677675776746 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView401490677675776746 where t.kind_id=aggView401490677675776746.v25 and production_year>2005);
create or replace view aggView7894406221009032195 as select v46, v45 from aggJoin8647552276332746669 group by v46,v45;
create or replace view aggJoin1676675048525388126 as (
with aggView4450334786440239210 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin7199703885135371927 join aggView4450334786440239210 using(v5));
create or replace view aggJoin5606648726419872574 as (
with aggView761085990532344417 as (select v45 from aggJoin1676675048525388126 group by v45)
select v45, v40 from aggJoin2414397372788554919 join aggView761085990532344417 using(v45));
create or replace view aggView5180497387060631685 as select v45, v40 from aggJoin5606648726419872574 group by v45,v40;
create or replace view aggJoin7850519540967585216 as (
with aggView3657594250347254909 as (select v9, MIN(v10) as v57 from aggView4137415398900023412 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView3657594250347254909 where mc.company_id=aggView3657594250347254909.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5766263206814945632 as (
with aggView1511224707695630165 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin7850519540967585216 join aggView1511224707695630165 using(v16));
create or replace view aggJoin6840222592218261325 as (
with aggView7495853357510050573 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView7495853357510050573 where mk.keyword_id=aggView7495853357510050573.v22);
create or replace view aggJoin1785838615685184148 as (
with aggView3750222457653614620 as (select v45 from aggJoin6840222592218261325 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView3750222457653614620 where mi.movie_id=aggView3750222457653614620.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin75540017483924268 as (
with aggView725536160596854716 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin1785838615685184148 join aggView725536160596854716 using(v18));
create or replace view aggJoin857668735659979864 as (
with aggView4465862453295296957 as (select v45 from aggJoin75540017483924268 group by v45)
select v45, v31, v57 as v57 from aggJoin5766263206814945632 join aggView4465862453295296957 using(v45));
create or replace view aggJoin2713516689124510549 as (
with aggView3022663915481891014 as (select v45, MIN(v57) as v57 from aggJoin857668735659979864 group by v45,v57)
select v46, v45, v57 from aggView7894406221009032195 join aggView3022663915481891014 using(v45));
create or replace view aggJoin3989841090717147257 as (
with aggView1467886003366271760 as (select v45, MIN(v57) as v57, MIN(v46) as v59 from aggJoin2713516689124510549 group by v45,v57)
select v40, v57, v59 from aggView5180497387060631685 join aggView1467886003366271760 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin3989841090717147257;
