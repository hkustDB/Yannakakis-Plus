create or replace view aggJoin5628140013418568319 as (
with aggView230994071847888698 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView230994071847888698 where mc.company_id=aggView230994071847888698.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4678467425913916427 as (
with aggView370827482433352257 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin5628140013418568319 join aggView370827482433352257 using(v8));
create or replace view aggJoin3687110339248955109 as (
with aggView2534164729619505899 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2534164729619505899 where mi_idx.info_type_id=aggView2534164729619505899.v12 and info<'7.0');
create or replace view aggJoin7677724088422444767 as (
with aggView5393506091167962535 as (select v37, MIN(v32) as v50 from aggJoin3687110339248955109 group by v37)
select movie_id as v37, keyword_id as v14, v50 from movie_keyword as mk, aggView5393506091167962535 where mk.movie_id=aggView5393506091167962535.v37);
create or replace view aggJoin8870662752748654728 as (
with aggView6970589605948461458 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView6970589605948461458 where t.kind_id=aggView6970589605948461458.v17 and production_year>2008);
create or replace view aggJoin4110069526428441176 as (
with aggView3750235390966621337 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView3750235390966621337 where mi.info_type_id=aggView3750235390966621337.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin3129794847597202250 as (
with aggView6849922331001938794 as (select v37, MIN(v49) as v49 from aggJoin4678467425913916427 group by v37,v49)
select v37, v27, v49 from aggJoin4110069526428441176 join aggView6849922331001938794 using(v37));
create or replace view aggJoin3695884748701379593 as (
with aggView5158185192084053233 as (select v37, MIN(v49) as v49 from aggJoin3129794847597202250 group by v37,v49)
select v37, v38, v41, v49 from aggJoin8870662752748654728 join aggView5158185192084053233 using(v37));
create or replace view aggJoin8183683225213355028 as (
with aggView1544603859008249788 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin3695884748701379593 group by v37,v49)
select v14, v50 as v50, v49, v51 from aggJoin7677724088422444767 join aggView1544603859008249788 using(v37));
create or replace view aggJoin5071981401267951339 as (
with aggView6358165839507817411 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v50, v49, v51 from aggJoin8183683225213355028 join aggView6358165839507817411 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin5071981401267951339;
