create or replace view aggView5108562418517730498 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin3710817090183800099 as (
with aggView6549848904468993628 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6549848904468993628 where mi_idx.info_type_id=aggView6549848904468993628.v12 and info<'7.0');
create or replace view aggView1640575463701017381 as select v37, v32 from aggJoin3710817090183800099 group by v37,v32;
create or replace view aggJoin4552621596590976339 as (
with aggView6858608683979704807 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView6858608683979704807 where t.kind_id=aggView6858608683979704807.v17 and production_year>2009);
create or replace view aggView7695988095895083266 as select v38, v37 from aggJoin4552621596590976339 group by v38,v37;
create or replace view aggJoin7090638413380818327 as (
with aggView2547683434491306563 as (select v37, MIN(v32) as v50 from aggView1640575463701017381 group by v37)
select v38, v37, v50 from aggView7695988095895083266 join aggView2547683434491306563 using(v37));
create or replace view aggJoin4856347842400485913 as (
with aggView2475299176198627950 as (select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin7090638413380818327 group by v37,v50)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v50, v51 from movie_companies as mc, aggView2475299176198627950 where mc.movie_id=aggView2475299176198627950.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1721217016856626167 as (
with aggView8464318503069030567 as (select id as v8 from company_type as ct)
select v37, v1, v23, v50, v51 from aggJoin4856347842400485913 join aggView8464318503069030567 using(v8));
create or replace view aggJoin2752113580146747805 as (
with aggView4576752302323372854 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4576752302323372854 where mi.info_type_id=aggView4576752302323372854.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin8461689941858341392 as (
with aggView6774969393024114423 as (select v37 from aggJoin2752113580146747805 group by v37)
select v37, v1, v23, v50 as v50, v51 as v51 from aggJoin1721217016856626167 join aggView6774969393024114423 using(v37));
create or replace view aggJoin2336783253755148664 as (
with aggView4302041430902288910 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView4302041430902288910 where mk.keyword_id=aggView4302041430902288910.v14);
create or replace view aggJoin5919394667183581619 as (
with aggView3483126533537281257 as (select v37 from aggJoin2336783253755148664 group by v37)
select v1, v23, v50 as v50, v51 as v51 from aggJoin8461689941858341392 join aggView3483126533537281257 using(v37));
create or replace view aggJoin7879470348891143616 as (
with aggView1253651467452418744 as (select v1, MIN(v50) as v50, MIN(v51) as v51 from aggJoin5919394667183581619 group by v1,v50,v51)
select v2, v50, v51 from aggView5108562418517730498 join aggView1253651467452418744 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin7879470348891143616;
