create or replace view aggView3340530086282769681 as select name as v2, id as v1 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin990434976819038474 as (
with aggView7270396301632952801 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView7270396301632952801 where mi.info_type_id=aggView7270396301632952801.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2932155980927981987 as (
with aggView776674060766297206 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView776674060766297206 where mk.keyword_id=aggView776674060766297206.v14);
create or replace view aggJoin6210421381905526830 as (
with aggView3599037235446144679 as (select v37 from aggJoin2932155980927981987 group by v37)
select movie_id as v37, info_type_id as v12, info as v32 from movie_info_idx as mi_idx, aggView3599037235446144679 where mi_idx.movie_id=aggView3599037235446144679.v37);
create or replace view aggJoin141621789488253918 as (
with aggView2154865898299509552 as (select id as v12 from info_type as it2 where info= 'rating')
select v37, v32 from aggJoin6210421381905526830 join aggView2154865898299509552 using(v12));
create or replace view aggJoin7441654079260427643 as (
with aggView5665497500934091794 as (select v37 from aggJoin990434976819038474 group by v37)
select v37, v32 from aggJoin141621789488253918 join aggView5665497500934091794 using(v37));
create or replace view aggJoin6938474034155547872 as (
with aggView2588544316471269068 as (select v32, v37 from aggJoin7441654079260427643 group by v32,v37)
select v37, v32 from aggView2588544316471269068 where v32<'8.5');
create or replace view aggJoin4769154356271793871 as (
with aggView9007085750679120387 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView9007085750679120387 where t.kind_id=aggView9007085750679120387.v17 and production_year>2005);
create or replace view aggView6835035254395157255 as select v37, v38 from aggJoin4769154356271793871 group by v37,v38;
create or replace view aggJoin5121792182085709889 as (
with aggView429930678138516254 as (select v37, MIN(v38) as v51 from aggView6835035254395157255 group by v37)
select v37, v32, v51 from aggJoin6938474034155547872 join aggView429930678138516254 using(v37));
create or replace view aggJoin8693468472241489835 as (
with aggView8723338801358215848 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin5121792182085709889 group by v37,v51)
select company_id as v1, company_type_id as v8, v51, v50 from movie_companies as mc, aggView8723338801358215848 where mc.movie_id=aggView8723338801358215848.v37);
create or replace view aggJoin5660479843098407293 as (
with aggView8281965079890322248 as (select id as v8 from company_type as ct)
select v1, v51, v50 from aggJoin8693468472241489835 join aggView8281965079890322248 using(v8));
create or replace view aggJoin5750493103621103399 as (
with aggView5543488356137491720 as (select v1, MIN(v51) as v51, MIN(v50) as v50 from aggJoin5660479843098407293 group by v1,v51,v50)
select v2, v51, v50 from aggView3340530086282769681 join aggView5543488356137491720 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin5750493103621103399;
