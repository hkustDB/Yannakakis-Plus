create or replace view aggView6765716372504041689 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin5641890170274756666 as (
with aggView1769372076403890577 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1769372076403890577 where mi_idx.info_type_id=aggView1769372076403890577.v20 and info>'6.5');
create or replace view aggJoin7437298597219495127 as (
with aggView1589469529958508933 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView1589469529958508933 where cc.status_id=aggView1589469529958508933.v7);
create or replace view aggJoin4262740908957121996 as (
with aggView439042600947372964 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView439042600947372964 where t.kind_id=aggView439042600947372964.v25 and production_year>2005);
create or replace view aggJoin6216159916903055140 as (
with aggView5335404064846502659 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin7437298597219495127 join aggView5335404064846502659 using(v5));
create or replace view aggJoin8201212280533916555 as (
with aggView3005763164409547745 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView3005763164409547745 where mk.keyword_id=aggView3005763164409547745.v22);
create or replace view aggJoin4379184764303002818 as (
with aggView2841640336741581088 as (select v45 from aggJoin8201212280533916555 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView2841640336741581088 where mi.movie_id=aggView2841640336741581088.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin1107267500478538025 as (
with aggView5313689603378753549 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin4379184764303002818 join aggView5313689603378753549 using(v18));
create or replace view aggJoin6121810334032129171 as (
with aggView785552090075158298 as (select v45 from aggJoin6216159916903055140 group by v45)
select v45, v40 from aggJoin5641890170274756666 join aggView785552090075158298 using(v45));
create or replace view aggView2584317964637947209 as select v45, v40 from aggJoin6121810334032129171 group by v45,v40;
create or replace view aggJoin602151307702659282 as (
with aggView1422036167926068698 as (select v45 from aggJoin1107267500478538025 group by v45)
select v45, v46, v49 from aggJoin4262740908957121996 join aggView1422036167926068698 using(v45));
create or replace view aggView6453629631897746969 as select v46, v45 from aggJoin602151307702659282 group by v46,v45;
create or replace view aggJoin4327958703775640210 as (
with aggView5205975091093800679 as (select v45, MIN(v46) as v59 from aggView6453629631897746969 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v59 from movie_companies as mc, aggView5205975091093800679 where mc.movie_id=aggView5205975091093800679.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6147768645352197794 as (
with aggView9197375018387815633 as (select v45, MIN(v40) as v58 from aggView2584317964637947209 group by v45)
select v9, v16, v31, v59 as v59, v58 from aggJoin4327958703775640210 join aggView9197375018387815633 using(v45));
create or replace view aggJoin7363438932749567513 as (
with aggView1991494482817049160 as (select id as v16 from company_type as ct)
select v9, v31, v59, v58 from aggJoin6147768645352197794 join aggView1991494482817049160 using(v16));
create or replace view aggJoin3116769332254306108 as (
with aggView2299018994672152587 as (select v9, MIN(v59) as v59, MIN(v58) as v58 from aggJoin7363438932749567513 group by v9,v59,v58)
select v10, v59, v58 from aggView6765716372504041689 join aggView2299018994672152587 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin3116769332254306108;
