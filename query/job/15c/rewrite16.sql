create or replace view aggJoin6315488781242723627 as (
with aggView6629911952932251605 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView6629911952932251605 where mc.company_id=aggView6629911952932251605.v13);
create or replace view aggJoin7299216469113423318 as (
with aggView4784923613677081586 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView4784923613677081586 where mk.keyword_id=aggView4784923613677081586.v24);
create or replace view aggJoin4779046040351717995 as (
with aggView3057865008741394262 as (select id as v20 from company_type as ct)
select v40 from aggJoin6315488781242723627 join aggView3057865008741394262 using(v20));
create or replace view aggJoin5760465305946342493 as (
with aggView5833785883317102330 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView5833785883317102330 where mi.info_type_id=aggView5833785883317102330.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin6241285904956262460 as (
with aggView6638310102229305654 as (select v40, MIN(v35) as v52 from aggJoin5760465305946342493 group by v40)
select v40, v52 from aggJoin4779046040351717995 join aggView6638310102229305654 using(v40));
create or replace view aggJoin5963520407353922840 as (
with aggView2747653828670420961 as (select v40, MIN(v52) as v52 from aggJoin6241285904956262460 group by v40,v52)
select movie_id as v40, v52 from aka_title as aka_t, aggView2747653828670420961 where aka_t.movie_id=aggView2747653828670420961.v40);
create or replace view aggJoin5317888535125691811 as (
with aggView6474149411146748692 as (select v40, MIN(v52) as v52 from aggJoin5963520407353922840 group by v40,v52)
select id as v40, title as v41, production_year as v44, v52 from title as t, aggView6474149411146748692 where t.id=aggView6474149411146748692.v40 and production_year>1990);
create or replace view aggJoin6740858294771131046 as (
with aggView2803596829863586521 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin5317888535125691811 group by v40,v52)
select v52, v53 from aggJoin7299216469113423318 join aggView2803596829863586521 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin6740858294771131046;
