create or replace view aggView5579070201513237294 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggView434208026722433970 as select id as v1, name as v2 from company_name as cn1 where country_code= '[us]';
create or replace view aggJoin8020683249215502496 as (
with aggView4784990417079462289 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView4784990417079462289 where t2.kind_id=aggView4784990417079462289.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggView3763922145858285602 as select v61, v62 from aggJoin8020683249215502496 group by v61,v62;
create or replace view aggJoin5006244388805020780 as (
with aggView7002592913229442086 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView7002592913229442086 where t1.kind_id=aggView7002592913229442086.v19);
create or replace view aggView5120568255843462457 as select v49, v50 from aggJoin5006244388805020780 group by v49,v50;
create or replace view aggJoin4348506221864932797 as (
with aggView3655835543508299010 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView3655835543508299010 where mi_idx2.info_type_id=aggView3655835543508299010.v17 and info<'3.0');
create or replace view aggView429801614621913416 as select v61, v43 from aggJoin4348506221864932797 group by v61,v43;
create or replace view aggJoin9158139295914747754 as (
with aggView5045400135081098571 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView5045400135081098571 where mi_idx1.info_type_id=aggView5045400135081098571.v15);
create or replace view aggView4299329460433427136 as select v49, v38 from aggJoin9158139295914747754 group by v49,v38;
create or replace view aggJoin3404231849804648932 as (
with aggView48920880135166347 as (select v49, MIN(v50) as v77 from aggView5120568255843462457 group by v49)
select v49, v38, v77 from aggView4299329460433427136 join aggView48920880135166347 using(v49));
create or replace view aggJoin7987196901516666228 as (
with aggView4235181702933132128 as (select v61, MIN(v62) as v78 from aggView3763922145858285602 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v78 from movie_link as ml, aggView4235181702933132128 where ml.linked_movie_id=aggView4235181702933132128.v61);
create or replace view aggJoin44201275952412698 as (
with aggView8076130172808768535 as (select v49, MIN(v77) as v77, MIN(v38) as v75 from aggJoin3404231849804648932 group by v49,v77)
select v49, v61, v23, v78 as v78, v77, v75 from aggJoin7987196901516666228 join aggView8076130172808768535 using(v49));
create or replace view aggJoin1289517206216138950 as (
with aggView2324737554041749424 as (select v1, MIN(v2) as v73 from aggView434208026722433970 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView2324737554041749424 where mc1.company_id=aggView2324737554041749424.v1);
create or replace view aggJoin7001037372425120896 as (
with aggView6919142511283122544 as (select v61, MIN(v43) as v76 from aggView429801614621913416 group by v61)
select v49, v61, v23, v78 as v78, v77 as v77, v75 as v75, v76 from aggJoin44201275952412698 join aggView6919142511283122544 using(v61));
create or replace view aggJoin3841798581061759894 as (
with aggView2836764931006141407 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v78, v77, v75, v76 from aggJoin7001037372425120896 join aggView2836764931006141407 using(v23));
create or replace view aggJoin3204181386861532778 as (
with aggView7006731228816877429 as (select v49, MIN(v73) as v73 from aggJoin1289517206216138950 group by v49,v73)
select v61, v78 as v78, v77 as v77, v75 as v75, v76 as v76, v73 from aggJoin3841798581061759894 join aggView7006731228816877429 using(v49));
create or replace view aggJoin2752339603428880028 as (
with aggView8617563327450748294 as (select v61, MIN(v78) as v78, MIN(v77) as v77, MIN(v75) as v75, MIN(v76) as v76, MIN(v73) as v73 from aggJoin3204181386861532778 group by v61,v73,v75,v77,v76,v78)
select company_id as v8, v78, v77, v75, v76, v73 from movie_companies as mc2, aggView8617563327450748294 where mc2.movie_id=aggView8617563327450748294.v61);
create or replace view aggJoin6067212517898081498 as (
with aggView1369291233687582334 as (select v8, MIN(v78) as v78, MIN(v77) as v77, MIN(v75) as v75, MIN(v76) as v76, MIN(v73) as v73 from aggJoin2752339603428880028 group by v8,v73,v75,v77,v76,v78)
select v9, v78, v77, v75, v76, v73 from aggView5579070201513237294 join aggView1369291233687582334 using(v8));
select MIN(v73) as v73,MIN(v9) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin6067212517898081498;
