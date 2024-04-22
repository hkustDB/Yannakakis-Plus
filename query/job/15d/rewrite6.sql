create or replace view aggView8192513306469337432 as select movie_id as v40, title as v3 from aka_title as aka_t group by movie_id,title;
create or replace view aggJoin6774715301994768549 as (
with aggView482500986646939782 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView482500986646939782 where mc.company_id=aggView482500986646939782.v13);
create or replace view aggJoin4266050443104478764 as (
with aggView7617019186495319175 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView7617019186495319175 where mi.info_type_id=aggView7617019186495319175.v22 and note LIKE '%internet%');
create or replace view aggJoin7862133139566557958 as (
with aggView8742538660779686737 as (select v40 from aggJoin4266050443104478764 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView8742538660779686737 where t.id=aggView8742538660779686737.v40 and production_year>1990);
create or replace view aggJoin4953424347259534088 as (
with aggView8574438173893208112 as (select id as v20 from company_type as ct)
select v40 from aggJoin6774715301994768549 join aggView8574438173893208112 using(v20));
create or replace view aggJoin8744152531294225719 as (
with aggView130275304726698481 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView130275304726698481 where mk.keyword_id=aggView130275304726698481.v24);
create or replace view aggJoin6779800609059834128 as (
with aggView8711258999859268709 as (select v40 from aggJoin8744152531294225719 group by v40)
select v40 from aggJoin4953424347259534088 join aggView8711258999859268709 using(v40));
create or replace view aggJoin322342141805238382 as (
with aggView469058764693825560 as (select v40 from aggJoin6779800609059834128 group by v40)
select v40, v41, v44 from aggJoin7862133139566557958 join aggView469058764693825560 using(v40));
create or replace view aggView5113172368593407539 as select v40, v41 from aggJoin322342141805238382 group by v40,v41;
create or replace view aggJoin1769830157687546777 as (
with aggView2383280045669425212 as (select v40, MIN(v3) as v52 from aggView8192513306469337432 group by v40)
select v41, v52 from aggView5113172368593407539 join aggView2383280045669425212 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin1769830157687546777;
