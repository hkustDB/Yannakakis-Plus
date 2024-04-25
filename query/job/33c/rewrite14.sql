create or replace view aggView2600781272067836221 as select id as v1, name as v2 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView3257116062288737542 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggJoin6304193990288649219 as (
with aggView2420646266535339611 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2420646266535339611 where mi_idx1.info_type_id=aggView2420646266535339611.v15);
create or replace view aggView6970538997553549290 as select v49, v38 from aggJoin6304193990288649219 group by v49,v38;
create or replace view aggJoin5212629112093118957 as (
with aggView9170043447216164862 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView9170043447216164862 where t2.kind_id=aggView9170043447216164862.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView8819159710557524134 as select v62, v61 from aggJoin5212629112093118957 group by v62,v61;
create or replace view aggJoin8424214890427456049 as (
with aggView5867983012603522192 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView5867983012603522192 where t1.kind_id=aggView5867983012603522192.v19);
create or replace view aggView8051095680901649052 as select v50, v49 from aggJoin8424214890427456049 group by v50,v49;
create or replace view aggJoin5950905952667227066 as (
with aggView7569396732903944705 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7569396732903944705 where mi_idx2.info_type_id=aggView7569396732903944705.v17);
create or replace view aggJoin8345806800391672949 as (
with aggView8486549369124052191 as (select v61, v43 from aggJoin5950905952667227066 group by v61,v43)
select v61, v43 from aggView8486549369124052191 where v43<'3.5');
create or replace view aggJoin7784373517681189601 as (
with aggView6321493950677239741 as (select v61, MIN(v62) as v78 from aggView8819159710557524134 group by v61)
select movie_id as v61, company_id as v8, v78 from movie_companies as mc2, aggView6321493950677239741 where mc2.movie_id=aggView6321493950677239741.v61);
create or replace view aggJoin7715475005223799615 as (
with aggView7840221532132122506 as (select v8, MIN(v9) as v74 from aggView3257116062288737542 group by v8)
select v61, v78 as v78, v74 from aggJoin7784373517681189601 join aggView7840221532132122506 using(v8));
create or replace view aggJoin6440173574559912553 as (
with aggView1847897343488623854 as (select v1, MIN(v2) as v73 from aggView2600781272067836221 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView1847897343488623854 where mc1.company_id=aggView1847897343488623854.v1);
create or replace view aggJoin5943042462930660913 as (
with aggView8853608756426202410 as (select v61, MIN(v43) as v76 from aggJoin8345806800391672949 group by v61)
select v61, v78 as v78, v74 as v74, v76 from aggJoin7715475005223799615 join aggView8853608756426202410 using(v61));
create or replace view aggJoin7853113327564654106 as (
with aggView6465292398418879481 as (select v49, MIN(v38) as v75 from aggView6970538997553549290 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v75 from movie_link as ml, aggView6465292398418879481 where ml.movie_id=aggView6465292398418879481.v49);
create or replace view aggJoin677492998349023408 as (
with aggView2542047351757161625 as (select v49, MIN(v73) as v73 from aggJoin6440173574559912553 group by v49)
select v49, v61, v23, v75 as v75, v73 from aggJoin7853113327564654106 join aggView2542047351757161625 using(v49));
create or replace view aggJoin1149141679411654882 as (
with aggView4824796634486607099 as (select v61, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76 from aggJoin5943042462930660913 group by v61)
select v49, v23, v75 as v75, v73 as v73, v78, v74, v76 from aggJoin677492998349023408 join aggView4824796634486607099 using(v61));
create or replace view aggJoin2421712437261149283 as (
with aggView6565497902447188503 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v75, v73, v78, v74, v76 from aggJoin1149141679411654882 join aggView6565497902447188503 using(v23));
create or replace view aggJoin3856156329770746989 as (
with aggView7358890776474834348 as (select v49, MIN(v75) as v75, MIN(v73) as v73, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76 from aggJoin2421712437261149283 group by v49)
select v50, v75, v73, v78, v74, v76 from aggView8051095680901649052 join aggView7358890776474834348 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v50) as v77,MIN(v78) as v78 from aggJoin3856156329770746989;
