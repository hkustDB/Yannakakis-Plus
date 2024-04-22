create or replace view aggJoin3473973844288254391 as (
with aggView2042319263199193217 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView2042319263199193217 where mc.company_id=aggView2042319263199193217.v1);
create or replace view aggJoin3568325872452693775 as (
with aggView8811111902165532479 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView8811111902165532479 where mi.info_type_id=aggView8811111902165532479.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7140230036006701460 as (
with aggView5879083628068653704 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView5879083628068653704 where mk.keyword_id=aggView5879083628068653704.v14);
create or replace view aggJoin4013675458617761111 as (
with aggView5336010832018539952 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin3473973844288254391 join aggView5336010832018539952 using(v8));
create or replace view aggJoin8019136016308593633 as (
with aggView2410040391658565674 as (select v37, MIN(v49) as v49 from aggJoin4013675458617761111 group by v37,v49)
select v37, v27, v49 from aggJoin3568325872452693775 join aggView2410040391658565674 using(v37));
create or replace view aggJoin5306359115214750252 as (
with aggView3006014693467460118 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3006014693467460118 where mi_idx.info_type_id=aggView3006014693467460118.v12 and info<'8.5');
create or replace view aggJoin1777545255477472780 as (
with aggView461094423096945449 as (select v37, MIN(v32) as v50 from aggJoin5306359115214750252 group by v37)
select v37, v27, v49 as v49, v50 from aggJoin8019136016308593633 join aggView461094423096945449 using(v37));
create or replace view aggJoin7129168817272124730 as (
with aggView393521040680039231 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin1777545255477472780 group by v37,v50,v49)
select v37, v49, v50 from aggJoin7140230036006701460 join aggView393521040680039231 using(v37));
create or replace view aggJoin9182664852988982080 as (
with aggView1205396549641766428 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView1205396549641766428 where t.kind_id=aggView1205396549641766428.v17 and production_year>2005);
create or replace view aggJoin8094880854434133402 as (
with aggView2954937105253623137 as (select v37, MIN(v38) as v51 from aggJoin9182664852988982080 group by v37)
select v49 as v49, v50 as v50, v51 from aggJoin7129168817272124730 join aggView2954937105253623137 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin8094880854434133402;
