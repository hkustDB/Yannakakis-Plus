create or replace view aggView1876984968918558417 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin726293594194073465 as (
with aggView8846178811844432951 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView8846178811844432951 where mi_idx.info_type_id=aggView8846178811844432951.v20);
create or replace view aggJoin3364087581241472193 as (
with aggView8674837011347307641 as (select v45, v40 from aggJoin726293594194073465 group by v45,v40)
select v45, v40 from aggView8674837011347307641 where v40>'6.5');
create or replace view aggJoin7880673690874438747 as (
with aggView7737654119365280412 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7737654119365280412 where t.kind_id=aggView7737654119365280412.v25 and production_year>2005);
create or replace view aggView3675582424181427855 as select v46, v45 from aggJoin7880673690874438747 group by v46,v45;
create or replace view aggJoin2309409082013968443 as (
with aggView4360734827079751458 as (select v9, MIN(v10) as v57 from aggView1876984968918558417 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4360734827079751458 where mc.company_id=aggView4360734827079751458.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1729227207181225689 as (
with aggView3306376328536814503 as (select v45, MIN(v46) as v59 from aggView3675582424181427855 group by v45)
select v45, v16, v31, v57 as v57, v59 from aggJoin2309409082013968443 join aggView3306376328536814503 using(v45));
create or replace view aggJoin7139247207690609638 as (
with aggView5239395493217714149 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5239395493217714149 where cc.status_id=aggView5239395493217714149.v7);
create or replace view aggJoin3623437421501774619 as (
with aggView3891508050182192224 as (select id as v16 from company_type as ct)
select v45, v31, v57, v59 from aggJoin1729227207181225689 join aggView3891508050182192224 using(v16));
create or replace view aggJoin7369791586439058284 as (
with aggView4223186403804768391 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin7139247207690609638 join aggView4223186403804768391 using(v5));
create or replace view aggJoin6310095603985735190 as (
with aggView6516754521223429208 as (select v45 from aggJoin7369791586439058284 group by v45)
select v45, v31, v57 as v57, v59 as v59 from aggJoin3623437421501774619 join aggView6516754521223429208 using(v45));
create or replace view aggJoin2716862271243626526 as (
with aggView2712590558197366100 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView2712590558197366100 where mk.keyword_id=aggView2712590558197366100.v22);
create or replace view aggJoin2161605457955467322 as (
with aggView2446849660954518805 as (select v45 from aggJoin2716862271243626526 group by v45)
select v45, v31, v57 as v57, v59 as v59 from aggJoin6310095603985735190 join aggView2446849660954518805 using(v45));
create or replace view aggJoin168338407452481878 as (
with aggView2665629596212658695 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView2665629596212658695 where mi.info_type_id=aggView2665629596212658695.v18 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin7493654883151663176 as (
with aggView34382566207614747 as (select v45 from aggJoin168338407452481878 group by v45)
select v45, v31, v57 as v57, v59 as v59 from aggJoin2161605457955467322 join aggView34382566207614747 using(v45));
create or replace view aggJoin7734396681733320746 as (
with aggView3284965511980238664 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin7493654883151663176 group by v45,v59,v57)
select v40, v57, v59 from aggJoin3364087581241472193 join aggView3284965511980238664 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin7734396681733320746;
