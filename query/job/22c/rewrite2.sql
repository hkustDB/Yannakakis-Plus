create or replace view aggView2942717829087293194 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin5930004317548414250 as (
with aggView8810591828500356548 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView8810591828500356548 where t.kind_id=aggView8810591828500356548.v17 and production_year>2005);
create or replace view aggJoin7821396183431740172 as (
with aggView3645871673646731693 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3645871673646731693 where mi_idx.info_type_id=aggView3645871673646731693.v12 and info<'8.5');
create or replace view aggView2395072940093211978 as select v37, v32 from aggJoin7821396183431740172 group by v37,v32;
create or replace view aggJoin6928670483397440631 as (
with aggView647467992564222014 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView647467992564222014 where mk.keyword_id=aggView647467992564222014.v14);
create or replace view aggJoin2958606840896001984 as (
with aggView5403454189919457968 as (select v37 from aggJoin6928670483397440631 group by v37)
select v37, v38, v41 from aggJoin5930004317548414250 join aggView5403454189919457968 using(v37));
create or replace view aggView4465127066370271879 as select v38, v37 from aggJoin2958606840896001984 group by v38,v37;
create or replace view aggJoin6596799118065939887 as (
with aggView4772047334070088906 as (select v37, MIN(v38) as v51 from aggView4465127066370271879 group by v37)
select v37, v32, v51 from aggView2395072940093211978 join aggView4772047334070088906 using(v37));
create or replace view aggJoin2551197252379589424 as (
with aggView2826029657322979992 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin6596799118065939887 group by v37,v51)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v51, v50 from movie_companies as mc, aggView2826029657322979992 where mc.movie_id=aggView2826029657322979992.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6130403617029981872 as (
with aggView3002240720196129021 as (select id as v8 from company_type as ct)
select v37, v1, v23, v51, v50 from aggJoin2551197252379589424 join aggView3002240720196129021 using(v8));
create or replace view aggJoin5868879232758855129 as (
with aggView4167010198053296460 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4167010198053296460 where mi.info_type_id=aggView4167010198053296460.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4315474015457865645 as (
with aggView7606861844834647001 as (select v37 from aggJoin5868879232758855129 group by v37)
select v1, v23, v51 as v51, v50 as v50 from aggJoin6130403617029981872 join aggView7606861844834647001 using(v37));
create or replace view aggJoin958604969719689200 as (
with aggView5752169552025013248 as (select v1, MIN(v51) as v51, MIN(v50) as v50 from aggJoin4315474015457865645 group by v1,v51,v50)
select v2, v51, v50 from aggView2942717829087293194 join aggView5752169552025013248 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin958604969719689200;
