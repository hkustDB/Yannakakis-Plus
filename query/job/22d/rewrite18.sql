create or replace view aggJoin2185532347392731097 as (
with aggView7943502859276136989 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView7943502859276136989 where mc.company_id=aggView7943502859276136989.v1);
create or replace view aggJoin5066817411015660807 as (
with aggView2846590762995640088 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView2846590762995640088 where mi.info_type_id=aggView2846590762995640088.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin6758384144749991354 as (
with aggView8515978473470137745 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView8515978473470137745 where mk.keyword_id=aggView8515978473470137745.v14);
create or replace view aggJoin8770913378630458723 as (
with aggView6086999984171146208 as (select v37 from aggJoin5066817411015660807 group by v37)
select v37, v8, v49 as v49 from aggJoin2185532347392731097 join aggView6086999984171146208 using(v37));
create or replace view aggJoin3825678277239444933 as (
with aggView2673732136136831530 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2673732136136831530 where mi_idx.info_type_id=aggView2673732136136831530.v12 and info<'8.5');
create or replace view aggJoin1647239022092148855 as (
with aggView2471295592801318787 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin8770913378630458723 join aggView2471295592801318787 using(v8));
create or replace view aggJoin3828061660914267226 as (
with aggView6387472837037680885 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView6387472837037680885 where t.kind_id=aggView6387472837037680885.v17 and production_year>2005);
create or replace view aggJoin1302394973303978592 as (
with aggView8459302433837959828 as (select v37, MIN(v38) as v51 from aggJoin3828061660914267226 group by v37)
select v37, v32, v51 from aggJoin3825678277239444933 join aggView8459302433837959828 using(v37));
create or replace view aggJoin6591291778612681399 as (
with aggView6536941083912703025 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin1302394973303978592 group by v37,v51)
select v37, v49 as v49, v51, v50 from aggJoin1647239022092148855 join aggView6536941083912703025 using(v37));
create or replace view aggJoin8010738618228726673 as (
with aggView6016141217852454564 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v50) as v50 from aggJoin6591291778612681399 group by v37,v51,v50,v49)
select v49, v51, v50 from aggJoin6758384144749991354 join aggView6016141217852454564 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin8010738618228726673;
