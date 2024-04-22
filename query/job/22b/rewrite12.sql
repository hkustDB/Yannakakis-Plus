create or replace view aggJoin8262213703191969475 as (
with aggView1652260671154696122 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView1652260671154696122 where mc.company_id=aggView1652260671154696122.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2619110300287059086 as (
with aggView6890354318730491726 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6890354318730491726 where mi_idx.info_type_id=aggView6890354318730491726.v12 and info<'7.0');
create or replace view aggJoin6752139781224836135 as (
with aggView2041813709349589269 as (select v37, MIN(v32) as v50 from aggJoin2619110300287059086 group by v37)
select movie_id as v37, info_type_id as v10, info as v27, v50 from movie_info as mi, aggView2041813709349589269 where mi.movie_id=aggView2041813709349589269.v37 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin928756647645924249 as (
with aggView2924432822737868961 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin8262213703191969475 join aggView2924432822737868961 using(v8));
create or replace view aggJoin4681428032204707391 as (
with aggView619866617962798962 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView619866617962798962 where t.kind_id=aggView619866617962798962.v17 and production_year>2009);
create or replace view aggJoin7842996243924413240 as (
with aggView6913187339590267975 as (select v37, MIN(v38) as v51 from aggJoin4681428032204707391 group by v37)
select movie_id as v37, keyword_id as v14, v51 from movie_keyword as mk, aggView6913187339590267975 where mk.movie_id=aggView6913187339590267975.v37);
create or replace view aggJoin4783614967694599980 as (
with aggView7832497996589050945 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v50 from aggJoin6752139781224836135 join aggView7832497996589050945 using(v10));
create or replace view aggJoin622247593263474813 as (
with aggView8961682031615355680 as (select v37, MIN(v50) as v50 from aggJoin4783614967694599980 group by v37,v50)
select v37, v23, v49 as v49, v50 from aggJoin928756647645924249 join aggView8961682031615355680 using(v37));
create or replace view aggJoin8380158089915067037 as (
with aggView7623235586776625104 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin622247593263474813 group by v37,v49,v50)
select v14, v51 as v51, v49, v50 from aggJoin7842996243924413240 join aggView7623235586776625104 using(v37));
create or replace view aggJoin7799667063746151086 as (
with aggView3898127745770767853 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v51, v49, v50 from aggJoin8380158089915067037 join aggView3898127745770767853 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin7799667063746151086;
