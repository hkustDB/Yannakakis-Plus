create or replace view aggJoin6993970496165806169 as (
with aggView4716729170363416616 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView4716729170363416616 where mc.company_id=aggView4716729170363416616.v13);
create or replace view aggJoin4029633725597605059 as (
with aggView6598782228144438216 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView6598782228144438216 where mk.keyword_id=aggView6598782228144438216.v24);
create or replace view aggJoin551235742094384769 as (
with aggView3198129214376838940 as (select id as v20 from company_type as ct)
select v40 from aggJoin6993970496165806169 join aggView3198129214376838940 using(v20));
create or replace view aggJoin4068410807413648810 as (
with aggView7570236325309041776 as (select v40 from aggJoin4029633725597605059 group by v40)
select v40 from aggJoin551235742094384769 join aggView7570236325309041776 using(v40));
create or replace view aggJoin415140344234194411 as (
with aggView7839970923299526091 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin4068410807413648810 join aggView7839970923299526091 using(v40));
create or replace view aggJoin8334223945868578686 as (
with aggView3859113800077539416 as (select v40 from aggJoin415140344234194411 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView3859113800077539416 where t.id=aggView3859113800077539416.v40 and production_year>1990);
create or replace view aggView1679840160830941229 as select v41, v40 from aggJoin8334223945868578686 group by v41,v40;
create or replace view aggJoin6655560590845695936 as (
with aggView2591635649075767349 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView2591635649075767349 where mi.info_type_id=aggView2591635649075767349.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggView5972051423414480007 as select v40, v35 from aggJoin6655560590845695936 group by v40,v35;
create or replace view aggJoin2049883133768569288 as (
with aggView1729092559331725046 as (select v40, MIN(v41) as v53 from aggView1679840160830941229 group by v40)
select v35, v53 from aggView5972051423414480007 join aggView1729092559331725046 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin2049883133768569288;
