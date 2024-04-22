create or replace view aggJoin5905876521236145568 as (
with aggView7678733524310980847 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView7678733524310980847 where mc.company_id=aggView7678733524310980847.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin65708432097437806 as (
with aggView3837405396999574089 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView3837405396999574089 where mk.keyword_id=aggView3837405396999574089.v22);
create or replace view aggJoin4285375573576619428 as (
with aggView3947685826893573390 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView3947685826893573390 where mi.info_type_id=aggView3947685826893573390.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4194825339761212412 as (
with aggView8312606992291813417 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView8312606992291813417 where cc.status_id=aggView8312606992291813417.v7);
create or replace view aggJoin6858063845585056376 as (
with aggView8215853803801493320 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin4194825339761212412 join aggView8215853803801493320 using(v5));
create or replace view aggJoin7896162272867182886 as (
with aggView7888698479098897470 as (select v45 from aggJoin6858063845585056376 group by v45)
select v45, v35 from aggJoin4285375573576619428 join aggView7888698479098897470 using(v45));
create or replace view aggJoin1814341201486974087 as (
with aggView1311447825319107966 as (select v45 from aggJoin7896162272867182886 group by v45)
select movie_id as v45, info_type_id as v20, info as v40 from movie_info_idx as mi_idx, aggView1311447825319107966 where mi_idx.movie_id=aggView1311447825319107966.v45 and info<'8.5');
create or replace view aggJoin1086021149522073133 as (
with aggView1337663183701734828 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin5905876521236145568 join aggView1337663183701734828 using(v16));
create or replace view aggJoin2972937897100805169 as (
with aggView3434631015608550707 as (select v45, MIN(v57) as v57 from aggJoin1086021149522073133 group by v45,v57)
select v45, v57 from aggJoin65708432097437806 join aggView3434631015608550707 using(v45));
create or replace view aggJoin6508902445163255128 as (
with aggView2335261973339328427 as (select id as v20 from info_type as it2 where info= 'rating')
select v45, v40 from aggJoin1814341201486974087 join aggView2335261973339328427 using(v20));
create or replace view aggJoin9194060460208145972 as (
with aggView4343633377882932787 as (select v45, MIN(v40) as v58 from aggJoin6508902445163255128 group by v45)
select id as v45, title as v46, kind_id as v25, production_year as v49, v58 from title as t, aggView4343633377882932787 where t.id=aggView4343633377882932787.v45 and production_year>2000);
create or replace view aggJoin8944980560540365973 as (
with aggView1843642558970811246 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select v45, v46, v49, v58 from aggJoin9194060460208145972 join aggView1843642558970811246 using(v25));
create or replace view aggJoin6130981264840717275 as (
with aggView3797647878194598969 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin8944980560540365973 group by v45,v58)
select v57 as v57, v58, v59 from aggJoin2972937897100805169 join aggView3797647878194598969 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin6130981264840717275;
