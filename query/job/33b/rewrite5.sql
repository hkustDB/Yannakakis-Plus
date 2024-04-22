create or replace view aggView8571905492108163975 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggView1355711557971803638 as select id as v1, name as v2 from company_name as cn1 where country_code= '[nl]';
create or replace view aggJoin6206376451674041946 as (
with aggView8231082392615132560 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8231082392615132560 where mi_idx1.info_type_id=aggView8231082392615132560.v15);
create or replace view aggView5040066872397430449 as select v49, v38 from aggJoin6206376451674041946 group by v49,v38;
create or replace view aggJoin8790021758517076335 as (
with aggView7490718058359007039 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7490718058359007039 where mi_idx2.info_type_id=aggView7490718058359007039.v17 and info<'3.0');
create or replace view aggView7163363279725076014 as select v61, v43 from aggJoin8790021758517076335 group by v61,v43;
create or replace view aggJoin7532982446407451294 as (
with aggView7976579328612891437 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView7976579328612891437 where t1.kind_id=aggView7976579328612891437.v19);
create or replace view aggView1859126217312082009 as select v50, v49 from aggJoin7532982446407451294 group by v50,v49;
create or replace view aggJoin7267858439997683153 as (
with aggView3685978126235180534 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView3685978126235180534 where t2.kind_id=aggView3685978126235180534.v21 and production_year= 2007);
create or replace view aggView2196958467630913158 as select v62, v61 from aggJoin7267858439997683153 group by v62,v61;
create or replace view aggJoin7010284512483190483 as (
with aggView4614716738206061738 as (select v49, MIN(v50) as v77 from aggView1859126217312082009 group by v49)
select v49, v38, v77 from aggView5040066872397430449 join aggView4614716738206061738 using(v49));
create or replace view aggJoin1527079724573469325 as (
with aggView5174879276848835781 as (select v8, MIN(v9) as v74 from aggView8571905492108163975 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView5174879276848835781 where mc2.company_id=aggView5174879276848835781.v8);
create or replace view aggJoin3828224153080018027 as (
with aggView2070992853957858784 as (select v1, MIN(v2) as v73 from aggView1355711557971803638 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView2070992853957858784 where mc1.company_id=aggView2070992853957858784.v1);
create or replace view aggJoin384557442724558976 as (
with aggView1482362355885136635 as (select v49, MIN(v77) as v77, MIN(v38) as v75 from aggJoin7010284512483190483 group by v49,v77)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v77, v75 from movie_link as ml, aggView1482362355885136635 where ml.movie_id=aggView1482362355885136635.v49);
create or replace view aggJoin8591292823878457020 as (
with aggView8484155608532156290 as (select v61, MIN(v74) as v74 from aggJoin1527079724573469325 group by v61,v74)
select v61, v43, v74 from aggView7163363279725076014 join aggView8484155608532156290 using(v61));
create or replace view aggJoin8118694770899397708 as (
with aggView7291873779924813201 as (select v49, MIN(v73) as v73 from aggJoin3828224153080018027 group by v49,v73)
select v61, v23, v77 as v77, v75 as v75, v73 from aggJoin384557442724558976 join aggView7291873779924813201 using(v49));
create or replace view aggJoin5716495591759123255 as (
with aggView9134812778939886170 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v61, v77, v75, v73 from aggJoin8118694770899397708 join aggView9134812778939886170 using(v23));
create or replace view aggJoin3939124462474586048 as (
with aggView3866568173747084456 as (select v61, MIN(v77) as v77, MIN(v75) as v75, MIN(v73) as v73 from aggJoin5716495591759123255 group by v61,v73,v75,v77)
select v62, v61, v77, v75, v73 from aggView2196958467630913158 join aggView3866568173747084456 using(v61));
create or replace view aggJoin7838649038452571164 as (
with aggView3798787640388396983 as (select v61, MIN(v77) as v77, MIN(v75) as v75, MIN(v73) as v73, MIN(v62) as v78 from aggJoin3939124462474586048 group by v61,v73,v75,v77)
select v43, v74 as v74, v77, v75, v73, v78 from aggJoin8591292823878457020 join aggView3798787640388396983 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v43) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin7838649038452571164;
