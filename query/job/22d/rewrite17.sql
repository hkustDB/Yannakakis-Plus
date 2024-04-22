create or replace view aggView2213644957633658865 as select name as v2, id as v1 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin67328828489846058 as (
with aggView1137489576849947429 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView1137489576849947429 where mi_idx.info_type_id=aggView1137489576849947429.v12);
create or replace view aggJoin3970450507808124198 as (
with aggView8216278526080645377 as (select v32, v37 from aggJoin67328828489846058 group by v32,v37)
select v37, v32 from aggView8216278526080645377 where v32<'8.5');
create or replace view aggJoin8076513883107213120 as (
with aggView2714518245688584870 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView2714518245688584870 where t.kind_id=aggView2714518245688584870.v17 and production_year>2005);
create or replace view aggView4103614582492903197 as select v37, v38 from aggJoin8076513883107213120 group by v37,v38;
create or replace view aggJoin6017668065727580724 as (
with aggView1657899227591761378 as (select v1, MIN(v2) as v49 from aggView2213644957633658865 group by v1)
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView1657899227591761378 where mc.company_id=aggView1657899227591761378.v1);
create or replace view aggJoin2145254303077166121 as (
with aggView7828473296833887104 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView7828473296833887104 where mi.info_type_id=aggView7828473296833887104.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin5136679662089130974 as (
with aggView5436840190427639814 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView5436840190427639814 where mk.keyword_id=aggView5436840190427639814.v14);
create or replace view aggJoin2524978987864002530 as (
with aggView7695282032337465394 as (select v37 from aggJoin2145254303077166121 group by v37)
select v37, v8, v49 as v49 from aggJoin6017668065727580724 join aggView7695282032337465394 using(v37));
create or replace view aggJoin7715050343913026560 as (
with aggView589529497636865309 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin2524978987864002530 join aggView589529497636865309 using(v8));
create or replace view aggJoin7599299333448760381 as (
with aggView7832098468180881961 as (select v37 from aggJoin5136679662089130974 group by v37)
select v37, v49 as v49 from aggJoin7715050343913026560 join aggView7832098468180881961 using(v37));
create or replace view aggJoin5224165452397891012 as (
with aggView1534173079221811835 as (select v37, MIN(v49) as v49 from aggJoin7599299333448760381 group by v37,v49)
select v37, v38, v49 from aggView4103614582492903197 join aggView1534173079221811835 using(v37));
create or replace view aggJoin6993039210724663935 as (
with aggView8125099811683570565 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin5224165452397891012 group by v37,v49)
select v32, v49, v51 from aggJoin3970450507808124198 join aggView8125099811683570565 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin6993039210724663935;
