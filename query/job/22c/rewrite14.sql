create or replace view aggJoin6010355541737051393 as (
with aggView9056842704341188255 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView9056842704341188255 where mc.company_id=aggView9056842704341188255.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1737347883536999872 as (
with aggView8299926323589961252 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin6010355541737051393 join aggView8299926323589961252 using(v8));
create or replace view aggJoin5771179041386456750 as (
with aggView3035492977869211786 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView3035492977869211786 where t.kind_id=aggView3035492977869211786.v17 and production_year>2005);
create or replace view aggJoin4540425289719332190 as (
with aggView2110561255647741056 as (select v37, MIN(v38) as v51 from aggJoin5771179041386456750 group by v37)
select movie_id as v37, info_type_id as v10, info as v27, v51 from movie_info as mi, aggView2110561255647741056 where mi.movie_id=aggView2110561255647741056.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1869873518849447858 as (
with aggView2969513048876721031 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2969513048876721031 where mi_idx.info_type_id=aggView2969513048876721031.v12 and info<'8.5');
create or replace view aggJoin7218238670921772577 as (
with aggView2888769042927730089 as (select v37, MIN(v32) as v50 from aggJoin1869873518849447858 group by v37)
select v37, v23, v49 as v49, v50 from aggJoin1737347883536999872 join aggView2888769042927730089 using(v37));
create or replace view aggJoin455161794476940026 as (
with aggView5020278958518729321 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin7218238670921772577 group by v37,v49,v50)
select v37, v10, v27, v51 as v51, v49, v50 from aggJoin4540425289719332190 join aggView5020278958518729321 using(v37));
create or replace view aggJoin3880584341759177240 as (
with aggView3128245325793086770 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v51, v49, v50 from aggJoin455161794476940026 join aggView3128245325793086770 using(v10));
create or replace view aggJoin817542225024945180 as (
with aggView4634316205908897098 as (select v37, MIN(v51) as v51, MIN(v49) as v49, MIN(v50) as v50 from aggJoin3880584341759177240 group by v37,v49,v51,v50)
select keyword_id as v14, v51, v49, v50 from movie_keyword as mk, aggView4634316205908897098 where mk.movie_id=aggView4634316205908897098.v37);
create or replace view aggJoin2780922448780791639 as (
with aggView1222202279522221390 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v51, v49, v50 from aggJoin817542225024945180 join aggView1222202279522221390 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin2780922448780791639;
