create or replace view aggJoin7832185735837874308 as (
with aggView7271269256079810617 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView7271269256079810617 where mc.company_id=aggView7271269256079810617.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8206371239325648613 as (
with aggView3553997652249242547 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView3553997652249242547 where t.kind_id=aggView3553997652249242547.v25 and production_year>2005);
create or replace view aggJoin8430963293398174821 as (
with aggView4746970530881869005 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView4746970530881869005 where cc.subject_id=aggView4746970530881869005.v5);
create or replace view aggJoin895724639094260699 as (
with aggView2377175224999064998 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin7832185735837874308 join aggView2377175224999064998 using(v16));
create or replace view aggJoin8476384530578723360 as (
with aggView8705734763422954852 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView8705734763422954852 where mi_idx.info_type_id=aggView8705734763422954852.v20 and info<'8.5');
create or replace view aggJoin8931367274105204397 as (
with aggView2569393185032001855 as (select v45, MIN(v40) as v58 from aggJoin8476384530578723360 group by v45)
select movie_id as v45, info_type_id as v18, info as v35, v58 from movie_info as mi, aggView2569393185032001855 where mi.movie_id=aggView2569393185032001855.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4825600668903527320 as (
with aggView7449612586345917727 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin8430963293398174821 join aggView7449612586345917727 using(v7));
create or replace view aggJoin2060922858572124767 as (
with aggView6388767719757173659 as (select v45, MIN(v57) as v57 from aggJoin895724639094260699 group by v45,v57)
select v45, v46, v49, v57 from aggJoin8206371239325648613 join aggView6388767719757173659 using(v45));
create or replace view aggJoin7238670668151937576 as (
with aggView8094103814121231976 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView8094103814121231976 where mk.keyword_id=aggView8094103814121231976.v22);
create or replace view aggJoin1330449931543344613 as (
with aggView8590641957171422605 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v58 from aggJoin8931367274105204397 join aggView8590641957171422605 using(v18));
create or replace view aggJoin2218189101922520879 as (
with aggView7458729562733593308 as (select v45, MIN(v58) as v58 from aggJoin1330449931543344613 group by v45,v58)
select v45, v46, v49, v57 as v57, v58 from aggJoin2060922858572124767 join aggView7458729562733593308 using(v45));
create or replace view aggJoin6622423039650955494 as (
with aggView2054268615934202113 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v46) as v59 from aggJoin2218189101922520879 group by v45,v57,v58)
select v45, v57, v58, v59 from aggJoin4825600668903527320 join aggView2054268615934202113 using(v45));
create or replace view aggJoin5107474502808298079 as (
with aggView8953804007852158704 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59 from aggJoin6622423039650955494 group by v45,v57,v58,v59)
select v57, v58, v59 from aggJoin7238670668151937576 join aggView8953804007852158704 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin5107474502808298079;
