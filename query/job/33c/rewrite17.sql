create or replace view aggJoin454590577757545522 as (
with aggView7502440658355329482 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView7502440658355329482 where mc1.company_id=aggView7502440658355329482.v1);
create or replace view aggJoin6548218075479226425 as (
with aggView1336422179681702346 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView1336422179681702346 where mc2.company_id=aggView1336422179681702346.v8);
create or replace view aggJoin4105211159485473221 as (
with aggView5382476163885824906 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView5382476163885824906 where mi_idx1.info_type_id=aggView5382476163885824906.v15);
create or replace view aggJoin138648865987213149 as (
with aggView2462594662503844155 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView2462594662503844155 where t2.kind_id=aggView2462594662503844155.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin4770898499998876724 as (
with aggView3962231359060817167 as (select v61, MIN(v62) as v78 from aggJoin138648865987213149 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v78 from movie_link as ml, aggView3962231359060817167 where ml.linked_movie_id=aggView3962231359060817167.v61);
create or replace view aggJoin2300580356843937816 as (
with aggView7043655679098867647 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView7043655679098867647 where t1.kind_id=aggView7043655679098867647.v19);
create or replace view aggJoin4661119186830391804 as (
with aggView839078369458028821 as (select v61, MIN(v74) as v74 from aggJoin6548218075479226425 group by v61)
select v49, v61, v23, v78 as v78, v74 from aggJoin4770898499998876724 join aggView839078369458028821 using(v61));
create or replace view aggJoin3886699732984481751 as (
with aggView1992930904370774868 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView1992930904370774868 where mi_idx2.info_type_id=aggView1992930904370774868.v17 and info<'3.5');
create or replace view aggJoin8393016184016673461 as (
with aggView5831446625819071002 as (select v61, MIN(v43) as v76 from aggJoin3886699732984481751 group by v61)
select v49, v23, v78 as v78, v74 as v74, v76 from aggJoin4661119186830391804 join aggView5831446625819071002 using(v61));
create or replace view aggJoin3942568629510625103 as (
with aggView7062660396447210490 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v78, v74, v76 from aggJoin8393016184016673461 join aggView7062660396447210490 using(v23));
create or replace view aggJoin6097155095692327870 as (
with aggView1268186522848643453 as (select v49, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76 from aggJoin3942568629510625103 group by v49)
select v49, v50, v78, v74, v76 from aggJoin2300580356843937816 join aggView1268186522848643453 using(v49));
create or replace view aggJoin8248833043777887028 as (
with aggView201593073463261362 as (select v49, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76, MIN(v50) as v77 from aggJoin6097155095692327870 group by v49)
select v49, v38, v78, v74, v76, v77 from aggJoin4105211159485473221 join aggView201593073463261362 using(v49));
create or replace view aggJoin7853595148701179261 as (
with aggView1501808282325152915 as (select v49, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76, MIN(v77) as v77, MIN(v38) as v75 from aggJoin8248833043777887028 group by v49)
select v73 as v73, v78, v74, v76, v77, v75 from aggJoin454590577757545522 join aggView1501808282325152915 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin7853595148701179261;
