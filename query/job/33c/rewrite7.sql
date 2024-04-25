create or replace view aggJoin3100127508047039755 as (
with aggView1160003502701070681 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView1160003502701070681 where mc1.company_id=aggView1160003502701070681.v1);
create or replace view aggJoin3545874177740641722 as (
with aggView3252389424455881342 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView3252389424455881342 where mc2.company_id=aggView3252389424455881342.v8);
create or replace view aggJoin4275451392285670892 as (
with aggView4870765856222304867 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView4870765856222304867 where mi_idx1.info_type_id=aggView4870765856222304867.v15);
create or replace view aggJoin8741846349236821024 as (
with aggView6068464633987370389 as (select v49, MIN(v38) as v75 from aggJoin4275451392285670892 group by v49)
select v49, v73 as v73, v75 from aggJoin3100127508047039755 join aggView6068464633987370389 using(v49));
create or replace view aggJoin7465713311742115522 as (
with aggView169320381499853151 as (select v49, MIN(v73) as v73, MIN(v75) as v75 from aggJoin8741846349236821024 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v73, v75 from movie_link as ml, aggView169320381499853151 where ml.movie_id=aggView169320381499853151.v49);
create or replace view aggJoin3085090589810422923 as (
with aggView1739280159801183495 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView1739280159801183495 where t1.kind_id=aggView1739280159801183495.v19);
create or replace view aggJoin6594758536845197801 as (
with aggView2686804155767600743 as (select v49, MIN(v50) as v77 from aggJoin3085090589810422923 group by v49)
select v61, v23, v73 as v73, v75 as v75, v77 from aggJoin7465713311742115522 join aggView2686804155767600743 using(v49));
create or replace view aggJoin7833925294622193527 as (
with aggView7755835098383827785 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView7755835098383827785 where t2.kind_id=aggView7755835098383827785.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin1435324633234254783 as (
with aggView6105248584317888651 as (select v61, MIN(v62) as v78 from aggJoin7833925294622193527 group by v61)
select movie_id as v61, info_type_id as v17, info as v43, v78 from movie_info_idx as mi_idx2, aggView6105248584317888651 where mi_idx2.movie_id=aggView6105248584317888651.v61 and info<'3.5');
create or replace view aggJoin2192633819516363573 as (
with aggView8153654555140758198 as (select id as v17 from info_type as it2 where info= 'rating')
select v61, v43, v78 from aggJoin1435324633234254783 join aggView8153654555140758198 using(v17));
create or replace view aggJoin5373401452821804515 as (
with aggView2903221677504787856 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v73, v75, v77 from aggJoin6594758536845197801 join aggView2903221677504787856 using(v23));
create or replace view aggJoin8972429179032831657 as (
with aggView963157961657273219 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin5373401452821804515 group by v61)
select v61, v43, v78 as v78, v73, v75, v77 from aggJoin2192633819516363573 join aggView963157961657273219 using(v61));
create or replace view aggJoin2576543629070419732 as (
with aggView313278469973927161 as (select v61, MIN(v78) as v78, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77, MIN(v43) as v76 from aggJoin8972429179032831657 group by v61)
select v74 as v74, v78, v73, v75, v77, v76 from aggJoin3545874177740641722 join aggView313278469973927161 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin2576543629070419732;
